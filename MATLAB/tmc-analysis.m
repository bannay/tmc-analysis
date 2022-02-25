%=========================================================================
%
%	TITLE:
%       tmc-analysis.m
%
%	DESCRIPTION:
%   Power, voltage and current analysis of a capacitively tuned and 
%   matched parallel resonator
%
%	INPUT:
%       f        frequency [ Hz ]
%       R           coil radius [ m ]
%       p           coil wire thickness (diamter) [ m ]
%
%	VERSION HISTORY:
%	    161120MB INITIAL VERSION
%=========================================================================

%=========================================================================
%	M A I N  f U N C T I O N
%=========================================================================
clear all;clc; plotGraph = 1;
%% Constants and parameters
kb = 1.38*10^-23;
mu0 = 4*pi*10^-7; % vacuum permeability [kg m s^-2 A^-2]
rho = 1.59e-8; % conductivity of copper [ohm m]
Z0 = 50; % interinsitc impedance of system [ohm]
f0 = 32e6; % Larmour frequencies [Hz]
w0 = 2*pi*f0; %detection frequency [rad s-1 ]

%% Coil paramters
R = 50e-3;% coil radius [m]
p = 2e-3;% coil wire thickness (diamter) [m]

% ohmic resistance of a conducting loop from DOI: 10.3389/fphy.2019.00237 [eq. 15]
Rcoil = (R/p).*sqrt(2*mu0.*w0.*rho); % coil resistence [ohm]
Lcoil = mu0*R*(log((16*R)/(p))-2); % coil inductance [H]

Rsample = 0.5*Rcoil; % sample noise [ohm] (estimated)

if plotGraph >= 1
    syms RA
else
    RA = Rcoil;
    RA = 50;
end

XA = w0*Lcoil;
ZA = RA+1i*XA; % Coil + sample impedance [ohms]

%% Tuning & matching using parallel and series capacitors Ct & Cm
B = (XA-sqrt(RA/Z0)*sqrt(RA*(RA-Z0)+(XA)^2))...
    /((RA)^2+(XA)^2); % Susceptance of parallel matching component
Ct = B/w0;  % Capacitance of parallel tuning element [F]
% Input impedence of matched parallel reasonator [ohm]
ZB = inv(1i*(w0*Ct)+1./ZA);

X = (1/B)+(XA*Z0/RA)-(Z0/(B*RA)); % Reactance of a series matching element.
Cm = -1/(w0*X); % Capacitance of series matching element [F]

% Input Z of matched resonant circuit
ZC=ZB-1i/(w0*Cm);  % Capacitance of series matching element [F]

%% Voltage and current distribution (Generator POV)
Pav = 1; % Noise power

% syms Pav; % available power from TX Gen/RX coil (signal or noise) [W]
GammaG=(ZC-Z0)/(ZC+Z0); % Gen->Load reflection coefficient
Pin=Pav.*(1-(abs(GammaG)).^2); % Accepted power by circuit/load [W]
Vc = 0.5*sqrt(4*Pin*ZC);% Voltage at terminals of Geneartor [V]
ic=Vc/ZC; % Current through terminals of Geneartor [A]

Vb=Vc*((ZB)/(ZB-1i/(Cm*w0))); % Voltage across parallel resonator

ia= Vb/ZA; % Current flowing through sample coil [A]

PL = 0.5*real(conj(ia)*Vb); % Power delivered to sample coil [W]


%% 

%% Voltage and current distribution (LOAD POV)

ZD = Z0-1i/(w0*Cm);
ZE = inv(1i*(w0*Ct)+1./ZD);
ZF = ZE+1i*XA;

Pav = 1; % Noise power
GammaL=(ZF-real(ZA))/(ZF+real(ZA)); % Reflection coefficient
Pin=Pav.*(1-(abs(GammaL))^2); % Accepted power by circuit [W]

VF = 0.5*sqrt(4*Pin*RA);% Voltage at terminal of RX coil [V]
iF = VF/ZF; % Current induced from the coil [A]

VE = VF*(ZE/ZF); %Voltage across Ct (voltage divider rule)

VD = VE*(Z0/ZD); % Voltage across ADC (voltage divider rule)

iD = VE/ZD; % Current flowing to ADC [A]

PL = 0.5*real(conj(iD)*VD); % Power delivered to sample coil [W]

%% Assigning symolic variables

if plotGraph ==1
RA = linspace(5e-3,5,100);

%%%
figure(1)
plot(RA, eval(abs(Vc)))
opt = [];
opt.BoxDim = [3 , 1.5]; %[width, height]
opt.XLabel = 'R_{equ} (\Omega)'; 
opt.YLabel = 'V_2 (V)';
opt.FontSize =  20;
opt.LineWidth = [4];
% opt.XGrid = 'on';
% opt.YGrid = 'on';
opt.YLim=[0 10];
opt.XLim=[0 5];
setPlotProp(opt);      

