% =========================================================================
%  Vehicle_formula.m
%  Datový soubor parametrů vaší student formule
%  -------------------------------------------------------------------------
%  Konfigurace: DWDecoupled (Decoupled heave/roll odpružení)
%  Upravte sekce označené  <<< ZDE >>>  vlastními hodnotami.
%
%  Po vyplnění spusťte:
%    Vehicle = addfieldVehicleDec(Vehicle);
%  nebo použijte read_vehicle_excel.m pro automatické načtení z Excelu.
% =========================================================================

Vehicle = struct;

%% ════════════════════════════════════════════════════════════════════════
%  CHASSIS
%% ════════════════════════════════════════════════════════════════════════
Vehicle.Chassis = struct;

%% ────────────────────────────────────────────────────────────────────────
%  BODY
%% ────────────────────────────────────────────────────────────────────────
Vehicle.Chassis.Body = struct;
Vehicle.Chassis.Body.class.Value = 'Body_Axle2';

% --- Polohy náprav -------------------------------------------------------
Vehicle.Chassis.Body.sAxle1.Units    = 'm';
Vehicle.Chassis.Body.sAxle1.Comments = 'Referenční bod – vždy [0 0 0]';
Vehicle.Chassis.Body.sAxle1.Value    = [0 0 0];   % <<< ZDE – vždy [0 0 0]

Vehicle.Chassis.Body.sAxle2.Units    = 'm';
Vehicle.Chassis.Body.sAxle2.Comments = 'x = -(rozvor); y=0; z=0';
Vehicle.Chassis.Body.sAxle2.Value    = [-1.53 0 0]; % <<< ZDE – rozvor

% --- Těžiště -------------------------------------------------------------
Vehicle.Chassis.Body.sCG.Units    = 'm';
Vehicle.Chassis.Body.sCG.Comments = 'CG poloha [x_podélná y_příčná z_výška]';
Vehicle.Chassis.Body.sCG.Value    = [-0.8 0 0.289]; % <<< ZDE – vážení + CG test

% --- Pohon ---------------------------------------------------------------
Vehicle.Chassis.Body.sPower.Units    = 'm';
Vehicle.Chassis.Body.sPower.Comments = 'Referenční poloha pohonné jednotky (baterie)';
Vehicle.Chassis.Body.sPower.Value    = [-1 0 0];    % <<< ZDE – CAD

% --- Rozměry -------------------------------------------------------------
Vehicle.Chassis.Body.Width.Units    = 'm';
Vehicle.Chassis.Body.Width.Comments = 'Wheel Center Y*2+0.2';
Vehicle.Chassis.Body.Width.Value    = 1.438;        % <<< ZDE – CAD: sWheelCentre.y*2+0.2

% --- Hmota a setrvačnost -------------------------------------------------
Vehicle.Chassis.Body.m.Units    = 'kg';
Vehicle.Chassis.Body.m.Comments = 'Sprung mass bez jezdce';
Vehicle.Chassis.Body.m.Value    = 165;              % <<< ZDE – vážení

Vehicle.Chassis.Body.J.Units    = 'kg*m^2';
Vehicle.Chassis.Body.J.Comments = 'Moments of Inertia [Ixx Iyy Izz]';
Vehicle.Chassis.Body.J.Value    = [43 192 206];    % <<< ZDE – CAD nebo bifilar pendulum

% --- Geometrie karoserie (jen vizualizace) -------------------------------
Vehicle.Chassis.Body.BodyGeometry.class.Value        = 'CAD_FSAE_Achilles';
Vehicle.Chassis.Body.BodyGeometry.sOffset.Units      = 'm';
Vehicle.Chassis.Body.BodyGeometry.sOffset.Comments   = '';
Vehicle.Chassis.Body.BodyGeometry.sOffset.Value      = [-0.5375 0 0];
Vehicle.Chassis.Body.BodyGeometry.aOffset.Units      = 'Yaw-Pitch-Roll';
Vehicle.Chassis.Body.BodyGeometry.aOffset.Value      = [0 0 0];
Vehicle.Chassis.Body.BodyGeometry.Color.Units        = '[RGB]';
Vehicle.Chassis.Body.BodyGeometry.Color.Value        = [0.1 0.5 0.9]; % <<< ZDE – barva
Vehicle.Chassis.Body.BodyGeometry.Opacity.Units      = '(0-1)';
Vehicle.Chassis.Body.BodyGeometry.Opacity.Value      = 1;
Vehicle.Chassis.Body.BodyGeometry.AeroColor.Units    = '[RGB]';
Vehicle.Chassis.Body.BodyGeometry.AeroColor.Value    = [0.095 0.2 0.3];
Vehicle.Chassis.Body.BodyGeometry.AeroOpacity.Units  = '(0-1)';
Vehicle.Chassis.Body.BodyGeometry.AeroOpacity.Value  = 1;
Vehicle.Chassis.Body.BodyGeometry.sWall2Wall.Units   = 'm';
Vehicle.Chassis.Body.BodyGeometry.sWall2Wall.Comments = 'For calculating cornering radius wall-to-wall';
Vehicle.Chassis.Body.BodyGeometry.sWall2Wall.Value   = [0.87 0.72 0.35];
Vehicle.Chassis.Body.BodyGeometry.Type     = 'BodyGeometry';
Vehicle.Chassis.Body.BodyGeometry.Instance = 'CAD_FSAE_Achilles';
Vehicle.Chassis.Body.BodyLoad.class.Value  = 'None';
Vehicle.Chassis.Body.BodyLoad.Type         = 'BodyLoad';
Vehicle.Chassis.Body.BodyLoad.Instance     = 'None';
Vehicle.Chassis.Body.Type     = 'Body';
Vehicle.Chassis.Body.Instance = 'FSAE_Formula'; % <<< ZDE – název vašeho vozu

%% ────────────────────────────────────────────────────────────────────────
%  SUSPENSION A1  (přední)   – DWDecoupled
%% ────────────────────────────────────────────────────────────────────────
Vehicle.Chassis.SuspA1.class.Value = 'Decoupled';
Vehicle.Chassis.SuspA1.Linkage.class.Value = 'DWDecoupled';

% -- Spodní rameno --------------------------------------------------------
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sInboardF.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sInboardF.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sInboardF.Value    = [0.06624 0.16783 0.11957]; % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sInboardR.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sInboardR.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sInboardR.Value    = [-0.11 0.1882 0.11957];   % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sOutboard.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sOutboard.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.sOutboard.Value    = [-0.008 0.58015 0.15789]; % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.m.Units    = 'kg';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.m.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.LowerWishbone.m.Value    = 2.90283;  % <<< ZDE – zvážení

% -- Horní rameno ---------------------------------------------------------
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sInboardF.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sInboardF.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sInboardF.Value    = [0.056 0.256 0.24857];    % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sInboardR.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sInboardR.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sInboardR.Value    = [-0.12769 0.26199 0.22857]; % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sOutboard.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sOutboard.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.sOutboard.Value    = [-0.03 0.56626 0.31677];  % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.m.Units    = 'kg';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.m.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.UpperWishbone.m.Value    = 2.63894;  % <<< ZDE – zvážení

% -- Těhlice --------------------------------------------------------------
Vehicle.Chassis.SuspA1.Linkage.Upright.sCG.Units            = 'm';
Vehicle.Chassis.SuspA1.Linkage.Upright.sCG.Comments         = '';
Vehicle.Chassis.SuspA1.Linkage.Upright.sCG.Value            = [-0.01428 0.58973 0.22513]; % <<< ZDE – CAD

Vehicle.Chassis.SuspA1.Linkage.Upright.sWheelCentre.Units   = 'm';
Vehicle.Chassis.SuspA1.Linkage.Upright.sWheelCentre.Comments= '';
Vehicle.Chassis.SuspA1.Linkage.Upright.sWheelCentre.Value   = [0 0.619 0.23323]; % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.Upright.m.Units              = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Upright.m.Comments           = '';
Vehicle.Chassis.SuspA1.Linkage.Upright.m.Value              = 7.03717;  % <<< ZDE – zvážení

Vehicle.Chassis.SuspA1.Linkage.Upright.aToe.Units           = 'deg';
Vehicle.Chassis.SuspA1.Linkage.Upright.aToe.Comments        = '';
Vehicle.Chassis.SuspA1.Linkage.Upright.aToe.Value           = 0;        % <<< ZDE – setup

Vehicle.Chassis.SuspA1.Linkage.Upright.aCamber.Units        = 'deg';
Vehicle.Chassis.SuspA1.Linkage.Upright.aCamber.Comments     = '';
Vehicle.Chassis.SuspA1.Linkage.Upright.aCamber.Value        = 0;        % <<< ZDE – setup

Vehicle.Chassis.SuspA1.Linkage.Upright.xAxle.Units          = 'm';
Vehicle.Chassis.SuspA1.Linkage.Upright.xAxle.Comments       = 'Axle length';
Vehicle.Chassis.SuspA1.Linkage.Upright.xAxle.Value          = 0.15;     % <<< ZDE – měření

