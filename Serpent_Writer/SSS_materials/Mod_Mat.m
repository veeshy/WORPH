function  [MCNP]  = Mod_Mat(MCNP)

Poison_load = MCNP.Material.normal.Moderator.Poison_Frac; % pmm loaded
Poison_Type = MCNP.Material.normal.Moderator.Poison_Type;



startm=0.9999999999000
ppm=Poison_load*10^-6
addm=startm*ppm/(1-ppm)



Gd_Abundances    = [.002;.0218;0.148;0.2047;0.1565;0.2484;0.2186];
Gd_sum           = Gd_Abundances(1)+Gd_Abundances(2) + Gd_Abundances(3) + Gd_Abundances(4) + Gd_Abundances(6) + Gd_Abundances(7);
GD_FW152         = Gd_Abundances(1)/Gd_sum;
GD_FW154         = Gd_Abundances(2)/Gd_sum;
GD_FW155         = Gd_Abundances(3)/Gd_sum;
GD_FW156         = Gd_Abundances(4)/Gd_sum;
GD_FW158         = Gd_Abundances(6)/Gd_sum;
GD_FW160         = Gd_Abundances(7)/Gd_sum;




%% Write fuel composition to file if flaged

TT_Metal=...
         ['40090.80c  -0.496737654  \n'...
'40091.80c  -0.109532499  \n'...
'40092.80c  -0.169263275  \n'...
'40094.80c  -0.175268497  \n'...
'40096.80c  -0.028838549  \n'...
'1001.80c  -0.020312838  \n'...
'1002.80c  -4.66879E-05\n'];


if Poison_Type == 1; %Gd Natural Composition
    Poison =...
       error('not done');
elseif Poison_Type == 2; % Gd-157 enriched
    Poison =...
       ['64152.80c ',num2str(-addm*GD_FW152*.05,'%18.10e'),' \n',...
        '64154.80c ',num2str(-addm*GD_FW154*.05,'%18.10e'),' \n',...
        '64155.80c ',num2str(-addm*GD_FW155*.05,'%18.10e'),' \n',...
        '64156.80c ',num2str(-addm*GD_FW156*.05,'%18.10e'),' \n',...
        '64157.80c ',num2str(-addm*.95,'%18.10e'),' \n',...
        '64158.80c ',num2str(-addm*GD_FW158*.05,'%18.10e'),' \n',...
        '64160.80c ',num2str(-addm*GD_FW160*.05,'%18.10e'),' \n']  ;
    
elseif Poison_Type == 3; %Hafnium Composition
  error('not done');
    
elseif Poison_Type == 4; %Hf enriched Composition
error('not done');
    
elseif Poison_Type == 5   %Th Natural Composition0
  error('not done');
    
end

% Mt3 Thermal ScatterOutg for UO2
if exist('Poison')
MCNPpre.Material.normal.Moderator.Material_String = strcat(TT_Metal,Poison);
else 
MCNPpre.Material.normal.Moderator.Material_String =TT_Metal;
end
MCNP=mergestruct(MCNP,MCNPpre);
end





