%% import_fsae_excel_to_matlab.m
% =========================================================================
%  Digitální dvojče FSAE Formule — Import parametrů z Excelu do MATLAB
% =========================================================================
%  Skript přečte parametry z FSAE_Pushrod_Parametry.xlsx a přepíše soubor
%  Vehicle_data_dwpushrod.m, poté načte data do workspace.
%
%  POUŽITÍ:
%    1. Vyplňte žluté buňky ve sloupci "Value" v Excel souboru.
%    2. Uložte Excel soubor a zavřete ho.
%    3. Spusťte tento skript: >> import_fsae_excel_to_matlab
%
%  PŘEDPOKLADY:
%    - FSAE_Pushrod_Parametry.xlsx  (ve stejné složce)
%    - Vehicle_data_dwpushrod.m     (ve stejné složce)
%    - MATLAB R2019b nebo novější
%
%  OPRAVENÉ CHYBY (v2 oproti v1):
%    - Správné zpracování vektorových hodnot (J, trq) — žádné [N] indexování
%    - Pevné hodnoty místo Excel formulí pro endstop xMax/xMin
%    - Opravená detekce prázdných (missing) hodnot
%    - which() volání uložena jako string (apostrofy) dle originálu .m souboru
%    - Bezpečnější mazání víceřádkových bloků
%
% Copyright 2026 — FSAE tým / digitální dvojče  (v2)
% =========================================================================

clc;
fprintf('=================================================================\n');
fprintf(' FSAE Pushrod — Import parametrů z Excelu (v2)\n');
fprintf('=================================================================\n\n');

%% ── 0. KONFIGURACE ────────────────────────────────────────────────────────
EXCEL_FILE  = 'FSAE_Pushrod_Parametry.xlsx';
OUTPUT_FILE = 'Vehicle_data_dwpushrod.m';

%% ── 1. KONTROLA EXISTENCE SOUBORŮ ────────────────────────────────────────
if ~isfile(EXCEL_FILE)
    error('Excel soubor "%s" nebyl nalezen.\nAktuální složka: %s', EXCEL_FILE, pwd);
end
if ~isfile(OUTPUT_FILE)
    error('Soubor "%s" nebyl nalezen.', OUTPUT_FILE);
end

fprintf('[1/5] Čtu Excel soubor: %s\n', EXCEL_FILE);

%% ── 2. ČTENÍ DAT Z EXCELU ────────────────────────────────────────────────
sheets = {'Body', 'Aero', 'SuspA1_Linkage_F', 'SuspA1_ARB_Steer', ...
          'SuspA2_Linkage_R', 'Spring_Damper', 'Tires', 'Powertrain', 'Brakes'};

params = containers.Map('KeyType','char','ValueType','any');

for s = 1:length(sheets)
    sheet_name = sheets{s};
    try
        raw = readcell(EXCEL_FILE, 'Sheet', sheet_name, 'Range', 'A1:F300', ...
                       'UseExcel', false);

        for row = 1:size(raw, 1)
            if size(raw, 2) < 3, continue; end

            matlab_path = raw{row, 2};
            value_raw   = raw{row, 3};

            % Přeskočit ne-string cesty
            if ~(ischar(matlab_path) || isstring(matlab_path)), continue; end
            matlab_path = strtrim(char(matlab_path));
            if ~startsWith(matlab_path, 'Vehicle.'), continue; end

            % OPRAVA 1: Přeskočit indexované cesty jako Vehicle.X.Value[1]
            % Tyto cesty neexistují v .m souboru — Excel musí mít plný vektor
            if ~isempty(regexp(matlab_path, '\[\d+\]$', 'once'))
                warning(['Přeskočena indexovaná cesta "%s".\n' ...
                         'Opravte v Excelu: použijte plný vektor (napr. [43 192 206]).'], ...
                         matlab_path);
                continue;
            end

            % OPRAVA 2: Bezpečná kontrola prázdných hodnot
            if fsae_is_empty_value(value_raw)
                continue;
            end

            % OPRAVA 3: Přeskočit Excel formule (=odkaz na jinou buňku)
            if ischar(value_raw) || isstring(value_raw)
                val_str = strtrim(char(value_raw));
                if startsWith(val_str, '=')
                    warning(['Excel formule v "%s" bude přeskočena.\n' ...
                             'Nahraďte tvrdou číselnou hodnotou v Excelu.'], matlab_path);
                    continue;
                end
            end

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
not_found_count = 0;
param_keys = keys(params);

