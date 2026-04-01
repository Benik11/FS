function Vehicle = read_vehicle_excel(excel_file, vehicle_file)
% READ_VEHICLE_EXCEL  Načte parametry z Excel tabulky a zapíše je do
%                     Vehicle_formula.m (přepíše hodnoty .Value polí).
%
%   Vehicle = read_vehicle_excel()
%       Hledá 'FSAE_Formula_Parameters.xlsx' ve stejné složce.
%
%   Vehicle = read_vehicle_excel(excel_file)
%       Použije zadaný Excel soubor.
%
%   Vehicle = read_vehicle_excel(excel_file, vehicle_file)
%       Navíc přepíše hodnoty v zadaném .m souboru.
%
% POUŽITÍ:
%   1. Vyplňte žluté buňky ve všech listech Excelu.
%   2. Spusťte:  Vehicle = read_vehicle_excel();
%   3. Nebo:     Vehicle = read_vehicle_excel('FSAE_Formula_Parameters.xlsx', ...
%                                              'Vehicle_formula.m');
%
% POZNÁMKA:
%   Sloupec A  = Parametr (MATLAB pole)
%   Sloupec D  = Hodnota – přední (A1) nebo jediná hodnota
%   Sloupec E  = Hodnota – zadní (A2)  [pro listy se dvěma nápravami]
%
% Copyright 2025 – FSAE Student Formula Team

%% ─── vstupy ─────────────────────────────────────────────────────────────
if nargin < 1 || isempty(excel_file)
    excel_file = fullfile(fileparts(mfilename('fullpath')), ...
                          'FSAE_Formula_Parameters.xlsx');
end
if nargin < 2
    vehicle_file = [];
end

if ~exist(excel_file, 'file')
    error('Soubor nenalezen: %s', excel_file);
end

%% ─── načtení základního Vehicle struktury ───────────────────────────────
fprintf('Načítám základní Vehicle strukturu z Vehicle_formula.m ...\n');
Vehicle_formula_dir = fileparts(mfilename('fullpath'));
run(fullfile(Vehicle_formula_dir, 'Vehicle_formula.m'));   % načte Vehicle

%% ─── pomocné funkce ─────────────────────────────────────────────────────

    function val = parse_value(str)
        % Převede string na číslo nebo vektor. Vrátí prázdné pro '–', '(auto)', '?'.
        if isempty(str) || (ischar(str) && any(strcmpi(strtrim(str), ...
                {'–', '-', '?', '(auto)', ''})))
            val = [];
            return
        end
        if isnumeric(str)
            val = str;
            return
        end
        str = strtrim(str);
        % Vektor ve formátu [a b c] nebo [a; b; c]
        if startsWith(str, '[') && endsWith(str, ']')
            inner = str(2:end-1);
            % Nahradit středníky mezerami pro 1D vektory
            inner = strrep(inner, ';', ' ');
            parts = str2num(inner); %#ok<ST2NM>
            if ~isempty(parts)
                val = parts;
                return
            end
        end
        % Skalár
        num = str2double(str);
        if ~isnan(num)
            val = num;
        else
            val = str;  % ponechat jako string (např. názvy souborů)
        end
    end

    function Vehicle = set_field(Vehicle, param_path, value)
        % Nastaví Vehicle.(param_path).Value = value
        % param_path může být např. 'Chassis.Body.m'
        if isempty(value); return; end
        parts = strsplit(param_path, '.');
        try
            % Navigujeme do struktury
            ref = 'Vehicle';
            for pi = 1:length(parts)
                ref = [ref '.' parts{pi}]; %#ok<AGROW>
            end
            eval([ref '.Value = value;']);
            fprintf('  [OK] %s = %s\n', param_path, mat2str(value));
        catch ME
            fprintf('  [WARN] Nelze nastavit %s: %s\n', param_path, ME.message);
        end
    end

