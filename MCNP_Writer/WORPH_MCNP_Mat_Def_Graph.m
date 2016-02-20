MCNP.Material.normal.Fuel.Material_String= ...
['40090.83c 0.0099844321 &\n'...
'40091.83c 0.0021773630 &\n'...
'40092.83c 0.0033281440 &\n'...
'40094.83c 0.0033727780 &\n'...
'40096.83c 0.0005433705 &\n'...
'6000.83c  0.1087381552 &\n'...
'92235.83c 0.0005074328 &\n'...
'92238.83c 0.0020540448 &\n'...
'92234.83c 0.0000053614 &\n'...
'92236.83c 0.0000024409 &\n'...
'92233.83c  1e-36 &\n'...
'94240.83c  1e-36 \n']

% ['74182.83c 0.0001929078 &\n'...
% '74183.83c 0.0001041702 &\n'...
% '74184.83c 0.0246977311 &\n'...
% '74186.83c 0.0002069573 &\n'...
% '90232.83c 0.0008784613 &\n'...
% '8016.83c 0.0292820449 &\n'...
% '92235.83c 0.0024095018 &\n'...
% '92238.83c 0.0113530593 \n']
%      
%enrichment 0.175076556291391 atom u235
%any material can have an SAB string, it is optional
MCNP.Material.normal.Fuel.Material_SAB_String=  'grph.17t \n' ;
%zrc
MCNP.Material.normal.In_Clad.Material_String=...
['6000.83c  -0.116252433 &\n'...
'40090.83c  -0.448114083 &\n'...
'40091.83c  -0.098810821 &\n'...
'40092.83c  -0.152694801 &\n'...
'40094.83c  -0.158112197 &\n'...
'40096.83c  -0.026015664 \n' ]
%zrc
MCNP.Material.normal.Out_Clad.Material_String=...
['6000.83c  -0.116252433 &\n'...
'40090.83c  -0.448114083 &\n'...
'40091.83c  -0.098810821 &\n'...
'40092.83c  -0.152694801 &\n'...
'40094.83c  -0.158112197 &\n'...
'40096.83c  -0.026015664 \n' ]
%zrc
MCNP.Material.normal.Coolant.Material_String= '1001.83c -1\n';
%MCNP.Material.normal.Coolant.Material_SAB_String='hpara.20t\n';
%Tietubes
MCNP.Material.normal.In_Cool.Material_String='1001.80c -1\n';
%MCNP.Material.normal.In_Cool.Material_SAB_String='hpara.20t\n';
%This is commented out becuse it is for liquied hydrogen 
MCNP.Material.normal.In_Metal.Material_String=...
    [ '8016.80c -1.196000e-03 &\n'...
'24050.80c -4.331965e-05 &\n'...
'24052.80c -8.353763e-04 &\n'...
'24053.80c -9.472497e-05 &\n'...
'24054.80c -2.357905e-05 &\n'...
'26054.80c -1.165493e-04 &\n'...
'26056.80c -1.829575e-03 &\n'...
'26057.80c -4.225286e-05 &\n'...
'26058.80c -5.623080e-06 &\n'...
'40090.80c -5.051659e-01 &\n'...
'40091.80c -1.101645e-01 &\n'...
'40092.80c -1.683886e-01 &\n'...
'40094.80c -1.706469e-01 &\n'...
'40096.80c -2.749202e-02 &\n'...
'50112.80c -1.353635e-04 &\n'...
'50114.80c -9.210300e-05 &\n'...
'50115.80c -4.744700e-05 &\n'...
'50116.80c -2.029057e-03 &\n'...
'50117.80c -1.071744e-03 &\n'...
'50118.80c -3.379901e-03 &\n'...
'50119.80c -1.198735e-03 &\n'...
'50120.80c -4.546539e-03 &\n'...
'50122.80c -6.461165e-04 &\n'...
'50124.80c -8.079945e-04 \n'];

MCNP.Material.normal.Moderator.Material_String=...
    ['40090.80c  -0.496737654 &\n'...
'40091.80c  -0.109532499 &\n'...
'40092.80c  -0.169263275 &\n'...
'40094.80c  -0.175268497 &\n'...
'40096.80c  -0.028838549 &\n'...
'1001.80c  -0.020312838 &\n'...
'1002.80c  -4.66879E-05 \n'];
MCNP.Material.normal.Moderator.Material_SAB_String=...
   ['zr/h.10t &\n'...
    '     h/zr.10t\n' ];