for p = 1:length(param_keys)
    matlab_path = param_keys{p};
    new_value   = params(matlab_path);

    % Konverze hodnoty na MATLAB string
    value_str = fsae_value_to_matlab_str(new_value);
    if isempty(value_str), continue; end

    search_pattern = [matlab_path ' ='];
    found = false;

    for ln = 1:length(new_lines)
        line = new_lines{ln};
        trimmed = strtrim(line);

        if ~startsWith(trimmed, search_pattern), continue; end

        % Extrahujeme odsazení
        indent = regexp(line, '^\s*', 'match', 'once');
        if isempty(indent), indent = ''; end

        % Nový řádek s hodnotou
        new_lines{ln} = sprintf('%s%s = %s;', indent, matlab_path, value_str);

        % OPRAVA 4: Bezpečnější mazání víceřádkových bloků
        clean_orig = strtrim(regexprep(line, '%.*', ''));
        is_multiline = contains(clean_orig, '...') || ...
                       (contains(clean_orig, '[') && ~contains(clean_orig, ']'));

        if is_multiline
            next_ln = ln + 1;
            brackets_open  = length(strfind(clean_orig, '[')) + ...
                             length(strfind(clean_orig, '{'));
            brackets_close = length(strfind(clean_orig, ']')) + ...
                             length(strfind(clean_orig, '}'));

            while next_ln <= length(new_lines)
                check_line = new_lines{next_ln};
                clean_next = strtrim(regexprep(check_line, '%.*', ''));

                % OCHRANA: nikdy nesmažeme řádek s dalším Vehicle. parametrem
                if startsWith(strtrim(check_line), 'Vehicle.')
                    break;
                end

                brackets_open  = brackets_open  + ...
                                 length(strfind(clean_next, '[')) + ...
                                 length(strfind(clean_next, '{'));
                brackets_close = brackets_close + ...
                                 length(strfind(clean_next, ']')) + ...
                                 length(strfind(clean_next, '}'));

                new_lines{next_ln} = '';  % Vymažeme pokračovací řádek bloku

                % Konec bloku: závorky vyvážené, řádek končí středníkem, bez '...'
                if endsWith(clean_next, ';') && ...
                   (brackets_open == brackets_close) && ...
                   ~contains(clean_next, '...')
                    break;
                end

                next_ln = next_ln + 1;
            end
        end

        modified_count = modified_count + 1;
        found = true;
        break;
    end

    if ~found
        fprintf('   UPOZORNĚNÍ: Cesta "%s" nebyla v .m souboru nalezena.\n', matlab_path);
        not_found_count = not_found_count + 1;
    end
end

fprintf('   Upraveno: %d parametrů | Nenalezeno: %d\n', modified_count, not_found_count);

%% ── 5. ZÁPIS UPRAVENÉHO SOUBORU ──────────────────────────────────────────
fprintf('[4/5] Zapisuji aktualizovaný soubor...\n');

header = {
    sprintf('%% AUTOMATICKY GENEROVÁNO: import_fsae_excel_to_matlab.m (v2)')
    sprintf('%% Datum importu: %s', datestr(now, 'dd.mm.yyyy HH:MM:SS'))
    sprintf('%% Zdroj: %s', EXCEL_FILE)
    sprintf('%% ----------------------------------------------------------------')
    ''
};

fid = fopen(OUTPUT_FILE, 'w', 'n', 'UTF-8');
if fid == -1
    error('Nelze otevřít soubor %s pro zápis.', OUTPUT_FILE);
end

for h = 1:length(header)
    fprintf(fid, '%s\n', header{h});
end

for ln = 1:length(new_lines)
    line = new_lines{ln};
    if ischar(line)
        fprintf(fid, '%s\n', line);
    end
end

fclose(fid);
fprintf('   Soubor přepsán: %s\n', OUTPUT_FILE);

%% ── 6. NAČTENÍ DO WORKSPACE A VALIDACE ──────────────────────────────────
fprintf('[5/5] Načítám Vehicle strukturu do workspace...\n');