%% ─── definice listů a sloupců ──────────────────────────────────────────
% Každý list: {název listu, má_sloupec_A2, mapovací_pravidla}
% Mapovací pravidla: cell array of {excel_param_col_A, matlab_suffix_A1, matlab_suffix_A2}
%   matlab_suffix_A1 = '' znamená použít excel parametr přímo
%   Pokud je suffix jiný pro A2, uvést zvlášť.

sheets = {
    'Body',                  false;
    'Suspension_Hardpoints', true;
    'Springs',               true;
    'Dampers',               true;
    'AntiRollBar',           true;
    'Steering',              false;
    'Tires',                 true;
    'Aero',                  false;
    'Powertrain_Motors',     false;
    'Battery',               false;
    'Driveline',             true;
    'Brakes',                true;
};

%% ─── zpracování každého listu ───────────────────────────────────────────
for si = 1:size(sheets, 1)
    sheet_name = sheets{si, 1};
    has_a2     = sheets{si, 2};
    
    fprintf('\n--- List: %s ---\n', sheet_name);
    
    try
        % Číst list jako raw (uchová stringy i čísla)
        [~, ~, raw] = xlsread(excel_file, sheet_name);
    catch
        fprintf('  [WARN] List "%s" nenalezen nebo chyba čtení.\n', sheet_name);
        continue
    end
    
    if isempty(raw); continue; end
    
    % Přeskočit řádek 1 (header) a sekční řádky (kde sloupec D je prázdný)
    for ri = 2:size(raw, 1)
        param_cell = raw{ri, 1};
        if isempty(param_cell) || ~ischar(param_cell); continue; end
        param = strtrim(param_cell);
        if isempty(param); continue; end
        
        % Přeskočit sekční nadpisy (nemají tečku v názvu)
        if ~contains(param, '.'); continue; end
        
        % Hodnota A1 (sloupec D = 4)
        if size(raw, 2) >= 4
            val_a1_raw = raw{ri, 4};
        else
            val_a1_raw = [];
        end
        
        % Hodnota A2 (sloupec E = 5)
        if has_a2 && size(raw, 2) >= 5
            val_a2_raw = raw{ri, 5};
        else
            val_a2_raw = [];
        end
        
        val_a1 = parse_value(val_a1_raw);
        val_a2 = parse_value(val_a2_raw);
        
        % Sestavení MATLAB cesty
        % param z Excelu má prefix jako 'Chassis.Body.m' nebo 'SuspA1.AntiRollBar.k'
        % potřebujeme přidat 'Vehicle.' na začátek
        if startsWith(param, 'Vehicle.')
            full_path_a1 = param;
        else
            full_path_a1 = ['Vehicle.' param];
        end
        
        % Určit A1 vs A2 nápravu – pokud param obsahuje Axle1/A1, duplikovat pro A2
        is_axle_param = contains(param, {'Axle1', 'Axle2', 'SuspA1', 'SuspA2', ...
                                          'TireA1', 'TireA2'});
        
        % Nastavit A1 hodnotu
        if ~isempty(val_a1)
            Vehicle = set_field(Vehicle, full_path_a1(9:end), val_a1);
            % (odebrání 'Vehicle.' prefixu pro set_field, který ho přidá znovu)
        end
        
        % Nastavit A2 hodnotu (pokud list má A2 a hodnota není prázdná/–)
        if has_a2 && ~isempty(val_a2)
            % Nahradit A1 za A2, Axle1 za Axle2, SuspA1 za SuspA2, TireA1 za TireA2
            path_a2 = strrep(full_path_a1, 'Axle1',  'Axle2');
            path_a2 = strrep(path_a2,       'SuspA1', 'SuspA2');
            path_a2 = strrep(path_a2,       'TireA1', 'TireA2');
            if ~strcmp(path_a2, full_path_a1)
                Vehicle = set_field(Vehicle, path_a2(9:end), val_a2);
            end
        end
    end
end

%% ─── odvozená pole (vždy na konci) ─────────────────────────────────────
fprintf('\nAktualizuji odvozená pole (addfieldVehicleDec)...\n');
try
    Vehicle = addfieldVehicleDec(Vehicle);
    fprintf('[OK] addfieldVehicleDec proběhl úspěšně.\n');