%     ['zr/h.30t \n'...
%      '     h/zr.20t\n' ];
MCNP.Material.normal.Out_Cool.Material_String='1001.80c -1\n';
%MCNP.Material.normal.Out_Cool.Material_SAB_String='hpara.10t\n';
%Should be some kind of zircaolly
MCNP.Material.normal.Out_Metal.Material_String=...
    [ '8016.80c -1.196000e-03 &\n'...
'24050.80c -4.331965e-05 &\n'...
'24052.80c -8.353763e-04 &\n'...
'24053.80c -9.472497e-05 &\n'...
'24054.80c -2.357905e-05 &\n'...
'26054.80c -1.165493e-04 &\n'...
'26056.80c -1.829575e-03 &\n'...
'26057.80c -4.225286e-05 &\n'...
'26058.80c -5.623080e-06 &\n'...
'40090.80c -5.051659e-01 &\n'...
'40091.80c -1.101645e-01 &\n'...
'40092.80c -1.683886e-01 &\n'...
'40094.80c -1.706469e-01 &\n'...
'40096.80c -2.749202e-02 &\n'...
'50112.80c -1.353635e-04 &\n'...
'50114.80c -9.210300e-05 &\n'...
'50115.80c -4.744700e-05 &\n'...
'50116.80c -2.029057e-03 &\n'...
'50117.80c -1.071744e-03 &\n'...
'50118.80c -3.379901e-03 &\n'...
'50119.80c -1.198735e-03 &\n'...
'50120.80c -4.546539e-03 &\n'...
'50122.80c -6.461165e-04 &\n'...
'50124.80c -8.079945e-04\n'];
%ZrC, low desnity
MCNP.Material.normal.In_Insulator.Material_String=...
['6000.80c  -0.116252433 &\n'...
'40090.80c  -0.448114083 &\n'...
'40091.80c  -0.098810821 &\n'...
'40092.80c  -0.152694801 &\n'...
'40094.80c  -0.158112197 &\n'...
'40096.80c  -0.026015664\n' ];
%ZrC, low desnity
MCNP.Material.normal.Out_Insulator.Material_String=...
['6000.80c -1\n'];
MCNP.Material.normal.Out_Insulator.Material_SAB_String=...
['grph.10t \n'];
%% poisoned materials
MCNP.Material.poisoned.Fuel.Material_String= ...
    ['74182.70c 0.0001871206 &\n'...
'74183.70c 0.0001010451 &\n'...
'74184.70c 0.0239567992 &\n'...
'74186.70c 0.0002007486 &\n'...
'90232.70c 0.0008523070 &\n'...
'8016.70c 0.0284102344 &\n'...
'92235.70c 0.0026371800 &\n'...
'92238.70c 0.0107156302\n'  ];
%any material can have an SAB string, it is optional
MCNP.Material.poisoned.Fuel.Material_SAB_String=  'o2/u.10t\n' ;
%enriched W
MCNP.Material.poisoned.In_Clad.Material_String=...
    ['74182.74c 0.0001815070 &\n'...
'74183.74c 0.0000980138 &\n'...
'74184.74c 0.0232380952 &\n'...
'74186.74c 0.0001947261 \n'];
%enriched W
MCNP.Material.poisoned.Out_Clad.Material_String=...
    ['74182.74c 0.0001815070 &\n'...
'74183.74c 0.0000980138 &\n'...
'74184.74c 0.0232380952 &\n'...
'74186.74c 0.0001947261 \n'];
MCNP.Material.poisoned.Coolant.Material_String= '1001.70c -1\n';
MCNP.Material.poisoned.Coolant.Material_SAB_String='hpara.10t\n';
%Tietubes
MCNP.Material.poisoned.In_Cool.Material_String='1001.70c -1\n';
MCNP.Material.poisoned.In_Cool.Material_SAB_String='hpara.10t\n';
MCNP.Material.poisoned.In_Metal.Material_String=...
    [ '8016.70c -1.196000e-03 &\n'...
'24050.70c -4.331965e-05 &\n'...
'24052.70c -8.353763e-04 &\n'...
'24053.70c -9.472497e-05 &\n'...
'24054.70c -2.357905e-05 &\n'...
'26054.70c -1.165493e-04 &\n'...
'26056.70c -1.829575e-03 &\n'...
'26057.70c -4.225286e-05 &\n'...
'26058.70c -5.623080e-06 &\n'...
'40090.70c -5.051659e-01 &\n'...
'40091.70c -1.101645e-01 &\n'...
'40092.70c -1.683886e-01 &\n'...
'40094.70c -1.706469e-01 &\n'...
'40096.70c -2.749202e-02 &\n'...
'50112.70c -1.353635e-04 &\n'...
'50114.70c -9.210300e-05 &\n'...
'50115.70c -4.744700e-05 &\n'...
'50116.70c -2.029057e-03 &\n'...
'50117.70c -1.071744e-03 &\n'...
'50118.70c -3.379901e-03 &\n'...
'50119.70c -1.198735e-03 &\n'...
'50120.70c -4.546539e-03 &\n'...
'50122.70c -6.461165e-04 &\n'...
'50124.70c -8.079945e-04\n'];
MCNP.Material.poisoned.Moderator.Material_String=...
    ['40090.71c  -0.496737654 &\n'...
'40091.71c  -0.109532499 &\n'...
'40092.71c  -0.169263275 &\n'...
'40094.71c  -0.175268497 &\n'...
'40096.71c  -0.028838549 &\n'...
'1001.71c  -0.020312838 &\n'...
'1002.71c  -4.66879E-05\n'];
MCNP.Material.poisoned.Moderator.Material_SAB_String=...
    ['zr/h.13t \n'...
     '     h/zr.13t\n' ];
