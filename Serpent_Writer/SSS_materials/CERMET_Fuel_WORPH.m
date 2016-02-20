function  [MCNP]  = CERMET_Fuel_WORPH(MCNP)
%Cermet_Fuel - determine fuel material composition and write to sss input
%file


Poison_load = MCNP.fuel.Poison_Frac; % atom density
Poison_Type = MCNP.fuel.Poison_Type;

% Gd isotopic composition in atom percent
% 152,154,155,156,157,158,160
Gd_Abundances    = [.002;.0218;0.148;0.2047;0.1565;0.2484;0.2186];
Gd_sum           = Gd_Abundances(1)+Gd_Abundances(2) + Gd_Abundances(3) + Gd_Abundances(4) + Gd_Abundances(6) + Gd_Abundances(7);
GD_FW152         = Gd_Abundances(1)/Gd_sum;
GD_FW154         = Gd_Abundances(2)/Gd_sum;
GD_FW155         = Gd_Abundances(3)/Gd_sum;
GD_FW156         = Gd_Abundances(4)/Gd_sum;
GD_FW158         = Gd_Abundances(6)/Gd_sum;
GD_FW160         = Gd_Abundances(7)/Gd_sum;

p_Gd2O3     = 7.90 ;                    % Just Gd not  GdO3
p_Hf        = 13.31;                    % Ceria
p_ThO2      = 11.724;                   % Just thorium 
p_fuel      = 13.817000;


M_O         = 15.9994;
M_Th        = 232.03806;
M_Hf        = 178.49;
M_Gd        = 157.25;
M_Gd_enr    = .95*156.923956  + (1-.95)*(GD_FW152*151.919786+GD_FW154*153.920861+GD_FW155*154.922618+GD_FW156*155.922118+GD_FW158*157.924019+GD_FW160*159.927049);


% Hf isotopic composition in atom percent
% 174,176,177,178,179,180
Hf_Abundances    = [.0016;.0526;0.1860;0.2728;0.1362;0.3508];

% Set the stabilizer density
if (Poison_Type == 1)||(Poison_Type == 6);  % Gadolinia (Gd2O3)
    p_Poison = p_Gd2O3;
elseif Poison_Type == 2;                  % Gadolinia (Gd2O3) enriched
    p_Poison = p_Gd2O3;
elseif Poison_Type == 3;                  % Hf
    p_Poison = p_Hf;
elseif Poison_Type == 4;                  % Hf enriched
    p_Poison = p_Hf;
elseif Poison_Type == 5                   % Thoria (ThO2)
    p_Poison = p_ThO2;
end


% Set the stabilizer mass
if Poison_Type == 1;                        % Gadolinia (Gd2O3)
    M_Poison = 2*M_Gd + 3*M_O;
    M_Poison_Metal = M_Gd;
    p_poison=p_Gd2O3;
elseif Poison_Type == 2;                      % Gadolinia (Gd2O3) enriched
    M_Poison = 2*M_Gd_enr + 3*M_O;
    M_Poison_Metal = M_Gd_enr;
    p_poison=p_Gd2O3;
elseif Poison_Type == 3;                      % Hf
    M_Poison = M_Hf;
    M_Poison_Metal = M_Hf;
    p_poison=p_Hf;
elseif Poison_Type == 4;                      % Hf enriched
    M_Poison = M_Hf;
    M_Poison_Metal = M_Hf;
    p_poison= p_Hf
elseif Poison_Type == 5;                % Thoria (ThO2)
    M_Poison = M_Th + M_O;
    M_Poison_Metal = M_Th;
    p_poison= p_ThO2 
    
    elseif Poison_Type == 0;                % Thoria (ThO2)
    M_Poison = 0 ;
    M_Poison_Metal = 0;
    p_poison= 0 
else
    % no poison
end


AD_Poison   = (Poison_load);

AD_tot=0.06912622250

if (Poison_Type == 1) || (Poison_Type == 6);
    AD_Poison_Metal = AD_Poison*AD_tot
elseif Poison_Type == 2;                  % Gadolinia (Gd2O3) enriched
    AD_Poison_Metal = AD_Poison*AD_tot
 
elseif Poison_Type == 3;                  % Hf
    AD_Poison_Metal = AD_Poison*AD_tot
elseif Poison_Type == 4;                  % Hf enriched
    AD_Poison_Metal = AD_Poison*AD_tot
elseif Poison_Type == 5;                % Thoria (ThO2)
    AD_Poison_Metal = AD_Poison*AD_tot
else
end

AD_O = 0.0292829707;
M_U = (0.0024095780*235+0.0113163686*238+0.0000254589*234+0.0000115908*236+1e-36*233+1e-36*240)*(1-Poison_load);
M_W = (0.0001929078*182+0.0001041702*183+0.0246977311*184+0.0002069573*186)*(1-Poison_load);
M_O = 0.0292829707*(1-Poison_load)*16;


MCNP.Density.normal.Fuel.Fuel.Density = -(p_fuel*(1-Poison_load)+Poison_load*p_poison);

