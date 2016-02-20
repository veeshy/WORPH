function [MCNP,cellcounter,planecounter]=Make_SSS_Boundry(MCNP,geom,cellcounter,planecounter)


if strcmp(MCNP.Fuel2Mod,'1to1x1')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to1x1(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to1x2by2')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to1x2by2(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to1x3by3')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to1x3by3(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to3x1')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to3x1(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to0x1')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to0x1(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'2to1x6')
    [MCNP,cellcounter,planecounter]=SSS_Bound2to1x6(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'3to1x3')
    error('not supported yet')
    %   [MCNP,cellcounter,planecounter]=SSS_Bound3to1x3(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to2x1')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to2x1(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to2x1')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to2x1(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to2x30')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to2x30(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to2x3')
    [MCNP,cellcounter,planecounter]=SSS_Bound1to2x3(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'bighex_align')
    error('not supported yet')
    %    [MCNP,cellcounter,planecounter]=SSS_Boundbighex_align(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'bighex_counter')
    error('not supported yet')
    %    [MCNP,cellcounter,planecounter]=SSS_Boundbighex_counter(MCNP,geom,cellcounter,planecounter);
else
    error('not supported mode type')
end


end