catch ME
    fprintf('[WARN] addfieldVehicleDec: %s\n', ME.message);
    fprintf('       Zkontrolujte, zda je addfieldVehicleDec.m na MATLAB path.\n');
end

%% ─── volitelný zápis do .m souboru ─────────────────────────────────────
if ~isempty(vehicle_file)
    write_vehicle_m(Vehicle, vehicle_file);
end

fprintf('\nDokončeno. Vehicle struktura je připravena.\n');
end

%% ═══════════════════════════════════════════════════════════════════════
function write_vehicle_m(Vehicle, output_file)
% Zapíše klíčové hodnoty Vehicle struktury do .m souboru.
% Prochází strukturu a aktualizuje řádky tvaru:
%   .Value    = <hodnota>;

if ~exist(output_file, 'file')
    fprintf('[WARN] Výstupní soubor nenalezen: %s\n', output_file);
    fprintf('       Hodnoty nebyly zapsány do souboru.\n');
    return
end

fprintf('Zapisuji hodnoty do %s ...\n', output_file);

% Číst obsah souboru
fid = fopen(output_file, 'r');
lines = {};
while ~feof(fid)
    lines{end+1} = fgetl(fid); %#ok<AGROW>
end
fclose(fid);

% Rekurzivní procházení Vehicle struktury
paths = get_all_paths(Vehicle, 'Vehicle');

changed = 0;
for pi = 1:length(paths)
    p = paths{pi};
    if ~endsWith(p, '.Value'); continue; end
    
    try
        val = eval(p);
    catch
        continue
    end
    
    % Hledat odpovídající řádek v souboru
    % Vzor: <cesta>.Value    = <cokoliv>;
    search_key = p; % 'Vehicle.Chassis.Body.m.Value'
    
    for li = 1:length(lines)
        line = lines{li};
        if contains(line, search_key) && contains(line, '=')
            % Nahradit hodnotu
            val_str = value_to_string(val);
            indent  = regexp(line, '^\s*', 'match', 'once');
            new_line = sprintf('%s%s = %s;', indent, search_key, val_str);
            if ~strcmp(lines{li}, new_line)
                lines{li} = new_line;
                changed = changed + 1;
            end
            break
        end
    end
end

% Zapsat zpět
fid = fopen(output_file, 'w');
for li = 1:length(lines)
    if ischar(lines{li})
        fprintf(fid, '%s\n', lines{li});
    end
end
fclose(fid);

fprintf('[OK] Aktualizováno %d hodnot v %s\n', changed, output_file);
end

%% ───────────────────────────────────────────────────────────────────────
function paths = get_all_paths(s, prefix)
% Vrátí cell array všech plných cest ke listům struktury.
paths = {};
if ~isstruct(s); return; end
fnames = fieldnames(s);
for fi = 1:length(fnames)
    fname = fnames{fi};
    full  = [prefix '.' fname];
    sub   = s.(fname);
    if isstruct(sub)
        sub_paths = get_all_paths(sub, full);
        paths = [paths; sub_paths]; %#ok<AGROW>
    else
        paths{end+1} = full; %#ok<AGROW>
    end
end
end

%% ───────────────────────────────────────────────────────────────────────
function str = value_to_string(val)
% Převede MATLAB hodnotu na string pro zápis do .m souboru.
if ischar(val)
    str = sprintf('''%s''', val);
elseif isnumeric(val) && isscalar(val)
    str = num2str(val, 8);
elseif isnumeric(val) && isvector(val)
    str = ['[' num2str(val(:)', '%.6g ') ']'];
elseif isnumeric(val) && ismatrix(val)
    rows = size(val, 1);
    parts = cell(rows, 1);
    for ri = 1:rows
        parts{ri} = num2str(val(ri,:), '%.6g ');
    end
    str = ['[' strjoin(parts, '; ') ']'];
else
    str = mat2str(val);
end
end