try
    run(OUTPUT_FILE);
    fprintf('\n   ── Shrnutí klíčových hodnot ──\n');
    fprintf('   Vehicle.config          = %s\n', Vehicle.config);
    fprintf('   Hmotnost karoserie      = %.1f kg\n',   Vehicle.Chassis.Body.m.Value);
    fprintf('   Rozvor náprav           = %.3f m\n',    abs(Vehicle.Chassis.Body.sAxle2.Value(1)));
    fprintf('   Těžiště výška Z         = %.3f m\n',    Vehicle.Chassis.Body.sCG.Value(3));
    fprintf('   Tuhost pružiny F/R      = %.0f / %.0f N/m\n', ...
            Vehicle.Chassis.Spring.Axle1.K.Value, Vehicle.Chassis.Spring.Axle2.K.Value);
    fprintf('   Tlumení F/R             = %.0f / %.0f N/(m/s)\n', ...
            Vehicle.Chassis.Damper.Axle1.Damping.d.Value, ...
            Vehicle.Chassis.Damper.Axle2.Damping.d.Value);
    fprintf('   Aero CL / CD            = %.2f / %.2f\n', ...
            Vehicle.Chassis.Aero.CL.Value, Vehicle.Chassis.Aero.CD.Value);
    fprintf('   Motor L1/L2 max Mq      = %.0f / %.0f Nm\n', ...
            Vehicle.Powertrain.Power.MotorL1.TorqueSpd.trq.Value(1), ...
            Vehicle.Powertrain.Power.MotorL2.TorqueSpd.trq.Value(1));
    fprintf('   Převod L1/L2            = %.2f / %.2f\n', ...
            Vehicle.Powertrain.Driveline.GearboxL1.ratio.Value, ...
            Vehicle.Powertrain.Driveline.GearboxL2.ratio.Value);
    fprintf('   Baterie SOC init        = %.0f%%\n', ...
            Vehicle.Powertrain.Power.Battery.SOCInit.Value * 100);
    fprintf('\n✓ Vehicle struktura úspěšně načtena do workspace.\n');
catch ME
    warning('Chyba při načítání .m souboru:\n  %s\nZkontrolujte hodnoty v Excelu.', ME.message);
end

fprintf('\n=================================================================\n');
fprintf(' HOTOVO! Parametry z Excelu jsou aplikovány.\n');
fprintf(' Spuštění simulace: sm_car_config_maneuver(''sm_car'',''Skidpad'')\n');
fprintf('=================================================================\n');


%% ═══════════════════════════════════════════════════════════════════════════
%  POMOCNÉ FUNKCE
%% ═══════════════════════════════════════════════════════════════════════════

function result = fsae_is_empty_value(val)
%FSAE_IS_EMPTY_VALUE  Bezpečná kontrola prázdné/chybějící hodnoty
%   Vrátí true pro: [], '', missing, NaN, cell s missing

    result = false;

    if isempty(val)
        result = true;
        return;
    end

    % Kontrola MATLAB missing type (R2019b+)
    try
        if isequal(class(val), 'missing') || (isscalar(val) && ismissing(val))
            result = true;
            return;
        end
    catch
        % Starší MATLAB — ignorujeme
    end

    % Numerický NaN
    if isnumeric(val) && isscalar(val) && isnan(val)
        result = true;
        return;
    end

    % Prázdný string
    if (ischar(val) || isstring(val)) && isempty(strtrim(char(val)))
        result = true;
        return;
    end
end


function str = fsae_value_to_matlab_str(val)
%FSAE_VALUE_TO_MATLAB_STR  Převede hodnotu z Excelu na MATLAB string
%
%  Pravidla:
%    - čísla (int/float)     ->  '42' nebo '3.14159'
%    - '[1 2 3]'             ->  '[1 2 3]'
%    - 'which(...)'          ->  '''which(...)'''  ← uloženo jako string!
%    - ostatní strings       ->  '''retezec'''

    str = '';

    if fsae_is_empty_value(val), return; end

    % ── Numerická hodnota ──
    if isnumeric(val) && isscalar(val)
        if isnan(val), return; end
        if val == round(val) && abs(val) < 1e12
            str = sprintf('%g', val);
        else
            str = sprintf('%.10g', val);
        end
        return;
    end

    % ── String / char ──
    if ischar(val) || isstring(val)
        val = strtrim(char(val));
        if isempty(val), return; end

        % Vektor/matice [x y z] — zachovat přesný formát z Excelu
        if startsWith(val, '[') && endsWith(val, ']')
            str = val;
            return;
        end

        % OPRAVA: which() volání → uložit jako MATLAB string (s apostrofy)
        % Původní .m soubor: tirFile.Value = 'which(''fsae.tir'')'
        % Chceme zachovat toto chování, ne volat which() za běhu scriptu
        if startsWith(val, 'which(')
            inner = strrep(val, '''', '''''');   % escapovat ' uvnitř
            str   = ['''' inner ''''];            % obalit apostrofy
            return;
        end

        % Pokusit se převést na číslo
        num_val = str2double(val);
        if ~isnan(num_val)
            if num_val == round(num_val) && abs(num_val) < 1e12
                str = sprintf('%g', num_val);
            else
                str = sprintf('%.10g', num_val);
            end
            return;
        end

        % Obecný string — přidat apostrofy
        if startsWith(val, '''') && endsWith(val, '''')
            str = val;  % Již má apostrofy
        else
            str = ['''' val ''''];
        end
        return;
    end

    % ── Záložní konverze ──
    try
        str = num2str(val);
    catch
        str = '';
    end
end
