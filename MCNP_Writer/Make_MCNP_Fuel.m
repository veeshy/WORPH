function [MCNP,cellcounter,planecounter]=Make_MCNP_Fuel(MCNP,geom,cellcounter,planecounter);
% This is porly writen becuause CBC_Fuel_Elm_MCNP is very complex and I
% don't want to rewrite it
%I make the surfs and cells in sperert structures and there is some overlap
planecounter=planecounter+1;
%geom for normal fuel elm
fuelgeomnormal.ftf=geom.ftf;
fuelgeomnormal.ftf2=geom.ftf2;
fuelgeomnormal.Clad_In=geom.Clad_In;
fuelgeomnormal.Clad_Out=geom.Clad_Out;
fuelgeomnormal.Hex_Size=geom.Hex_Size;
fuelgeomnormal.Fuel_Chan_Rad=geom.Fuel_Chan_Rad;
fuelgeomnormal.Hex_Corner=geom.Hex_Corner;
[Cool_Chan_Pos] = Make_Cool_Chans_WORPH(fuelgeomnormal);
fuelgeomnormal.Cool_Chan_Pos=Cool_Chan_Pos;
planecounternormal=planecounter;
[Fuelspecs,~,planecounter] = CBC_Fuel_Elm_MCNP(MCNP,fuelgeomnormal,cellcounter,planecounternormal)
MCNP.FuelSurfs.NormalFuel=Fuelspecs.CBC;
MCNP.FuelSurfs.NormalFuel=Fuelspecs.CBC;

%geom for poisoned fuel elm
if isfield(MCNP.Lattice,'Poisoned_Fuel_Hex_Cords')
fuelgeomnpoisoned.ftf=geom.ftf; %becuse all fuel has to have the same ftf
fuelgeomnpoisoned.ftf2=geom.poisoned.ftf2;
fuelgeomnpoisoned.Clad_In=geom.poisoned.Clad_In;
fuelgeomnpoisoned.Clad_Out=geom.poisoned.Clad_Out;
fuelgeomnpoisoned.Hex_Size=geom.poisoned.Hex_Size;
fuelgeomnpoisoned.Fuel_Chan_Rad=geom.poisoned.Fuel_Chan_Rad;
fuelgeomnpoisoned.Hex_Corner=geom.poisoned.Hex_Corner;
[Cool_Chan_Pos] = Make_Cool_Chans_WORPH(fuelgeomnpoisoned);
fuelgeompoisoned.Cool_Chan_Pos=Cool_Chan_Pos;
planecouterpoisoned=planecounter;
[Fuelspecs,~,planecounter] = CBC_Fuel_Elm_MCNP(MCNP,fuelgeomnormal,cellcounter,planecouterpoisoned)
MCNP.FuelSurfs.PoisonedFuel=Fuelspecs.CBC;
MCNP.FuelSurfs.PoisonedFuel=Fuelspecs.CBC;
end


%geom for posion fuel elm
for kk = 1:length(MCNP.FuelCell)
 if strcmp( MCNP.FuelCell{kk}.Type,'poisoned') 
[Fuelspecs,cellcounter,~] = CBC_Fuel_Elm_MCNP(MCNP,fuelgeomnormal,cellcounter,planecouterpoisoned);
% add in the geom
MCNP.FuelCell{kk}=mergestruct(MCNP.FuelCell{kk}, Fuelspecs.CBC);
%add in the the dnesities
MCNP.FuelCell{kk}=mergestruct(MCNP.FuelCell{kk}, MCNP.Density.poisoned.Fuel);
% add in the temps
MCNP.FuelCell{kk}=mergestruct(MCNP.FuelCell{kk}, MCNP.Temp.poisoned.Fuel);

 elseif strcmp( MCNP.FuelCell{kk}.Type,'normal')
[Fuelspecs,cellcounter,~] = CBC_Fuel_Elm_MCNP(MCNP,fuelgeomnormal,cellcounter,planecounternormal);

% add in the geom
MCNP.FuelCell{kk}=mergestruct(MCNP.FuelCell{kk}, Fuelspecs.CBC);
%add in the the dnesities
MCNP.FuelCell{kk}=mergestruct(MCNP.FuelCell{kk}, MCNP.Density.normal.Fuel);
% add in the temps
MCNP.FuelCell{kk}=mergestruct(MCNP.FuelCell{kk}, MCNP.Temp.normal.Fuel);

 end

end




end