Vehicle.Chassis.SuspA1.Linkage.Upright.xWCtoBearing.Units   = 'm';
Vehicle.Chassis.SuspA1.Linkage.Upright.xWCtoBearing.Comments= 'Wheel Center to Bearing';
Vehicle.Chassis.SuspA1.Linkage.Upright.xWCtoBearing.Value   = 0.05;     % <<< ZDE – měření

Vehicle.Chassis.SuspA1.Linkage.Upright.mAxle.Units          = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Upright.mAxle.Comments       = '';
Vehicle.Chassis.SuspA1.Linkage.Upright.mAxle.Value          = 1.76;     % <<< ZDE – zvážení

% -- Řídící tyč -----------------------------------------------------------
Vehicle.Chassis.SuspA1.Linkage.TrackRod.sInboard.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.TrackRod.sInboard.Comments = 'Must be consistent with steering rack outboard point';
Vehicle.Chassis.SuspA1.Linkage.TrackRod.sInboard.Value    = [0.0905 0.179 0.11927]; % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.TrackRod.sOutboard.Units   = 'm';
Vehicle.Chassis.SuspA1.Linkage.TrackRod.sOutboard.Comments= '';
Vehicle.Chassis.SuspA1.Linkage.TrackRod.sOutboard.Value   = [0.038 0.59246 0.15639]; % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.TrackRod.m.Units           = 'kg';
Vehicle.Chassis.SuspA1.Linkage.TrackRod.m.Comments        = '';
Vehicle.Chassis.SuspA1.Linkage.TrackRod.m.Value           = 0.3;        % <<< ZDE – zvážení

% -- Tlumič – Decoupled Heave úchyty ------------------------------------
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.sLeft.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.sLeft.Comments = 'Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.sLeft.Value    = [0 0.3 0.45];   % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.sRight.Units   = 'm';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.sRight.Comments= 'Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.sRight.Value   = [0 -0.3 0.45];  % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.mPiston.Units  = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.mPiston.Comments='';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.mPiston.Value  = 1.5;        % <<< ZDE – zvážení

Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.mCylinder.Units  = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.mCylinder.Comments='';
Vehicle.Chassis.SuspA1.Linkage.Shock.Heave.mCylinder.Value  = 2.1;      % <<< ZDE – zvážení

% -- Tlumič – Decoupled Roll úchyty ------------------------------------
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.sLeft.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.sLeft.Comments = 'Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.sLeft.Value    = [0.05 0.275 0.475];  % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.sRight.Units   = 'm';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.sRight.Comments= 'Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.sRight.Value   = [0.05 -0.275 0.325]; % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.mPiston.Units  = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.mPiston.Comments='';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.mPiston.Value  = 1.5;         % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.mCylinder.Units  = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.mCylinder.Comments='';
Vehicle.Chassis.SuspA1.Linkage.Shock.Roll.mCylinder.Value  = 2.1;       % <<< ZDE

% -- Dorazy zdvihu – Decoupled -------------------------------------------
Vehicle.Chassis.SuspA1.Linkage.Endstop.Heave.xMax.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Heave.xMax.Comments = 'Must be consistent with value in Dampers';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Heave.xMax.Value    = 0.1;       % <<< ZDE – mechanický rozsah

Vehicle.Chassis.SuspA1.Linkage.Endstop.Heave.xMin.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Heave.xMin.Comments = 'Must be consistent with value in Dampers';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Heave.xMin.Value    = -0.15;     % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.Endstop.Roll.xMax.Units     = 'm';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Roll.xMax.Comments  = 'Must be consistent with value in Dampers';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Roll.xMax.Value     = 0.1;       % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.Endstop.Roll.xMin.Units     = 'm';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Roll.xMin.Comments  = 'Must be consistent with value in Dampers';
Vehicle.Chassis.SuspA1.Linkage.Endstop.Roll.xMin.Value     = -0.15;     % <<< ZDE

% -- Pushrod (přední) -----------------------------------------------------
Vehicle.Chassis.SuspA1.Linkage.Pushrod.sUpright.Units      = 'm';
Vehicle.Chassis.SuspA1.Linkage.Pushrod.sUpright.Comments   = '';
Vehicle.Chassis.SuspA1.Linkage.Pushrod.sUpright.Value      = [-0.018 0.58015 0.17789]; % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.Pushrod.sBellcrank.Units    = 'm';
Vehicle.Chassis.SuspA1.Linkage.Pushrod.sBellcrank.Comments = '';
Vehicle.Chassis.SuspA1.Linkage.Pushrod.sBellcrank.Value    = [0 0.35 0.45];            % <<< ZDE

Vehicle.Chassis.SuspA1.Linkage.Pushrod.m.Units             = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Pushrod.m.Comments          = '';
Vehicle.Chassis.SuspA1.Linkage.Pushrod.m.Value             = 0.0583048;  % <<< ZDE

% -- Bellcrank (přední) ---------------------------------------------------
Vehicle.Chassis.SuspA1.Linkage.Bellcrank.sPivot.Units      = 'm';
Vehicle.Chassis.SuspA1.Linkage.Bellcrank.sPivot.Comments   = '';
Vehicle.Chassis.SuspA1.Linkage.Bellcrank.sPivot.Value      = [0 0.3 0.4]; % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Linkage.Bellcrank.m.Units           = 'kg';
Vehicle.Chassis.SuspA1.Linkage.Bellcrank.m.Comments        = '';
Vehicle.Chassis.SuspA1.Linkage.Bellcrank.m.Value           = 0.228067;   % <<< ZDE

% -- Uložení ramen (ponechat Rigid pokud nemáte bushings data) ------------
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.class.Value = 'Rigid_1Rev';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.RadialSpring.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.RadialSpring.Linear.K.Units = 'N/mm';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.RadialSpring.Linear.K.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.RadialDamper.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.RadialDamper.Linear.d.Units = 'N/(m/s)';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.RadialDamper.Linear.d.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.AxialSpring.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.AxialSpring.Linear.K.Units = 'N/mm';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.AxialSpring.Linear.K.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.AxialDamper.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.AxialDamper.Linear.d.Units = 'N/(m/s)';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.AxialDamper.Linear.d.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.Type     = 'Subframe_Conn';
Vehicle.Chassis.SuspA1.Linkage.Upper_Arm_to_Subframe.Instance = 'BushArm_AxRad_Sef_DW_UA';

Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.class.Value = 'Rigid_1Rev';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.RadialSpring.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.RadialSpring.Linear.K.Units = 'N/mm';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.RadialSpring.Linear.K.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.RadialDamper.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.RadialDamper.Linear.d.Units = 'N/(m/s)';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.RadialDamper.Linear.d.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.AxialSpring.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.AxialSpring.Linear.K.Units = 'N/mm';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.AxialSpring.Linear.K.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.AxialDamper.Law.Value = 'Linear';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.AxialDamper.Linear.d.Units = 'N/(m/s)';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.AxialDamper.Linear.d.Value = 2000;
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.Type     = 'Subframe_Conn';
Vehicle.Chassis.SuspA1.Linkage.Lower_Arm_to_Subframe.Instance = 'BushArm_AxRad_Sef_DW_LA';

Vehicle.Chassis.SuspA1.Linkage.Type     = 'Linkage';
Vehicle.Chassis.SuspA1.Linkage.Instance = 'DWDecoupled_Formula_f';

% -- Přední stabilizátor --------------------------------------------------
Vehicle.Chassis.SuspA1.AntiRollBar.class.Value = 'DroplinkRod';

Vehicle.Chassis.SuspA1.AntiRollBar.sSuspension.Units    = 'm';
Vehicle.Chassis.SuspA1.AntiRollBar.sSuspension.Comments = 'Must be same as Linkage.Bellcrank.sAntiRollBar';
Vehicle.Chassis.SuspA1.AntiRollBar.sSuspension.Value    = [-0.0143 0.16591 0.0738]; % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.AntiRollBar.sOutboard.Units    = 'm';
Vehicle.Chassis.SuspA1.AntiRollBar.sOutboard.Comments = '';
Vehicle.Chassis.SuspA1.AntiRollBar.sOutboard.Value    = [0.14255 0.162 0.06853];    % <<< ZDE

Vehicle.Chassis.SuspA1.AntiRollBar.sInboard.Units     = 'm';
Vehicle.Chassis.SuspA1.AntiRollBar.sInboard.Comments  = '';
Vehicle.Chassis.SuspA1.AntiRollBar.sInboard.Value     = [0.126 0.1595 0.12307];     % <<< ZDE

Vehicle.Chassis.SuspA1.AntiRollBar.sMount.Units       = 'm';
Vehicle.Chassis.SuspA1.AntiRollBar.sMount.Comments    = '';
Vehicle.Chassis.SuspA1.AntiRollBar.sMount.Value       = [0.126 0.08 0.12307];       % <<< ZDE

Vehicle.Chassis.SuspA1.AntiRollBar.qUniversal.Units   = 'deg';
Vehicle.Chassis.SuspA1.AntiRollBar.qUniversal.Comments= '';
Vehicle.Chassis.SuspA1.AntiRollBar.qUniversal.Value   = 90;    % 90 pro Decoupled ARB

