function [MCNP,cellcounter,planecounter]=Make_MCNP_Boundry(MCNP,geom,cellcounter,planecounter);



if strcmp(MCNP.Fuel2Mod,'1to1x1')
  [MCNP,cellcounter,planecounter]=Bound1to1x1(MCNP,geom,cellcounter,planecounter);

elseif strcmp( MCNP.Fuel2Mod,'1to1x2by2')
    [MCNP,cellcounter,planecounter]=Bound1to1x2by2(MCNP,geom,cellcounter,planecounter)
 
 elseif strcmp( MCNP.Fuel2Mod,'1to1x3by3')
    [MCNP,cellcounter,planecounter]=Bound1to1x3by3(MCNP,geom,cellcounter,planecounter)
    
elseif strcmp( MCNP.Fuel2Mod,'1to3x1')

[MCNP,cellcounter,planecounter]=Bound1to3x1(MCNP,geom,cellcounter,planecounter)
    
elseif strcmp( MCNP.Fuel2Mod,'1to0x1')
    [MCNP,cellcounter,planecounter]=Bound1to0x1(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'2to1x6')
    [MCNP,cellcounter,planecounter]=Bound2to1x6(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'3to1x3')
    [MCNP,cellcounter,planecounter]=Bound3to1x3(MCNP,geom,cellcounter,planecounter);
 elseif strcmp( MCNP.Fuel2Mod,'1to2x1')
 [MCNP,cellcounter,planecounter]=Bound1to2x1(MCNP,geom,cellcounter,planecounter);
 
elseif strcmp( MCNP.Fuel2Mod,'1to2x1')
 [MCNP,cellcounter,planecounter]=Bound1to2x1(MCNP,geom,cellcounter,planecounter);

elseif strcmp( MCNP.Fuel2Mod,'1to2x30')
 [MCNP,cellcounter,planecounter]=Bound1to2x30(MCNP,geom,cellcounter,planecounter);
elseif strcmp( MCNP.Fuel2Mod,'1to2x3')
 [MCNP,cellcounter,planecounter]=Bound1to2x3(MCNP,geom,cellcounter,planecounter); 
elseif strcmp( MCNP.Fuel2Mod,'bighex_align')
 [MCNP,cellcounter,planecounter]=Boundbighex_align(MCNP,geom,cellcounter,planecounter); 
elseif strcmp( MCNP.Fuel2Mod,'bighex_counter')
 [MCNP,cellcounter,planecounter]=Boundbighex_counter(MCNP,geom,cellcounter,planecounter); 
 
else 
    error('not supported mode trype')
end


end