Fuel_String=...
    ['8016.80c ',num2str(AD_O*(1-Poison_load),'%18.10e'),' \n',...
    '92235.80c ',num2str(0.0024095780*(1-Poison_load),'%18.10e'),' \n',...
    '92238.80c ',num2str(0.0113163686*(1-Poison_load),'%18.10e'),' \n',...
    '92234.80c ',num2str(0.0000254589*(1-Poison_load),'%18.10e'),' \n',...
    '92236.80c ',num2str(0.0000115908*(1-Poison_load),'%18.10e'),' \n',...
    '92233.80c  1e-36 \n',...
    '94240.80c  1e-36 \n',...
    '74182.80c ',num2str(0.0001929078*(1-Poison_load),'%18.10e'),' \n',...
    '74183.80c ',num2str(0.0001041702*(1-Poison_load),'%18.10e'),' \n',...
    '74184.80c ',num2str(0.0246977311*(1-Poison_load),'%18.10e'),' \n',...
    '74186.80c ',num2str(0.0002069573*(1-Poison_load),'%18.10e'),' \n'];
if Poison_Type == 1; %Gd Natural Composition
    Poison =...
        ['64152.80c ',num2str(AD_Poison_Metal*Gd_Abundances(1),'%18.10e'),' \n',...
        '64154.80c ',num2str(AD_Poison_Metal*Gd_Abundances(2),'%18.10e'),' \n',...
        '64155.80c ',num2str(AD_Poison_Metal*Gd_Abundances(3),'%18.10e'),' \n',...
        '64156.80c ',num2str(AD_Poison_Metal*Gd_Abundances(4),'%18.10e'),' \n',...
        '64157.80c ',num2str(AD_Poison_Metal*Gd_Abundances(5),'%18.10e'),' \n',...
        '64158.80c ',num2str(AD_Poison_Metal*Gd_Abundances(6),'%18.10e'),' \n',...
        '64160.80c ',num2str(AD_Poison_Metal*Gd_Abundances(7),'%18.10e'),' \n',...
        '90232.80c ',num2str(0.0008784891*(1-Poison_load),'%18.10e'),' \n'];
elseif Poison_Type == 2; % Gd-160 enriched
    Poison =...
       [ '64152.80c ',num2str(AD_Poison_Metal*GD_FW152*.05,'%18.10e'),' \n',...
        '64154.80c ',num2str(AD_Poison_Metal*GD_FW154*.05,'%18.10e'),' \n',...
        '64155.80c ',num2str(AD_Poison_Metal*GD_FW155*.05,'%18.10e'),' \n',...
        '64156.80c ',num2str(AD_Poison_Metal*GD_FW156*.05,'%18.10e'),' \n',...
        '64157.80c ',num2str(AD_Poison_Metal*.95,'%18.10e'),' \n',...
        '64158.80c ',num2str(AD_Poison_Metal*GD_FW158*.05,'%18.10e'),' \n',...
        '64160.80c ',num2str(AD_Poison_Metal*GD_FW160*.05,'%18.10e'),' \n',...
        '90232.80c ',num2str(0.0008784891*(1-Poison_load)),' \n'];
    
elseif Poison_Type == 3; %Hafnium Composition
    Poison =...
        ['72174.80c ',num2str(AD_Poison_Metal*Hf_Abundances(1),'%18.10e'),' \n',...
        '72176.80c ',num2str(AD_Poison_Metal*Hf_Abundances(2),'%18.10e'),' \n',...
        '72177.80c ',num2str(AD_Poison_Metal*Hf_Abundances(3),'%18.10e'),' \n',...
        '72178.80c ',num2str(AD_Poison_Metal*Hf_Abundances(4),'%18.10e'),' \n',...
        '72179.80c ',num2str(AD_Poison_Metal*Hf_Abundances(5),'%18.10e'),' \n',...
        '72180.80c ',num2str(AD_Poison_Metal*Hf_Abundances(6),'%18.10e'),' \n',...
        '90232.80c ',num2str(0.0008784891*(1-Poison_load),'%18.10e'),' \n'];
    
elseif Poison_Type == 4; %Hf enriched Composition
    Poison =...
        ['72174.80c ',num2str(AD_Poison_Metal*Hf_Abundances(1),'%18.10e')',' \n',...
        '72176.80c ',num2str(AD_Poison_Metal*Hf_Abundances(2),'%18.10e')',' \n',...
        '72177.80c ',num2str(AD_Poison_Metal*Hf_Abundances(3),'%18.10e')',' \n',...
        '72178.80c ',num2str(AD_Poison_Metal*Hf_Abundances(4),'%18.10e')',' \n',...
        '72179.80c ',num2str(AD_Poison_Metal*Hf_Abundances(5),'%18.10e')',' \n',...
        '72180.80c ',num2str(AD_Poison_Metal*Hf_Abundances(6),'%18.10e')',' \n',...
        '90232.80c ',num2str(0.0008784891*(1-Poison_load),'%18.10e'),' \n'];
    
elseif Poison_Type == 5   %Th Natural Composition0
    Poison =...
        ['90232.80c ',num2str(AD_Poison_Metal+0.0008784891*(1-Poison_load),'%18.10e'),' \n'];
else
      Poison =...
        ['90232.80c ',num2str(0.0008784891,'%18.10e'),' \n'];
end

% Mt3 Thermal Scattering for UO2
MCNP_pre.Material.normal.Fuel.Material_SAB_String1=  ' o2u.17t \n' ;
MCNP_pre.Material.normal.Fuel.Material_SAB_String2=  ' uo2.17t \n' ;

MCNP_pre.Material.normal.Fuel.Material_String = strcat(Fuel_String,Poison);

MCNP=mergestruct(MCNP,MCNP_pre)
end