Vehicle.Chassis.SuspA1.AntiRollBar.k.Units   = 'N*m/deg';
Vehicle.Chassis.SuspA1.AntiRollBar.k.Comments= 'pi*(D^4-d^4)*G/32';
Vehicle.Chassis.SuspA1.AntiRollBar.k.Value   = 30.96;          % <<< ZDE – výpočet/měření

Vehicle.Chassis.SuspA1.AntiRollBar.d.Units   = 'N*m/(deg/s)';
Vehicle.Chassis.SuspA1.AntiRollBar.d.Comments= '';
Vehicle.Chassis.SuspA1.AntiRollBar.d.Value   = 3;              % <<< ZDE

Vehicle.Chassis.SuspA1.AntiRollBar.m.Units   = 'kg';
Vehicle.Chassis.SuspA1.AntiRollBar.m.Comments= '';
Vehicle.Chassis.SuspA1.AntiRollBar.m.Value   = 20;             % <<< ZDE – zvážení

Vehicle.Chassis.SuspA1.AntiRollBar.SubframeConnection.class.Value = 'Rigid_1Rev';
Vehicle.Chassis.SuspA1.AntiRollBar.Type     = 'AntiRollBar';
Vehicle.Chassis.SuspA1.AntiRollBar.Instance = 'DroplinkRod_Formula_BC_f';

% -- Přední řízení --------------------------------------------------------
Vehicle.Chassis.SuspA1.Steer.class.Value = 'WheelDrivenRack1UJoint';

Vehicle.Chassis.SuspA1.Steer.Rack.sMount.Units    = 'm';
Vehicle.Chassis.SuspA1.Steer.Rack.sMount.Comments = 'HPRack';
Vehicle.Chassis.SuspA1.Steer.Rack.sMount.Value    = [0.0905 0 0.11927]; % <<< ZDE – CMM

Vehicle.Chassis.SuspA1.Steer.Rack.m.Units         = 'kg';
Vehicle.Chassis.SuspA1.Steer.Rack.m.Comments      = 'Mass';
Vehicle.Chassis.SuspA1.Steer.Rack.m.Value         = 2.0;        % <<< ZDE – zvážení

Vehicle.Chassis.SuspA1.Steer.Rack.fActuatorCutoff.Units    = 'Hz';
Vehicle.Chassis.SuspA1.Steer.Rack.fActuatorCutoff.Comments = '';
Vehicle.Chassis.SuspA1.Steer.Rack.fActuatorCutoff.Value    = 50;

Vehicle.Chassis.SuspA1.Steer.Pinion.sMount.Units    = 'm';
Vehicle.Chassis.SuspA1.Steer.Pinion.sMount.Comments = '';
Vehicle.Chassis.SuspA1.Steer.Pinion.sMount.Value    = [0.07787 0 0.10644]; % <<< ZDE

Vehicle.Chassis.SuspA1.Steer.Pinion.xRad.Units    = 'm';
Vehicle.Chassis.SuspA1.Steer.Pinion.xRad.Comments = '';
Vehicle.Chassis.SuspA1.Steer.Pinion.xRad.Value    = 0.01365; % <<< ZDE – měření/katalog

Vehicle.Chassis.SuspA1.Steer.Pinion.m.Units    = 'kg';
Vehicle.Chassis.SuspA1.Steer.Pinion.m.Comments = '';
Vehicle.Chassis.SuspA1.Steer.Pinion.m.Value    = 0.05;

Vehicle.Chassis.SuspA1.Steer.Wheel.sMount.Units    = 'm';
Vehicle.Chassis.SuspA1.Steer.Wheel.sMount.Comments = '';
Vehicle.Chassis.SuspA1.Steer.Wheel.sMount.Value    = [-0.56 0 0.47]; % <<< ZDE

Vehicle.Chassis.SuspA1.Steer.Wheel.aAxis.Units    = 'rad';
Vehicle.Chassis.SuspA1.Steer.Wheel.aAxis.Comments = '';
Vehicle.Chassis.SuspA1.Steer.Wheel.aAxis.Value    = 0.18;

Vehicle.Chassis.SuspA1.Steer.Wheel.m.Units    = 'kg';
Vehicle.Chassis.SuspA1.Steer.Wheel.m.Comments = 'Mass';
Vehicle.Chassis.SuspA1.Steer.Wheel.m.Value    = 1;

Vehicle.Chassis.SuspA1.Steer.Wheel.class.Value = 'FSAE';

Vehicle.Chassis.SuspA1.Steer.Shaft_Upper.m.Units      = 'kg';
Vehicle.Chassis.SuspA1.Steer.Shaft_Upper.m.Comments   = '';
Vehicle.Chassis.SuspA1.Steer.Shaft_Upper.m.Value      = 0.2;
Vehicle.Chassis.SuspA1.Steer.Shaft_Upper.xLength.Units= 'm';
Vehicle.Chassis.SuspA1.Steer.Shaft_Upper.xLength.Comments='';
Vehicle.Chassis.SuspA1.Steer.Shaft_Upper.xLength.Value= 0.33;

Vehicle.Chassis.SuspA1.Steer.Shaft_Lower.m.Units    = 'kg';
Vehicle.Chassis.SuspA1.Steer.Shaft_Lower.m.Comments = '';
Vehicle.Chassis.SuspA1.Steer.Shaft_Lower.m.Value    = 0.2;

% Převodová tabulka řízení  <<< ZDE – naměřit posuv hřebenu vs. úhel volantu >>>
Vehicle.Chassis.SuspA1.Steer.Ratio_Table.aWheel.Units    = 'rad';
Vehicle.Chassis.SuspA1.Steer.Ratio_Table.aWheel.Comments = 'Wheel Angle - reference only';
Vehicle.Chassis.SuspA1.Steer.Ratio_Table.aWheel.Value = ...
  [-3.1416 -2.8274 -2.5133 -2.1991 -1.8849 -1.5708 -1.2566 -0.94247 -0.62831 ...
   -0.31416 0 0.31416 0.62831 0.94247 1.2566 1.5708 1.8849 2.1991 2.5133 ...
   2.8274 3.1416]; % <<< ZDE

Vehicle.Chassis.SuspA1.Steer.Ratio_Table.xRack.Units    = 'm';
Vehicle.Chassis.SuspA1.Steer.Ratio_Table.xRack.Comments = 'Rack Displacement - reference only';
Vehicle.Chassis.SuspA1.Steer.Ratio_Table.xRack.Value = ...
  [-0.042894 -0.038604 -0.034315 -0.030026 -0.025736 -0.021447 -0.017157 ...
   -0.012868 -0.0085787 -0.0042894 0 0.0042894 0.0085787 0.012868 0.017157 ...
   0.021447 0.025736 0.030026 0.034315 0.038604 0.042894]; % <<< ZDE – naměřit!

Vehicle.Chassis.SuspA1.Steer.Type     = 'Steer';
Vehicle.Chassis.SuspA1.Steer.Instance = 'WheelDrivenRack1UJoint_Formula';

Vehicle.Chassis.SuspA1.Steer.DriverHuman.class.Value = 'None';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.s.Units = 'm';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.s.Comments = '';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.s.Value = [-1.267 0.377 0.626];
Vehicle.Chassis.SuspA1.Steer.DriverHuman.a.Units = 'deg';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.a.Comments = 'Roll-Pitch-Yaw, applied Y->P->R';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.a.Value = [0 0 0];
Vehicle.Chassis.SuspA1.Steer.DriverHuman.rho.Units = 'kg/m^3';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.rho.Comments = 'Use to adjust passenger mass';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.rho.Value = 1000;
Vehicle.Chassis.SuspA1.Steer.DriverHuman.aHeadInclination.Units = 'deg';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.aHeadInclination.Value = 15;
Vehicle.Chassis.SuspA1.Steer.DriverHuman.Color.Units = '[RGB] (0-1)';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.Color.Value = [0.79 0.82 0.93];
Vehicle.Chassis.SuspA1.Steer.DriverHuman.Opacity.Units = '(0-1)';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.Opacity.Value = 1;
Vehicle.Chassis.SuspA1.Steer.DriverHuman.Type = 'DriverHuman';
Vehicle.Chassis.SuspA1.Steer.DriverHuman.Instance = 'None';

%% ────────────────────────────────────────────────────────────────────────
%  SUSPENSION A2  (zadní)  – DWDecoupledNoSteer
%% ────────────────────────────────────────────────────────────────────────
Vehicle.Chassis.SuspA2.class.Value = 'Decoupled';
Vehicle.Chassis.SuspA2.Linkage.class.Value = 'DWDecoupledNoSteer';

% Spodní rameno zadní
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sInboardF.Units    = 'm';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sInboardF.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sInboardF.Value    = [0.06624 0.16783 0.11957]; % <<< ZDE

Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sInboardR.Units    = 'm';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sInboardR.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sInboardR.Value    = [-0.11 0.1882 0.11957];   % <<< ZDE

Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sOutboard.Units    = 'm';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sOutboard.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.sOutboard.Value    = [-0.008 0.58015 0.15789]; % <<< ZDE

Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.m.Units    = 'kg';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.m.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.LowerWishbone.m.Value    = 2.90283;  % <<< ZDE

