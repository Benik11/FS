%% import_fsae_excel_to_matlab.m
% =========================================================================
%  Digitální dvojče FSAE Formule — Import parametrů z Excelu do MATLAB
% =========================================================================
%  Skript přečte parametry z FSAE_Pushrod_Parametry.xlsx a přepíše soubor
%  Vehicle_data_dwpushrod.m, poté načte data do workspace a spustí simulaci.
%
%  POUŽITÍ:
%    1. Vyplňte žluté buňky ve sloupci "Value" v Excel souboru.
%    2. Uložte Excel soubor a zavřete ho.
%    3. Spusťte tento skript v MATLAB konzoli: >> import_fsae_excel_to_matlab
%
%  PŘEDPOKLADY:
%    - Excel soubor: FSAE_Pushrod_Parametry.xlsx (ve stejné složce)
%    - MATLAB R2019b nebo novější
%    - Simscape Vehicle Templates nainstalováno (sm_car.slx)
%
%  VÝSTUP:
%    - Aktualizovaný Vehicle_data_dwpushrod.m (PŘEPISUJE SE BEZ ZÁLOHY)
%    - Proměnná Vehicle v MATLAB workspace
%
% Copyright 2026 — FSAE tým / digitální dvojče
% =========================================================================

clc;
fprintf('=================================================================\n');
fprintf(' FSAE Pushrod — Import parametrů z Excelu\n');
fprintf('=================================================================\n\n');

%% ── 0. KONFIGURACE ────────────────────────────────────────────────────────
EXCEL_FILE   = 'FSAE_Pushrod_Parametry.xlsx';    % název Excel souboru
OUTPUT_FILE  = 'Vehicle_data_dwpushrod.m';       % výstupní MATLAB soubor

% Zahrňte cestu k modelu pokud není v path
% addpath('C:\path\to\sm_car_project\Scripts_Data\Data_Vehicle');

%% ── 1. KONTROLA EXISTENCE SOUBORŮ ────────────────────────────────────────
if ~isfile(EXCEL_FILE)
    error('Excel soubor "%s" nebyl nalezen.\nUjistěte se, že je ve stejné složce jako tento skript.\nAktuální složka: %s', ...
          EXCEL_FILE, pwd);
end

fprintf('[1/5] Čtu Excel soubor: %s\n', EXCEL_FILE);

%% ── 2. ČTENÍ DAT Z EXCELU ────────────────────────────────────────────────
% Definice listů a jejich sloupců (A=Název, B=Cesta, C=Hodnota, D=Jednotky)

sheets = {'Body', 'Aero', 'SuspA1_Linkage_F', 'SuspA1_ARB_Steer', ...
          'SuspA2_Linkage_R', 'Spring_Damper', 'Tires', 'Powertrain', 'Brakes'};

% Slovník: matlab_path -> hodnota (string nebo číslo)
params = containers.Map('KeyType','char','ValueType','any');

for s = 1:length(sheets)
    sheet_name = sheets{s};
    try
        % Přečteme celý list jako tabulku
        opts = detectImportOptions(EXCEL_FILE, 'Sheet', sheet_name, ...
                                   'DataRange', 'A1', 'VariableNamesRange', '');
        raw = readcell(EXCEL_FILE, 'Sheet', sheet_name, 'Range', 'A1:F200', ...
                       'UseExcel', false);
        
        % Procházíme řádky — hledáme řádky kde sloupec B obsahuje 'Vehicle.'
        for row = 1:size(raw, 1)
            if size(raw,2) < 3, continue; end
            
            matlab_path = raw{row, 2};
            value_raw   = raw{row, 3};
            
            % Přeskočit prázdné nebo záhlavní řádky
            if ~ischar(matlab_path) && ~isstring(matlab_path), continue; end
            matlab_path = char(matlab_path);
            if ~startsWith(matlab_path, 'Vehicle.'), continue; end
            
            % Bezpečná kontrola prázdných a chybějících hodnot
            if isempty(value_raw) || any(ismissing(value_raw(:))), continue; end
            
            params(matlab_path) = value_raw;
        end
        
        fprintf('   List "%s": OK\n', sheet_name);
    catch ME
        warning('Nepodařilo se načíst list "%s": %s', sheet_name, ME.message);
    end
end

fprintf('[1/5] Načteno %d parametrů.\n\n', params.Count);