figure(2)
plot(RA, eval(abs(Vb)))
opt = [];
opt.BoxDim = [3 , 1.5]; %[width, height]
opt.XLabel = 'R_{equ} (\Omega)'; 
opt.YLabel = 'V_1 (V)';
opt.FontSize =  20;
opt.LineWidth = [4];
% opt.XGrid = 'on';
% opt.YGrid = 'on';
opt.YLim=[0 500];
opt.XLim=[0 5];
setPlotProp(opt);      
hold off


figure(3)
plot(RA, eval(Cm*1e12))
hold on
plot(RA, eval(Ct*1e12))
          
opt = [];
opt.BoxDim = [3 , 1.5]; %[width, height]
opt.XLabel = 'R_{equ} (\Omega)'; 
opt.YLabel = 'Cap. (pF)';
opt.LegendLoc = 'West';
opt.FontSize =  20;
opt.Legend = ["C_M", "C_T"];
opt.LegendFontSize = 14;
opt.LineWidth = [4,4];
% opt.XGrid = 'on';
% opt.YGrid = 'on';
% opt.YLim=[0 4];
opt.XLim=[0 5];
setPlotProp(opt);      
hold off


% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$C_M$ (pF)','Interpreter','latex')
% title('Series matching capacitance','Interpreter','latex')
% 
% subplot(2,2,4)
% plot(RA, eval(Ct*1e12),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$C_T$ (pF)','Interpreter','latex')
% title('Parallel tuning capacitance','Interpreter','latex')

% opt = [];
% opt.BoxDim = [5 , 5]; %[width, height]
% opt.XLabel = 'B_0 (T)'; 
% opt.YLabel = 'SNR gain';
% opt.Title = ['SNR gain relative to 3T (hyp. spins)'];
% opt.LegendLoc = 'NorthEast';
% opt.FontSize =  20;
% opt.Legend = ['r = '+string(Radii*1e2)+' cm; T_{coil} = '+string(CoilTemps)+' K'];
% opt.LegendFontSize = 14;
% opt.LineWidth = [4,4,4];
% opt.XGrid = 'on';
% opt.YGrid = 'on';
% opt.YLim=[0 4];
% opt.XLim=[0 10];
% setPlotProp(opt);      
% hold off


%%%
% figure(2)
% subplot(3,1,1)
% plot(RA, eval(abs(Vc)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$V_C$ (V)','Interpreter','latex')
% title('Voltage at terminal of generator ($V_C$), $P_{in}=1W$','Interpreter','latex')
% 
% subplot(3,1,2)
% plot(RA, eval(abs(Vb)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$V_B$ (V)','Interpreter','latex')
% title('Voltage across coil ($V_B$)','Interpreter','latex')
% 
% subplot(3,1,3)
% plot(RA, eval(abs(GammaG)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$C_M$ (pF)','Interpreter','latex')
% title('Series matching capacitance','Interpreter','latex')

end

%%%
if plotGraph == 2
% RA = linspace(5e-3,5,100);
% 
% figure (1)
% subplot(3,1,1)
% plot(RA, eval(abs(Vc)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$V_C$ (V)','Interpreter','latex')
% title('Voltage at terminal of generator ($V_C$)','Interpreter','latex')
% 
% subplot(3,1,2)
% plot(RA, eval(abs(Vb)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$V_B$ (V)','Interpreter','latex')
% title('Voltage across coil ($V_B$)','Interpreter','latex')
% 
% subplot(3,1,3)
% plot(RA, eval(abs(GammaG)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$|\Gamma_G|$','Interpreter','latex')
% title('Reflection cofficient (Receiver POV)','Interpreter','latex')

%%%
% figure (2)
% subplot(3,1,1)
% plot(RA, eval(abs(VF)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$V_F$ (V)','Interpreter','latex')
% title('Voltage at terminal of RX coil ($V_F$)','Interpreter','latex')
% 
% subplot(3,1,2)
% plot(RA, eval(abs(VD)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$V_D$ (V)','Interpreter','latex')
% title('Voltage across receiver  ($V_D$)','Interpreter','latex')
% 
% subplot(3,1,3)
% plot(RA, eval(abs(GammaL)),'-k', 'LineWidth', 2)
% grid on
% xlabel('$R_A$ ($\Omega$)','Interpreter','latex')
% ylabel('$|\Gamma_L|$','Interpreter','latex')
% title('Reflection cofficient (coil POV)','Interpreter','latex')
end