% Horní rameno zadní
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sInboardF.Units    = 'm';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sInboardF.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sInboardF.Value    = [0.056 0.256 0.24857];    % <<< ZDE

Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sInboardR.Units    = 'm';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sInboardR.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sInboardR.Value    = [-0.12769 0.26199 0.22857]; % <<< ZDE

Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sOutboard.Units    = 'm';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sOutboard.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.sOutboard.Value    = [-0.03 0.56626 0.31677];  % <<< ZDE

Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.m.Units    = 'kg';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.m.Comments = '';
Vehicle.Chassis.SuspA2.Linkage.UpperWishbone.m.Value    = 2.63894;  % <<< ZDE

% Těhlice zadní
Vehicle.Chassis.SuspA2.Linkage.Upright.sCG.Value            = [-0.01428 0.58973 0.22513]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Upright.sCG.Units            = 'm';
Vehicle.Chassis.SuspA2.Linkage.Upright.sCG.Comments         = '';

Vehicle.Chassis.SuspA2.Linkage.Upright.sWheelCentre.Units   = 'm';
Vehicle.Chassis.SuspA2.Linkage.Upright.sWheelCentre.Comments= '';
Vehicle.Chassis.SuspA2.Linkage.Upright.sWheelCentre.Value   = [0 0.619 0.23323]; % <<< ZDE

Vehicle.Chassis.SuspA2.Linkage.Upright.m.Units              = 'kg';
Vehicle.Chassis.SuspA2.Linkage.Upright.m.Comments           = '';
Vehicle.Chassis.SuspA2.Linkage.Upright.m.Value              = 7.03717;  % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Upright.aToe.Units = 'deg'; Vehicle.Chassis.SuspA2.Linkage.Upright.aToe.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Upright.aToe.Value = 0; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Upright.aCamber.Units='deg'; Vehicle.Chassis.SuspA2.Linkage.Upright.aCamber.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Upright.aCamber.Value = 0; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Upright.xAxle.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Upright.xAxle.Comments='Axle length'; Vehicle.Chassis.SuspA2.Linkage.Upright.xAxle.Value=0.15;
Vehicle.Chassis.SuspA2.Linkage.Upright.xWCtoBearing.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Upright.xWCtoBearing.Comments='Wheel Center to Bearing'; Vehicle.Chassis.SuspA2.Linkage.Upright.xWCtoBearing.Value=0.05;
Vehicle.Chassis.SuspA2.Linkage.Upright.mAxle.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.Upright.mAxle.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Upright.mAxle.Value=1.76; % <<< ZDE

% Řídící tyč zadní (pro geometrii – zadní řízení vypnuto)
Vehicle.Chassis.SuspA2.Linkage.TrackRod.sInboard.Units='m'; Vehicle.Chassis.SuspA2.Linkage.TrackRod.sInboard.Comments='Must be consistent with steering rack outboard point';
Vehicle.Chassis.SuspA2.Linkage.TrackRod.sInboard.Value=[0.01782 0.24518 0.24814]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.TrackRod.sOutboard.Units='m'; Vehicle.Chassis.SuspA2.Linkage.TrackRod.sOutboard.Comments=''; Vehicle.Chassis.SuspA2.Linkage.TrackRod.sOutboard.Value=[-0.052 0.4986 0.32373]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.TrackRod.m.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.TrackRod.m.Comments=''; Vehicle.Chassis.SuspA2.Linkage.TrackRod.m.Value=0.3; % <<< ZDE

% Heave tlumiče zadní
Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.sLeft.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.sLeft.Comments='Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.sLeft.Value=[0 0.3 0.45]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.sRight.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.sRight.Comments='Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.sRight.Value=[0 -0.3 0.45]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.mPiston.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.mPiston.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.mPiston.Value=1.5;
Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.mCylinder.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.mCylinder.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Shock.Heave.mCylinder.Value=2.1;

% Roll tlumiče zadní
Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.sLeft.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.sLeft.Comments='Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.sLeft.Value=[0.05 0.275 0.475]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.sRight.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.sRight.Comments='Must be consistent with values in Spring, Damper';
Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.sRight.Value=[0.05 -0.275 0.325]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.mPiston.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.mPiston.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.mPiston.Value=1.5;
Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.mCylinder.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.mCylinder.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Shock.Roll.mCylinder.Value=2.1;

% Dorazy zadní
Vehicle.Chassis.SuspA2.Linkage.Endstop.Heave.xMax.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Heave.xMax.Comments='Must be consistent with value in Dampers'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Heave.xMax.Value=0.1; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Endstop.Heave.xMin.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Heave.xMin.Comments='Must be consistent with value in Dampers'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Heave.xMin.Value=-0.15; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Endstop.Roll.xMax.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Roll.xMax.Comments='Must be consistent with value in Dampers'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Roll.xMax.Value=0.1; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Endstop.Roll.xMin.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Roll.xMin.Comments='Must be consistent with value in Dampers'; Vehicle.Chassis.SuspA2.Linkage.Endstop.Roll.xMin.Value=-0.15; % <<< ZDE

% Pushrod zadní
Vehicle.Chassis.SuspA2.Linkage.Pushrod.sUpright.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Pushrod.sUpright.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Pushrod.sUpright.Value=[-0.018 0.58015 0.17789]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Pushrod.sBellcrank.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Pushrod.sBellcrank.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Pushrod.sBellcrank.Value=[0 0.35 0.45]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Pushrod.m.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.Pushrod.m.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Pushrod.m.Value=0.0583048; % <<< ZDE

% Bellcrank zadní
Vehicle.Chassis.SuspA2.Linkage.Bellcrank.sPivot.Units='m'; Vehicle.Chassis.SuspA2.Linkage.Bellcrank.sPivot.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Bellcrank.sPivot.Value=[0 0.3 0.4]; % <<< ZDE
Vehicle.Chassis.SuspA2.Linkage.Bellcrank.m.Units='kg'; Vehicle.Chassis.SuspA2.Linkage.Bellcrank.m.Comments=''; Vehicle.Chassis.SuspA2.Linkage.Bellcrank.m.Value=0.228067; % <<< ZDE

% Uložení ramen zadní (stejná struktura jako přední)
Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.class.Value = 'Rigid_1Rev';
Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.RadialSpring.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.RadialSpring.Linear.K.Units='N/mm'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.RadialSpring.Linear.K.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.RadialDamper.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.RadialDamper.Linear.d.Units='N/(m/s)'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.RadialDamper.Linear.d.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.AxialSpring.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.AxialSpring.Linear.K.Units='N/mm'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.AxialSpring.Linear.K.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.AxialDamper.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.AxialDamper.Linear.d.Units='N/(m/s)'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.AxialDamper.Linear.d.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.Type='Subframe_Conn'; Vehicle.Chassis.SuspA2.Linkage.Upper_Arm_to_Subframe.Instance='BushArm_AxRad_Sef_DW_UA';
Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.class.Value='Rigid_1Rev';
Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.RadialSpring.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.RadialSpring.Linear.K.Units='N/mm'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.RadialSpring.Linear.K.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.RadialDamper.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.RadialDamper.Linear.d.Units='N/(m/s)'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.RadialDamper.Linear.d.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.AxialSpring.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.AxialSpring.Linear.K.Units='N/mm'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.AxialSpring.Linear.K.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.AxialDamper.Law.Value='Linear'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.AxialDamper.Linear.d.Units='N/(m/s)'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.AxialDamper.Linear.d.Value=2000;
Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.Type='Subframe_Conn'; Vehicle.Chassis.SuspA2.Linkage.Lower_Arm_to_Subframe.Instance='BushArm_AxRad_Sef_DW_LA';
Vehicle.Chassis.SuspA2.Linkage.Type='Linkage'; Vehicle.Chassis.SuspA2.Linkage.Instance='DWDecoupledNoSteer_Formula_r';