%% ── 3. NAČTENÍ ZÁKLADNÍHO .m SOUBORU ─────────────────────────────────────
fprintf('[2/5] Načítám základní soubor: %s\n', OUTPUT_FILE);

if ~isfile(OUTPUT_FILE)
    error('Soubor "%s" nebyl nalezen.\nUjistěte se, že je dostupný v path nebo aktuální složce.', OUTPUT_FILE);
end

% Přečteme originální soubor jako text
fid = fopen(OUTPUT_FILE, 'r', 'n', 'UTF-8');
if fid == -1
    error('Nelze otevřít soubor %s pro čtení.', OUTPUT_FILE);
end
orig_lines = {};
while ~feof(fid)
    orig_lines{end+1} = fgetl(fid); %#ok<AGROW>
end
fclose(fid);

fprintf('   Načteno %d řádků.\n', length(orig_lines));

%% ── 4. APLIKACE PARAMETRŮ ────────────────────────────────────────────────
fprintf('[3/5] Aplikuji parametry z Excelu...\n');

new_lines = orig_lines;
modified_count = 0;
param_keys = keys(params);

for p = 1:length(param_keys)
    matlab_path = param_keys{p};
    new_value   = params(matlab_path);
    
    % Přeskočit vzorce Excelu (začínající '=')
    if ischar(new_value) && startsWith(new_value, '='), continue; end
    
    % Konverze hodnoty na MATLAB string
    value_str = fsae_value_to_matlab_str(new_value);
    if isempty(value_str), continue; end
    
    search_pattern = [matlab_path ' ='];
    
    for ln = 1:length(new_lines)
        line = new_lines{ln};
        trimmed = strtrim(line);
        
        if startsWith(trimmed, search_pattern)
            % Extrahujeme odsazení
            indent = regexp(line, '^\s*', 'match', 'once');
            if isempty(indent), indent = ''; end
            
            % Očištění původního řádku od komentářů pro logiku mazání
            clean_orig = strtrim(regexprep(line, '%.*', ''));
            
            % Přepíšeme řádek novou hodnotou (vždy na jeden řádek)
            new_lines{ln} = sprintf('%s%s = %s;', indent, matlab_path, value_str);
            
            % Ošetření víceřádkových definic (matice nebo řádky s '...')
            % Pokud původní zápis nekončil středníkem, pokračoval na dalších řádcích
            if ~endsWith(clean_orig, ';') || contains(clean_orig, '...') || (contains(clean_orig, '[') && ~contains(clean_orig, ']'))
                next_ln = ln + 1;
                block_text = clean_orig;
                
                while next_ln <= length(new_lines)
                    check_line = new_lines{next_ln};
                    clean_next = strtrim(regexprep(check_line, '%.*', ''));
                    
                    % Ochranná pojistka: nikdy nesmažeme další parametr
                    if startsWith(strtrim(check_line), 'Vehicle.')
                        break;
                    end
                    
                    block_text = [block_text ' ' clean_next]; %#ok<AGROW>
                    new_lines{next_ln} = ''; % Vymažeme starý zbytek matice
                    
                    % Počítání závorek pro bezpečné nalezení skutečného konce
                    brackets_open = length(strfind(block_text, '[')) + length(strfind(block_text, '{'));
                    brackets_close = length(strfind(block_text, ']')) + length(strfind(block_text, '}'));
                    
                    if endsWith(clean_next, ';') && (brackets_open == brackets_close)
                        break;
                    end
                    
                    next_ln = next_ln + 1;
                end
            end
            
            modified_count = modified_count + 1;
            break;
        end
    end
end

fprintf('   Upraven počet parametrů: %d\n', modified_count);

%% ── 5. ZÁPIS UPRAVENÉHO SOUBORU ──────────────────────────────────────────
fprintf('[4/5] Zapisuji aktualizovaný soubor...\n');

% Přidáme hlavičku s datem importu
header = {
    sprintf('%% AUTOMATICKY GENEROVÁNO skriptem import_fsae_excel_to_matlab.m')
    sprintf('%% Datum importu: %s', datestr(now, 'dd.mm.yyyy HH:MM:SS'))
    sprintf('%% Zdroj parametrů: %s', EXCEL_FILE)
    sprintf('%% ----------------------------------------------------------------')
    ''
};