MCNP.Material.poisoned.Out_Cool.Material_String='1001.70c -1\n';
MCNP.Material.poisoned.Out_Cool.Material_SAB_String='hpara.10t\n';
%Should be some kind of zircaolly
MCNP.Material.poisoned.Out_Metal.Material_String=...
    [ '8016.70c -1.196000e-03 &\n'...
'24050.70c -4.331965e-05 &\n'...
'24052.70c -8.353763e-04 &\n'...
'24053.70c -9.472497e-05 &\n'...
'24054.70c -2.357905e-05 &\n'...
'26054.70c -1.165493e-04 &\n'...
'26056.70c -1.829575e-03 &\n'...
'26057.70c -4.225286e-05 &\n'...
'26058.70c -5.623080e-06 &\n'...
'40090.70c -5.051659e-01 &\n'...
'40091.70c -1.101645e-01 &\n'...
'40092.70c -1.683886e-01 &\n'...
'40094.70c -1.706469e-01 &\n'...
'40096.70c -2.749202e-02 &\n'...
'50112.70c -1.353635e-04 &\n'...
'50114.70c -9.210300e-05 &\n'...
'50115.70c -4.744700e-05 &\n'...
'50116.70c -2.029057e-03 &\n'...
'50117.70c -1.071744e-03 &\n'...
'50118.70c -3.379901e-03 &\n'...
'50119.70c -1.198735e-03 &\n'...
'50120.70c -4.546539e-03 &\n'...
'50122.70c -6.461165e-04 &\n'...
'50124.70c -8.079945e-04\n'];
%ZrC, low desnity
MCNP.Material.poisoned.In_Insulator.Material_String=...
['6000.70c  -0.116252433 &\n'...
'40090.70c  -0.448114083 &\n'...
'40091.70c  -0.098810821 &\n'...
'40092.70c  -0.152694801 &\n'...
'40094.70c  -0.158112197 &\n'...
'40096.70c  -0.026015664\n' ];
%ZrC, low desnity
MCNP.Material.poisoned.Out_Insulator.Material_String=...
['6000.70c  -0.116252433 &\n'...
'40090.70c  -0.448114083 &\n'...
'40091.70c  -0.098810821 &\n'...
'40092.70c  -0.152694801 &\n'...
'40094.70c  -0.158112197 &\n'...
'40096.70c  -0.026015664\n' ];