% Zadní stabilizátor
Vehicle.Chassis.SuspA2.AntiRollBar.class.Value = 'DroplinkRod';
Vehicle.Chassis.SuspA2.AntiRollBar.sSuspension.Units='m'; Vehicle.Chassis.SuspA2.AntiRollBar.sSuspension.Comments='Must be same as Linkage.Bellcrank.sAntiRollBar'; Vehicle.Chassis.SuspA2.AntiRollBar.sSuspension.Value=[0.05886 0.2467 0.12791]; % <<< ZDE
Vehicle.Chassis.SuspA2.AntiRollBar.sOutboard.Units='m'; Vehicle.Chassis.SuspA2.AntiRollBar.sOutboard.Comments=''; Vehicle.Chassis.SuspA2.AntiRollBar.sOutboard.Value=[0.12487 0.218 0.12956]; % <<< ZDE
Vehicle.Chassis.SuspA2.AntiRollBar.sInboard.Units='m'; Vehicle.Chassis.SuspA2.AntiRollBar.sInboard.Comments=''; Vehicle.Chassis.SuspA2.AntiRollBar.sInboard.Value=[0.11799 0.21687 0.08307]; % <<< ZDE
Vehicle.Chassis.SuspA2.AntiRollBar.sMount.Units='m'; Vehicle.Chassis.SuspA2.AntiRollBar.sMount.Comments=''; Vehicle.Chassis.SuspA2.AntiRollBar.sMount.Value=[0.11799 0.11 0.08307]; % <<< ZDE
Vehicle.Chassis.SuspA2.AntiRollBar.qUniversal.Units='deg'; Vehicle.Chassis.SuspA2.AntiRollBar.qUniversal.Comments=''; Vehicle.Chassis.SuspA2.AntiRollBar.qUniversal.Value=90;
Vehicle.Chassis.SuspA2.AntiRollBar.k.Units='N*m/deg'; Vehicle.Chassis.SuspA2.AntiRollBar.k.Comments='pi*(D^4-d^4)*G/32'; Vehicle.Chassis.SuspA2.AntiRollBar.k.Value=76.72; % <<< ZDE
Vehicle.Chassis.SuspA2.AntiRollBar.d.Units='N*m/(deg/s)'; Vehicle.Chassis.SuspA2.AntiRollBar.d.Comments=''; Vehicle.Chassis.SuspA2.AntiRollBar.d.Value=7; % <<< ZDE
Vehicle.Chassis.SuspA2.AntiRollBar.m.Units='kg'; Vehicle.Chassis.SuspA2.AntiRollBar.m.Comments=''; Vehicle.Chassis.SuspA2.AntiRollBar.m.Value=20; % <<< ZDE
Vehicle.Chassis.SuspA2.AntiRollBar.SubframeConnection.class.Value='Rigid_1Rev';
Vehicle.Chassis.SuspA2.AntiRollBar.Type='AntiRollBar'; Vehicle.Chassis.SuspA2.AntiRollBar.Instance='DroplinkRod_Formula_BC_r';

% Zadní řízení – vypnuto
Vehicle.Chassis.SuspA2.Steer.class.Value = 'None';
Vehicle.Chassis.SuspA2.Steer.Type = 'Steer';
Vehicle.Chassis.SuspA2.Steer.Instance = 'None_default';

%% ────────────────────────────────────────────────────────────────────────
%  AERODYNAMIKA
%% ────────────────────────────────────────────────────────────────────────
Vehicle.Chassis.Aero.class.Value = 'sedan';

Vehicle.Chassis.Aero.CL.Units    = '';
Vehicle.Chassis.Aero.CL.Comments = 'Positive for upward lift (use negative for downforce)';
Vehicle.Chassis.Aero.CL.Value    = -2.5;    % <<< ZDE – CFD nebo tunel

Vehicle.Chassis.Aero.CD.Units    = '';
Vehicle.Chassis.Aero.CD.Comments = '';
Vehicle.Chassis.Aero.CD.Value    = 1;       % <<< ZDE

Vehicle.Chassis.Aero.rho_air.Units    = 'kg/m^3';
Vehicle.Chassis.Aero.rho_air.Comments = '';
Vehicle.Chassis.Aero.rho_air.Value    = 1.225;  % Upravit pro nadmořskou výšku

Vehicle.Chassis.Aero.ARef.Units    = 'm^2';
Vehicle.Chassis.Aero.ARef.Comments = '';
Vehicle.Chassis.Aero.ARef.Value    = 1.2;   % <<< ZDE – CAD

Vehicle.Chassis.Aero.sPressureCentre.Units    = 'm';
Vehicle.Chassis.Aero.sPressureCentre.Comments = '';
Vehicle.Chassis.Aero.sPressureCentre.Value    = [-0.8 0 0.6]; % <<< ZDE – CFD

Vehicle.Chassis.Aero.Type     = 'Aero';
Vehicle.Chassis.Aero.Instance = 'Formula_Aero';

%% ────────────────────────────────────────────────────────────────────────
%  PRUŽINY  – Decoupled (Heave + Roll oddělené)
%% ────────────────────────────────────────────────────────────────────────
Vehicle.Chassis.Spring.class.Value = 'Decoupled';

% Přední Heave
Vehicle.Chassis.Spring.Axle1.Heave.class.Value = 'Linear';
Vehicle.Chassis.Spring.Axle1.Heave.K.Units    = 'N/m';
Vehicle.Chassis.Spring.Axle1.Heave.K.Comments = '';
Vehicle.Chassis.Spring.Axle1.Heave.K.Value    = 43780;    % <<< ZDE

Vehicle.Chassis.Spring.Axle1.Heave.xPreload.Units    = 'm';
Vehicle.Chassis.Spring.Axle1.Heave.xPreload.Comments = 'Set either xPreload or fPreload to a nonzero value';
Vehicle.Chassis.Spring.Axle1.Heave.xPreload.Value    = 0.025;  % <<< ZDE – volná-montážní délka

Vehicle.Chassis.Spring.Axle1.Heave.fPreload.Units    = 'N';
Vehicle.Chassis.Spring.Axle1.Heave.fPreload.Comments = 'Set either xPreload or fPreload to a nonzero value';
Vehicle.Chassis.Spring.Axle1.Heave.fPreload.Value    = 0;

% Přední Roll
Vehicle.Chassis.Spring.Axle1.Roll.class.Value = 'Linear';
Vehicle.Chassis.Spring.Axle1.Roll.K.Units    = 'N/m';
Vehicle.Chassis.Spring.Axle1.Roll.K.Comments = '';
Vehicle.Chassis.Spring.Axle1.Roll.K.Value    = 43780;     % <<< ZDE

Vehicle.Chassis.Spring.Axle1.Roll.xPreload.Units    = 'm';
Vehicle.Chassis.Spring.Axle1.Roll.xPreload.Comments = 'Set either xPreload or fPreload to a nonzero value';
Vehicle.Chassis.Spring.Axle1.Roll.xPreload.Value    = 0;

Vehicle.Chassis.Spring.Axle1.Roll.fPreload.Units    = 'N';
Vehicle.Chassis.Spring.Axle1.Roll.fPreload.Comments = '';
Vehicle.Chassis.Spring.Axle1.Roll.fPreload.Value    = 0;

Vehicle.Chassis.Spring.Axle1.Type     = 'Spring';
Vehicle.Chassis.Spring.Axle1.Instance = 'Formula_DWDec_Linear_A1';

% Zadní Heave
Vehicle.Chassis.Spring.Axle2.Heave.class.Value = 'Linear';
Vehicle.Chassis.Spring.Axle2.Heave.K.Units    = 'N/m';
Vehicle.Chassis.Spring.Axle2.Heave.K.Comments = '';
Vehicle.Chassis.Spring.Axle2.Heave.K.Value    = 43780;    % <<< ZDE (může se lišit od přední!)

Vehicle.Chassis.Spring.Axle2.Heave.xPreload.Units    = 'm';
Vehicle.Chassis.Spring.Axle2.Heave.xPreload.Comments = 'Set either xPreload or fPreload to a nonzero value';
Vehicle.Chassis.Spring.Axle2.Heave.xPreload.Value    = 0.020;  % <<< ZDE

Vehicle.Chassis.Spring.Axle2.Heave.fPreload.Units = 'N';
Vehicle.Chassis.Spring.Axle2.Heave.fPreload.Comments='';
Vehicle.Chassis.Spring.Axle2.Heave.fPreload.Value = 0;

% Zadní Roll
Vehicle.Chassis.Spring.Axle2.Roll.class.Value = 'Linear';
Vehicle.Chassis.Spring.Axle2.Roll.K.Units    = 'N/m';
Vehicle.Chassis.Spring.Axle2.Roll.K.Comments = '';
Vehicle.Chassis.Spring.Axle2.Roll.K.Value    = 43780;     % <<< ZDE

Vehicle.Chassis.Spring.Axle2.Roll.xPreload.Units='m'; Vehicle.Chassis.Spring.Axle2.Roll.xPreload.Comments=''; Vehicle.Chassis.Spring.Axle2.Roll.xPreload.Value=0;
Vehicle.Chassis.Spring.Axle2.Roll.fPreload.Units='N'; Vehicle.Chassis.Spring.Axle2.Roll.fPreload.Comments=''; Vehicle.Chassis.Spring.Axle2.Roll.fPreload.Value=0;

Vehicle.Chassis.Spring.Axle2.Type     = 'Spring';
Vehicle.Chassis.Spring.Axle2.Instance = 'Formula_DWDec_Linear_A2';
Vehicle.Chassis.Spring.Type     = 'Springs';
Vehicle.Chassis.Spring.Instance = 'Axle2_Decoupled';

%% ────────────────────────────────────────────────────────────────────────
%  TLUMIČE  – Decoupled
%% ────────────────────────────────────────────────────────────────────────
Vehicle.Chassis.Damper.class.Value = 'Decoupled';

% Přední Heave
Vehicle.Chassis.Damper.Axle1.Heave.class.Value = 'Linear';
Vehicle.Chassis.Damper.Axle1.Heave.Damping.d.Units    = 'N/(m/s)';
Vehicle.Chassis.Damper.Axle1.Heave.Damping.d.Comments = '';
Vehicle.Chassis.Damper.Axle1.Heave.Damping.d.Value    = 5000;      % <<< ZDE – damper dyno

