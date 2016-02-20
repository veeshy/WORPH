function [MCNP,cellcounter,planecounter]=Make_MCNP_TieTube(MCNP,geom,cellcounter,planecounter);

%geom for normal fuel elm
tietubegeomnormal.Mod_Geom=geom.Mod_Geom;
tietubegeomnormal.ftf=geom.ftf;
if isfield(geom,'Bighex')
tietubegeomnormal.Bighex=geom.Bighex;
end

[TieTubespecs,cellcounter,planecounter] = Tietube_Math(MCNP,tietubegeomnormal,cellcounter,planecounter)
MCNP.TieTubeSurfs.normal=TieTubespecs.TieTube;
MCNP.TieTubeCell{1}=mergestruct(MCNP.TieTubeCell{1}, TieTubespecs.TieTube);
MCNP.TieTubeCell{1}=mergestruct(MCNP.TieTubeCell{1}, MCNP.Density.normal.TieTube);
MCNP.TieTubeCell{1}=mergestruct(MCNP.TieTubeCell{1}, MCNP.Temp.normal.TieTube);

if isfield(MCNP.Lattice,'Poisoned_TieTube_Hex_Cords')
tietubepoisoned.Mod_Geom=geom.poisoned.Mod_Geom;
tietubepoisoned.ftf=geom.poisoned.ftf;

if isfield(geom,'Bighex')
tietubepoisoned.Bighex=geom.Bighex;
end


[TieTubespecs,cellcounter,planecounter] = Tietube_Math(MCNP,tietubepoisoned,cellcounter,planecounter)
MCNP.TieTubeSurfs.poisoned=TieTubespecs.TieTube;
MCNP.TieTubeCell{2}=mergestruct(MCNP.TieTubeCell{2}, TieTubespecs.TieTube);
MCNP.TieTubeCell{2}=mergestruct(MCNP.TieTubeCell{2}, MCNP.Density.poisoned.TieTube);
MCNP.TieTubeCell{2}=mergestruct(MCNP.TieTubeCell{2}, MCNP.Temp.poisoned.TieTube);

end

end

