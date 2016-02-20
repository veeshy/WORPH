function [] = WORPH(inputFile)

% I8,        8        ,8I   ,ad8888ba,    88888888ba   88888888ba   88        88  
% `8b       d8b       d8'  d8"'    `"8b   88      "8b  88      "8b  88        88  
%  "8,     ,8"8,     ,8"  d8'        `8b  88      ,8P  88      ,8P  88        88  
%   Y8     8P Y8     8P   88          88  88aaaaaa8P'  88aaaaaa8P'  88aaaaaaaa88  
%   `8b   d8' `8b   d8'   88          88  88""""88'    88""""""'    88""""""""88  
%    `8a a8'   `8a a8'    Y8,        ,8P  88    `8b    88           88        88  
%     `8a8'     `8a8'      Y8a.    .a8P   88     `8b   88           88        88  
%      `8'       `8'        `"Y8888Y"'    88      `8b  88           88        88  

% Well Organized Reactor Physics-An Infinite Lactice code for NTP type fuels
% Michael Eades 6/15 - present 
% Paolo Venneri 8/15 - present
%mike.eades.15@gmail.com

run(inputFile)

cellcounter=100;
planecounter=100;
% The Math for the MCNP and Serpent inputs
[MCNP,cellcounter,planecounter]= Make_MCNP_Lattice(MCNP,geom,cellcounter,planecounter);
%Make the Boundry on the lattice

if code.Type == 1
    [MCNP,cellcounter,planecounter]=Make_MCNP_Boundry(MCNP,geom,cellcounter,planecounter);
elseif code.Type == 2
    [MCNP,cellcounter,planecounter]=Make_SSS_Boundry(MCNP,geom,cellcounter,planecounter);
else
    error('not a code option')
end

[MCNP,cellcounter,planecounter]=Make_MCNP_Fuel(MCNP,geom,cellcounter,planecounter);

[MCNP,cellcounter,planecounter]=Make_MCNP_TieTube(MCNP,geom,cellcounter,planecounter);

if code.Type == 1
    Write_WORPH_MCNP(MCNP,geom,inputFile);
elseif code.Type == 2
    Write_WORPH_SSS(MCNP,geom,inputFile);
else
    error('not a code option')
end