Vehicle.Chassis.Damper.Axle1.Heave.Endstop.KxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.KxMax.Comments=''; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.KxMax.Value=1e6;
Vehicle.Chassis.Damper.Axle1.Heave.Endstop.KxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.KxMin.Comments=''; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.KxMin.Value=1e6;
Vehicle.Chassis.Damper.Axle1.Heave.Endstop.dxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.dxMax.Comments=''; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.dxMax.Value=150;
Vehicle.Chassis.Damper.Axle1.Heave.Endstop.dxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.dxMin.Comments=''; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.dxMin.Value=150;
Vehicle.Chassis.Damper.Axle1.Heave.Endstop.xTransition.Units='m'; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.xTransition.Comments=''; Vehicle.Chassis.Damper.Axle1.Heave.Endstop.xTransition.Value=0.0001;

% Přední Roll
Vehicle.Chassis.Damper.Axle1.Roll.class.Value = 'Linear';
Vehicle.Chassis.Damper.Axle1.Roll.Damping.d.Units    = 'N/(m/s)';
Vehicle.Chassis.Damper.Axle1.Roll.Damping.d.Comments = '';
Vehicle.Chassis.Damper.Axle1.Roll.Damping.d.Value    = 5000;       % <<< ZDE

Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xMax.Units='m'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xMax.Comments='Must be consistent with values in Linkage'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xMax.Value=0.1;
Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xMin.Units='m'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xMin.Comments='Must be consistent with values in Linkage'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xMin.Value=-0.15;
Vehicle.Chassis.Damper.Axle1.Roll.Endstop.KxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.KxMax.Comments=''; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.KxMax.Value=1e6;
Vehicle.Chassis.Damper.Axle1.Roll.Endstop.KxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.KxMin.Comments=''; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.KxMin.Value=1e6;
Vehicle.Chassis.Damper.Axle1.Roll.Endstop.dxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.dxMax.Comments=''; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.dxMax.Value=150;
Vehicle.Chassis.Damper.Axle1.Roll.Endstop.dxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.dxMin.Comments=''; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.dxMin.Value=150;
Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xTransition.Units='m'; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xTransition.Comments=''; Vehicle.Chassis.Damper.Axle1.Roll.Endstop.xTransition.Value=0.0001;

Vehicle.Chassis.Damper.Axle1.Type='Damper'; Vehicle.Chassis.Damper.Axle1.Instance='Formula_DWDec_Linear_A1';

% Zadní Heave
Vehicle.Chassis.Damper.Axle2.Heave.class.Value = 'Linear';
Vehicle.Chassis.Damper.Axle2.Heave.Damping.d.Units='N/(m/s)'; Vehicle.Chassis.Damper.Axle2.Heave.Damping.d.Comments=''; Vehicle.Chassis.Damper.Axle2.Heave.Damping.d.Value=5000; % <<< ZDE
Vehicle.Chassis.Damper.Axle2.Heave.Endstop.KxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.KxMax.Comments=''; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.KxMax.Value=1e6;
Vehicle.Chassis.Damper.Axle2.Heave.Endstop.KxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.KxMin.Comments=''; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.KxMin.Value=1e6;
Vehicle.Chassis.Damper.Axle2.Heave.Endstop.dxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.dxMax.Comments=''; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.dxMax.Value=150;
Vehicle.Chassis.Damper.Axle2.Heave.Endstop.dxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.dxMin.Comments=''; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.dxMin.Value=150;
Vehicle.Chassis.Damper.Axle2.Heave.Endstop.xTransition.Units='m'; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.xTransition.Comments=''; Vehicle.Chassis.Damper.Axle2.Heave.Endstop.xTransition.Value=0.0001;

% Zadní Roll
Vehicle.Chassis.Damper.Axle2.Roll.class.Value = 'Linear';
Vehicle.Chassis.Damper.Axle2.Roll.Damping.d.Units='N/(m/s)'; Vehicle.Chassis.Damper.Axle2.Roll.Damping.d.Comments=''; Vehicle.Chassis.Damper.Axle2.Roll.Damping.d.Value=5000; % <<< ZDE
Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xMax.Units='m'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xMax.Comments='Must be consistent with values in Linkage'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xMax.Value=0.1;
Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xMin.Units='m'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xMin.Comments='Must be consistent with values in Linkage'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xMin.Value=-0.15;
Vehicle.Chassis.Damper.Axle2.Roll.Endstop.KxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.KxMax.Comments=''; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.KxMax.Value=1e6;
Vehicle.Chassis.Damper.Axle2.Roll.Endstop.KxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.KxMin.Comments=''; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.KxMin.Value=1e6;
Vehicle.Chassis.Damper.Axle2.Roll.Endstop.dxMax.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.dxMax.Comments=''; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.dxMax.Value=150;
Vehicle.Chassis.Damper.Axle2.Roll.Endstop.dxMin.Units='N/m'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.dxMin.Comments=''; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.dxMin.Value=150;
Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xTransition.Units='m'; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xTransition.Comments=''; Vehicle.Chassis.Damper.Axle2.Roll.Endstop.xTransition.Value=0.0001;

Vehicle.Chassis.Damper.Axle2.Type='Damper'; Vehicle.Chassis.Damper.Axle2.Instance='Formula_DWDec_Linear_A2';
Vehicle.Chassis.Damper.Type='Dampers'; Vehicle.Chassis.Damper.Instance='Axle2_Decoupled';

%% ────────────────────────────────────────────────────────────────────────
%  PNEUMATIKY
%% ────────────────────────────────────────────────────────────────────────
Vehicle.Chassis.TireA1.class.Value = 'MFMbody';
Vehicle.Chassis.TireA1.tirFile.Units    = '';
Vehicle.Chassis.TireA1.tirFile.Comments = '';
Vehicle.Chassis.TireA1.tirFile.Value    = 'which(''fsae190_50R10.tir'')'; % <<< ZDE – soubor pneu

Vehicle.Chassis.TireA1.Mass.Units    = '';
Vehicle.Chassis.TireA1.Mass.Comments = '';
Vehicle.Chassis.TireA1.Mass.Value    = 10;   % <<< ZDE – zvážení kompletního kola

Vehicle.Chassis.TireA1.Inertia.Units    = '';
Vehicle.Chassis.TireA1.Inertia.Comments = '';
Vehicle.Chassis.TireA1.Inertia.Value    = [1 2]; % <<< ZDE – [Ixx Izz]

Vehicle.Chassis.TireA1.roadFile.Units    = '';
Vehicle.Chassis.TireA1.roadFile.Comments = '';
Vehicle.Chassis.TireA1.roadFile.Value    = 'which(''TNO_FlatRoad.rdf'')'; % <<< ZDE nebo CRG

Vehicle.Chassis.TireA1.fContactPoint.Units    = 'sec';
Vehicle.Chassis.TireA1.fContactPoint.Comments = 'Break algebraic loop between tire center position and contact point position and orientation';
Vehicle.Chassis.TireA1.fContactPoint.Value    = 0.01;

Vehicle.Chassis.TireA1.Type     = 'Tire';
Vehicle.Chassis.TireA1.Instance = 'MFMbody_190_50R10';
Vehicle.Chassis.TireA1.TireBody.class.Value     = 'Parameterized';
Vehicle.Chassis.TireA1.TireBody.sOffset.Units   = 'm';
Vehicle.Chassis.TireA1.TireBody.sOffset.Comments= '';
Vehicle.Chassis.TireA1.TireBody.sOffset.Value   = [0 0 0];
Vehicle.Chassis.TireA1.TireBody.Type            = 'TireBody';
Vehicle.Chassis.TireA1.TireBody.Instance        = 'Parameterized';

% Zadní pneumatika – stejné nebo jiné (kopie přední nebo upravit)
Vehicle.Chassis.TireA2 = Vehicle.Chassis.TireA1; % <<< ZDE – pokud jiná pneu, přepsat

%% ════════════════════════════════════════════════════════════════════════
%  POWERTRAIN
%% ════════════════════════════════════════════════════════════════════════
Vehicle.Powertrain.Power.class.Value      = 'Electric_L1_R1_L2_R2'; % 4WD
Vehicle.Powertrain.Power.Cooling.class.Value = 'Liquid_Loop1';
Vehicle.Powertrain.Power.TAmbient.Units   = 'K';
Vehicle.Powertrain.Power.TAmbient.Comments= 'Temperature';
Vehicle.Powertrain.Power.TAmbient.Value   = 293;  % 20°C – upravit dle závodu

% ── Motory – pomocná funkce pro generování struktury ──────────────────────
% (Každý motor je identický – L1, R1 = přední; L2, R2 = zadní)
% Pokud jsou přední a zadní motory jiné, upravte sekce zvlášť.

motorNames = {'MotorL1','MotorR1','MotorL2','MotorR2'};

% Přední motory (L1, R1) – max moment [N·m]
trq_front = [300 300 300 300 286.4789 214.8592 171.8873 143.2394 122.7767 107.4296 ...
             95.493 85.9437 78.1306 71.6197]; % <<< ZDE – dyno nebo tech. list
% Zadní motory (L2, R2)
trq_rear  = [200 200 200 200 190.9859 143.2394 114.5916 95.493 81.8511 71.6197 63.662 ...
             57.2958 52.0871 47.7465]; % <<< ZDE – dyno nebo tech. list