% Přepíšeme soubor rovnou bez tvorby zálohy
fid = fopen(OUTPUT_FILE, 'w', 'n', 'UTF-8');
if fid == -1
    error('Nelze otevřít soubor %s pro zápis.', OUTPUT_FILE);
end

% Zapíšeme hlavičku
for h = 1:length(header)
    fprintf(fid, '%s\n', header{h});
end

% Zapíšeme upravené řádky (přeskočíme prázdné, které jsme vymazali u matic)
for ln = 1:length(new_lines)
    % Pokud řádek není úplně prázdný string (naše smazané matice)
    if ischar(new_lines{ln}) && ~(isempty(new_lines{ln}) && ln > 1) 
        fprintf(fid, '%s\n', new_lines{ln});
    end
end

fclose(fid);
fprintf('   Soubor úspěšně přepsán: %s\n', OUTPUT_FILE);

%% ── 6. NAČTENÍ DO WORKSPACE A VALIDACE ──────────────────────────────────
fprintf('[5/5] Načítám Vehicle strukturu do workspace...\n');

try
    run(OUTPUT_FILE);
    fprintf('   Vehicle.config = %s\n', Vehicle.config);
    fprintf('   Hmotnost karoserie: %.1f kg\n', Vehicle.Chassis.Body.m.Value);
    fprintf('   Rozvor náprav: %.3f m\n', abs(Vehicle.Chassis.Body.sAxle2.Value(1)));
    fprintf('   Přední tuhost pružiny: %.0f N/m\n', Vehicle.Chassis.Spring.Axle1.K.Value);
    fprintf('   Zadní tuhost pružiny:  %.0f N/m\n', Vehicle.Chassis.Spring.Axle2.K.Value);
    fprintf('   Přední tlumení: %.0f N/(m/s)\n', Vehicle.Chassis.Damper.Axle1.Damping.d.Value);
    fprintf('   Přední CL aero: %.2f\n', Vehicle.Chassis.Aero.CL.Value);
    fprintf('   Přední motor max. Mq: %.0f Nm\n', Vehicle.Powertrain.Power.MotorL1.TorqueSpd.trq.Value(1));
    fprintf('   Převodový poměr L1: %.2f\n', Vehicle.Powertrain.Driveline.GearboxL1.ratio.Value);
    
    fprintf('\n✓ Vehicle struktura úspěšně načtena do workspace.\n');
catch ME
    warning('Chyba při načítání souboru: %s\nZkontrolujte formát hodnot v Excelu.', ME.message);
end

fprintf('\n=================================================================\n');
fprintf(' HOTOVO! Parametry z Excelu jsou aplikovány.\n');
fprintf(' Nyní můžete spustit simulaci: sm_car_config_maneuver(''sm_car'',''Skidpad'')\n');
fprintf('=================================================================\n');

%% ── POMOCNÁ FUNKCE ────────────────────────────────────────────────────────
function str = fsae_value_to_matlab_str(val)
%FSAE_VALUE_TO_MATLAB_STR Převede hodnotu z Excelu na MATLAB string
%   Zpracuje čísla, vektory [x,y,z], řetězce a prázdné hodnoty.

str = '';

if islogical(val) && isnan(double(val))
    return;
end

if isnumeric(val)
    if isnan(val), return; end
    if val == round(val)
        str = sprintf('%g', val);
    else
        str = sprintf('%.10g', val);
    end
    return;
end

if ischar(val) || isstring(val)
    val = strtrim(char(val));
    if isempty(val), return; end
    
    % Rozpoznat vektor [x, y, z] nebo matici - ponechá přesný formát z Excelu
    if startsWith(val,'[') && endsWith(val,']')
        str = val; 
        return;
    end
    
    % Rozpoznat which() volání
    if startsWith(val, 'which(')
        str = val; % ponechat as-is
        return;
    end
    
    % Pokusíme se převést na číslo
    num_val = str2double(val);
    if ~isnan(num_val)
        if num_val == round(num_val)
            str = sprintf('%g', num_val);
        else
            str = sprintf('%.10g', num_val);
        end
        return;
    end
    
    % Řetězec — přidáme apostrofy
    if ~(startsWith(val,'''') && endsWith(val,''''))
        str = ['''' val ''''];
    else
        str = val;
    end
    return;
end

% Ostatní typy — pokus o num2str
try
    str = num2str(val);
catch
    str = '';
end

end