w_motor = [0 1666.6667 3333.3333 4774.6371 5000 6666.6667 8333.3333 10000 ...
           11666.6667 13333.3333 15000 16666.6667 18333.3333 20000]; % <<< ZDE – osa otáček

eff_map = [ ...
  85 85 85 85 85 85 85 85 85 85 85;
  85 85 90 90 90 90 90 90 90 90 88;
  85 85 92 92 92 92 92 92 92 92 92;
  85 85 92 92 93 93 93 93 92 92 92;
  85 85 93 94 94 94 94 94 94 94 94;
  85 85 93 94 94 95 95 95 95 95 95;
  85 85 93 94 94 95 95 95 95 95 95;
  85 85 93 94 95 95 95 95 95 95 95;
  85 85 93 94 95 95 95 95 95 95 95;
  85 85 93 94 94 94 94 94 94 94 94;
  85 85 90 92 93 93 93 93 93 93 93;
  85 85 90 92 93 93 93 93 93 93 93;
  85 85 90 92 93 93 93 93 93 93 93;
  85 85 90 92 93 93 93 93 93 93 93]; % <<< ZDE – dyno mapa účinnosti

eff_thermal = 90*ones(14,11); % <<< ZDE – tepelná mapa

for mi = 1:4
    mn = motorNames{mi};
    if mi <= 2
        trq_vals = trq_front;
    else
        trq_vals = trq_rear;
    end
    Vehicle.Powertrain.Power.(mn).TorqueSpd.w.Units      = 'rpm';
    Vehicle.Powertrain.Power.(mn).TorqueSpd.w.Comments   = '';
    Vehicle.Powertrain.Power.(mn).TorqueSpd.w.Value      = w_motor;
    Vehicle.Powertrain.Power.(mn).TorqueSpd.trq.Units    = 'N*m';
    Vehicle.Powertrain.Power.(mn).TorqueSpd.trq.Comments = '';
    Vehicle.Powertrain.Power.(mn).TorqueSpd.trq.Value    = trq_vals;
    Vehicle.Powertrain.Power.(mn).fActuatorCutoff.Units    = 'Hz';
    Vehicle.Powertrain.Power.(mn).fActuatorCutoff.Comments = '';
    Vehicle.Powertrain.Power.(mn).fActuatorCutoff.Value    = 50; % <<< ZDE
    Vehicle.Powertrain.Power.(mn).LossTable.w.Units        = 'rpm';
    Vehicle.Powertrain.Power.(mn).LossTable.w.Comments     = '';
    Vehicle.Powertrain.Power.(mn).LossTable.w.Value        = w_motor;
    Vehicle.Powertrain.Power.(mn).LossTable.trq.Units      = 'N*m';
    Vehicle.Powertrain.Power.(mn).LossTable.trq.Comments   = '';
    Vehicle.Powertrain.Power.(mn).LossTable.trq.Value      = [0 20 40 60 80 100 120 140 160 180 200]; % <<< ZDE
    Vehicle.Powertrain.Power.(mn).LossTable.efficiency.Units    = '';
    Vehicle.Powertrain.Power.(mn).LossTable.efficiency.Comments = '';
    Vehicle.Powertrain.Power.(mn).LossTable.efficiency.Value    = eff_map;
    Vehicle.Powertrain.Power.(mn).ThermalLoss.T1.Units          = 'degC';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.T1.Comments       = '';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.T1.Value          = 25;
    Vehicle.Powertrain.Power.(mn).ThermalLoss.T2.Units          = 'degC';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.T2.Comments       = '';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.T2.Value          = 100;
    Vehicle.Powertrain.Power.(mn).ThermalLoss.efficiency.Units  = '';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.efficiency.Comments='';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.efficiency.Value  = eff_thermal;
    Vehicle.Powertrain.Power.(mn).ThermalLoss.mThermal.Units    = 'J/K';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.mThermal.Comments = '';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.mThermal.Value    = 800; % <<< ZDE
    Vehicle.Powertrain.Power.(mn).ThermalLoss.Tinit.Units       = 'degK';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.Tinit.Comments    = '';
    Vehicle.Powertrain.Power.(mn).ThermalLoss.Tinit.Value       = 300;
    Vehicle.Powertrain.Power.(mn).J.Units    = 'kg*m^2';
    Vehicle.Powertrain.Power.(mn).J.Comments = 'Must be 0 for fast initialization';
    Vehicle.Powertrain.Power.(mn).J.Value    = 0; % <<< ZDE nebo tech. list
end

% Měnič / Invertor
Vehicle.Powertrain.Power.Converter.vRef.Units    = 'V';
Vehicle.Powertrain.Power.Converter.vRef.Comments = '';
Vehicle.Powertrain.Power.Converter.vRef.Value    = 650;   % <<< ZDE – napětí DC bus

Vehicle.Powertrain.Power.Converter.Power.Units    = 'W';
Vehicle.Powertrain.Power.Converter.Power.Comments = '';
Vehicle.Powertrain.Power.Converter.Power.Value    = 60000; % <<< ZDE – max výkon invertoru

Vehicle.Powertrain.Power.Converter.iMaxSupply.Units    = 'A';
Vehicle.Powertrain.Power.Converter.iMaxSupply.Comments = '';
Vehicle.Powertrain.Power.Converter.iMaxSupply.Value    = 60000/650; % P/V

Vehicle.Powertrain.Power.Converter.efficiency.Units    = '';
Vehicle.Powertrain.Power.Converter.efficiency.Comments = '';
Vehicle.Powertrain.Power.Converter.efficiency.Value    = 98; % <<< ZDE

Vehicle.Powertrain.Power.Converter.fConverter.Units    = 'Hz';
Vehicle.Powertrain.Power.Converter.fConverter.Comments = '';
Vehicle.Powertrain.Power.Converter.fConverter.Value    = 1000;

% Baterie
Vehicle.Powertrain.Power.Battery.vNoLoad.SOC.Units    = '';
Vehicle.Powertrain.Power.Battery.vNoLoad.SOC.Comments = '';
Vehicle.Powertrain.Power.Battery.vNoLoad.SOC.Value    = [0 0.2 0.4 0.6 0.8 1];

Vehicle.Powertrain.Power.Battery.vNoLoad.T.Units    = 'degK';
Vehicle.Powertrain.Power.Battery.vNoLoad.T.Comments = '';
Vehicle.Powertrain.Power.Battery.vNoLoad.T.Value    = [243.1 253.1 263.1 273.1 283.1 298.1 313.1];

Vehicle.Powertrain.Power.Battery.vNoLoad.V0.Units    = '';
Vehicle.Powertrain.Power.Battery.vNoLoad.V0.Comments = '';
Vehicle.Powertrain.Power.Battery.vNoLoad.V0.Value    = ...  % <<< ZDE – charakterizace buněk × série
  [201.6   201.6   201.6   201.6   201.6   201.6   201.6;
   258.768 258.768 258.768 258.768 258.768 258.768 258.768;
   264.96  264.96  264.96  264.96  264.96  264.96  264.96;
   272.952 272.952 272.952 272.952 272.952 272.952 272.952;
   286.128 286.128 286.128 286.128 286.128 286.128 286.128;
   303.912 303.912 303.912 303.912 303.912 303.912 303.912];

Vehicle.Powertrain.Power.Battery.rTerminal.SOC.Units    = '';
Vehicle.Powertrain.Power.Battery.rTerminal.SOC.Comments = '';
Vehicle.Powertrain.Power.Battery.rTerminal.SOC.Value    = [0 0.2 0.4 0.6 0.8 1];

Vehicle.Powertrain.Power.Battery.rTerminal.T.Units    = 'degK';
Vehicle.Powertrain.Power.Battery.rTerminal.T.Comments = '';
Vehicle.Powertrain.Power.Battery.rTerminal.T.Value    = [243.1 253.1 263.1 273.1 283.1 298.1 313.1];

Vehicle.Powertrain.Power.Battery.rTerminal.R0.Units    = '';
Vehicle.Powertrain.Power.Battery.rTerminal.R0.Comments = '';
Vehicle.Powertrain.Power.Battery.rTerminal.R0.Value    = ...  % <<< ZDE – HPPC test
  [0.31846 0.23   0.1571  0.073116 0.051948 0.020171 0.037008;
   0.33548 0.23594 0.14764 0.092268 0.0657   0.025891 0.048168;
   0.32497 0.19991 0.14616 0.091152 0.06462  0.024793 0.036;
   0.30492 0.1989  0.12427 0.08856  0.064008 0.027205 0.055296;
   0.37152 0.21755 0.13846 0.097776 0.069264 0.026478 0.055656;
   0.47304 0.28098 0.16261 0.10969  0.080424 0.036504 0.1004];

Vehicle.Powertrain.Power.Battery.AhTable.T.Units    = 'degK';
Vehicle.Powertrain.Power.Battery.AhTable.T.Comments = '';
Vehicle.Powertrain.Power.Battery.AhTable.T.Value    = [243.1 253.1 263.1 273.1 283.1 298.1 313.1];

Vehicle.Powertrain.Power.Battery.AhTable.Ah.Units    = 'hr*A';
Vehicle.Powertrain.Power.Battery.AhTable.Ah.Comments = '';
Vehicle.Powertrain.Power.Battery.AhTable.Ah.Value    = [230 230 230 230 230 230 230]; % <<< ZDE – kapacita

Vehicle.Powertrain.Power.Battery.SOCInit.Units    = '0-1';
Vehicle.Powertrain.Power.Battery.SOCInit.Comments = '';
Vehicle.Powertrain.Power.Battery.SOCInit.Value    = 0.8; % <<< ZDE – počáteční SOC

Vehicle.Powertrain.Power.Type     = 'Power';
Vehicle.Powertrain.Power.Instance = 'Electric_L1_R1_L2_R2_default';

% Převodovka
Vehicle.Powertrain.Driveline.class.Value = 'L1_R1_L2_R2';

Vehicle.Powertrain.Driveline.GearboxL1.ratio.Units    = '';
Vehicle.Powertrain.Driveline.GearboxL1.ratio.Comments = 'Final Drive Ratio';
Vehicle.Powertrain.Driveline.GearboxL1.ratio.Value    = 2;   % <<< ZDE

Vehicle.Powertrain.Driveline.GearboxR1.ratio.Units    = '';
Vehicle.Powertrain.Driveline.GearboxR1.ratio.Comments = 'Final Drive Ratio';
Vehicle.Powertrain.Driveline.GearboxR1.ratio.Value    = 2;   % <<< ZDE

Vehicle.Powertrain.Driveline.GearboxL2.ratio.Units    = '';
Vehicle.Powertrain.Driveline.GearboxL2.ratio.Comments = 'Final Drive Ratio';
Vehicle.Powertrain.Driveline.GearboxL2.ratio.Value    = 2;   % <<< ZDE

Vehicle.Powertrain.Driveline.GearboxR2.ratio.Units    = '';
Vehicle.Powertrain.Driveline.GearboxR2.ratio.Comments = 'Final Drive Ratio';
Vehicle.Powertrain.Driveline.GearboxR2.ratio.Value    = 2;   % <<< ZDE

Vehicle.Powertrain.Driveline.DriveshaftL1.Value = 'Driveshaft';
Vehicle.Powertrain.Driveline.DriveshaftR1.Value = 'Driveshaft';
Vehicle.Powertrain.Driveline.DriveshaftL2.Value = 'Driveshaft';
Vehicle.Powertrain.Driveline.DriveshaftR2.Value = 'Driveshaft';
Vehicle.Powertrain.Driveline.Type     = 'Driveline';
Vehicle.Powertrain.Driveline.Instance = 'Axle2_L1_R1_L2_R2_default';

%% ════════════════════════════════════════════════════════════════════════
%  BRZDY
%% ════════════════════════════════════════════════════════════════════════
Vehicle.Brakes.class.Value = 'PedalAbstract_DiscDisc';

% Přední brzdy
Vehicle.Brakes.Axle1.DiscAndPad.lMeanRadius.Units    = 'm';
Vehicle.Brakes.Axle1.DiscAndPad.lMeanRadius.Comments = '';
Vehicle.Brakes.Axle1.DiscAndPad.lMeanRadius.Value    = 0.15;  % <<< ZDE – (R_out+R_in)/2

Vehicle.Brakes.Axle1.DiscAndPad.rMuStatic.Units    = '';
Vehicle.Brakes.Axle1.DiscAndPad.rMuStatic.Comments = '(0-1)';
Vehicle.Brakes.Axle1.DiscAndPad.rMuStatic.Value    = 0.7;    % <<< ZDE – ~1.4× kinetic

Vehicle.Brakes.Axle1.DiscAndPad.rMuKinetic.Units    = '';
Vehicle.Brakes.Axle1.DiscAndPad.rMuKinetic.Comments = '(0-1)';
Vehicle.Brakes.Axle1.DiscAndPad.rMuKinetic.Value    = 0.5;   % <<< ZDE – katalog obložení

Vehicle.Brakes.Axle1.DiscAndPad.nTransition.Units    = 'rad/s';
Vehicle.Brakes.Axle1.DiscAndPad.nTransition.Comments = '';
Vehicle.Brakes.Axle1.DiscAndPad.nTransition.Value    = 0.1;

Vehicle.Brakes.Axle1.DiscAndPad.dViscous.Units    = 'N*m/(rad/s)';
Vehicle.Brakes.Axle1.DiscAndPad.dViscous.Comments = '';
Vehicle.Brakes.Axle1.DiscAndPad.dViscous.Value    = 0.001;

Vehicle.Brakes.Axle1.DiscAndPad.NPads.Units    = '';
Vehicle.Brakes.Axle1.DiscAndPad.NPads.Comments = '';
Vehicle.Brakes.Axle1.DiscAndPad.NPads.Value    = 4;          % <<< ZDE – počet aktivních ploch

Vehicle.Brakes.Axle1.Caliper.lCylinderDiameter.Units    = 'm';
Vehicle.Brakes.Axle1.Caliper.lCylinderDiameter.Comments = '';
Vehicle.Brakes.Axle1.Caliper.lCylinderDiameter.Value    = 0.0125; % <<< ZDE – tech. list

Vehicle.Brakes.Axle1.Caliper.pMax.Units    = '';
Vehicle.Brakes.Axle1.Caliper.pMax.Comments = '';
Vehicle.Brakes.Axle1.Caliper.pMax.Value    = 85;  % <<< ZDE – [bar]

Vehicle.Brakes.Axle1.Caliper.fActuatorCutoff.Units    = '1/sec';
Vehicle.Brakes.Axle1.Caliper.fActuatorCutoff.Comments = '';
Vehicle.Brakes.Axle1.Caliper.fActuatorCutoff.Value    = 40;

% Zadní brzdy
Vehicle.Brakes.Axle2.DiscAndPad.lMeanRadius.Units='m'; Vehicle.Brakes.Axle2.DiscAndPad.lMeanRadius.Comments=''; Vehicle.Brakes.Axle2.DiscAndPad.lMeanRadius.Value=0.1; % <<< ZDE
Vehicle.Brakes.Axle2.DiscAndPad.rMuStatic.Units=''; Vehicle.Brakes.Axle2.DiscAndPad.rMuStatic.Comments='(0-1)'; Vehicle.Brakes.Axle2.DiscAndPad.rMuStatic.Value=0.7;
Vehicle.Brakes.Axle2.DiscAndPad.rMuKinetic.Units=''; Vehicle.Brakes.Axle2.DiscAndPad.rMuKinetic.Comments='(0-1)'; Vehicle.Brakes.Axle2.DiscAndPad.rMuKinetic.Value=0.5; % <<< ZDE
Vehicle.Brakes.Axle2.DiscAndPad.nTransition.Units='rad/s'; Vehicle.Brakes.Axle2.DiscAndPad.nTransition.Comments=''; Vehicle.Brakes.Axle2.DiscAndPad.nTransition.Value=0.1;
Vehicle.Brakes.Axle2.DiscAndPad.dViscous.Units='N*m/(rad/s)'; Vehicle.Brakes.Axle2.DiscAndPad.dViscous.Comments=''; Vehicle.Brakes.Axle2.DiscAndPad.dViscous.Value=0.001;
Vehicle.Brakes.Axle2.DiscAndPad.NPads.Units=''; Vehicle.Brakes.Axle2.DiscAndPad.NPads.Comments=''; Vehicle.Brakes.Axle2.DiscAndPad.NPads.Value=2; % <<< ZDE
Vehicle.Brakes.Axle2.Caliper.lCylinderDiameter.Units='m'; Vehicle.Brakes.Axle2.Caliper.lCylinderDiameter.Comments=''; Vehicle.Brakes.Axle2.Caliper.lCylinderDiameter.Value=0.0125; % <<< ZDE
Vehicle.Brakes.Axle2.Caliper.pMax.Units=''; Vehicle.Brakes.Axle2.Caliper.pMax.Comments=''; Vehicle.Brakes.Axle2.Caliper.pMax.Value=57; % <<< ZDE
Vehicle.Brakes.Axle2.Caliper.fActuatorCutoff.Units='1/sec'; Vehicle.Brakes.Axle2.Caliper.fActuatorCutoff.Comments=''; Vehicle.Brakes.Axle2.Caliper.fActuatorCutoff.Value=40;

Vehicle.Brakes.Type     = 'Brakes';
Vehicle.Brakes.Instance = 'Axle2_PedalAbstract_DiscDisc_Formula';

%% ════════════════════════════════════════════════════════════════════════
%  Konfigurace vozu
%% ════════════════════════════════════════════════════════════════════════
Vehicle.config = 'Formula_Decoupled';

%% ════════════════════════════════════════════════════════════════════════
%  Odvozená pole – VŽDY SPUSTIT NA KONCI
%  Kopíruje Shock.sLeft/Right → Spring/Damper.sTop/sBottom
%  Kopíruje Linkage.Endstop → Damper.Endstop
%  Kopíruje TrackRod.sInboard → Steer.Rack.sOutboard
%% ════════════════════════════════════════════════════════════════════════
Vehicle = addfieldVehicleDec(Vehicle);
