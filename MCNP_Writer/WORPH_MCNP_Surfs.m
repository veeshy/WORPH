function [] = WORPH_MCNP_Surfs(fileID,MCNP,geom);






Fuelspec=MCNP.FuelSurfs.NormalFuel.Fuel;
In_Cladspec=MCNP.FuelSurfs.NormalFuel.In_Clad;
Out_Cladspec=MCNP.FuelSurfs.NormalFuel.Out_Clad;
Coolantspec=MCNP.FuelSurfs.NormalFuel.Coolant;
[edge_nums,corner_nums] = edge_and_corner_numbers(geom.Hex_Size);
%%
%fuel
%planes for fuel meat
for kk=1:length(Fuelspec.Plane_Number)
fprintf(fileID,'%i p %.2f %.2f %.2f %.2f\n',Fuelspec.Plane_Number(kk),Fuelspec.Planes(kk,1)*1000,Fuelspec.Planes(kk,2)*1000,Fuelspec.Planes(kk,3)*1000,Fuelspec.Planes(kk,4)*1000);
end

%surfaces for clad in channel facing fuel
for kk=1:length(In_Cladspec.Fuel_Plane_Number)
fprintf(fileID,'%i c/z %.4f %.4f %.4f \n',In_Cladspec.Fuel_Plane_Number{kk},In_Cladspec.Chan_Pos{kk}(1),In_Cladspec.Chan_Pos{kk}(2),In_Cladspec.Fuel_Chan_Rad{kk}+In_Cladspec.Thickness{kk});
end

%surfaces for clad in channel facing coolent
for kk=1:length(In_Cladspec.Fuel_Plane_Number)
fprintf(fileID,'%i c/z %.4f %.4f %.4f \n',In_Cladspec.Coolant_Plane_Number{kk},In_Cladspec.Chan_Pos{kk}(1),In_Cladspec.Chan_Pos{kk}(2),In_Cladspec.Fuel_Chan_Rad{kk});
end
 
%surfaces for outside clad
%rounded edges
 for kk=1:length(corner_nums)
 fprintf(fileID,'%i c/z %.4f %.4f %.4f \n',Out_Cladspec.Rounded_Planes_Circles_Number{kk},Out_Cladspec.Rounded_Planes_Circles{kk}(1),Out_Cladspec.Rounded_Planes_Circles{kk}(2),Out_Cladspec.Rounded_Planes_Circles{kk}(3));
end
fprintf(fileID,'%i hex %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f  \n',Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number,Out_Cladspec.Rounded_Planes_Hexagon(1),Out_Cladspec.Rounded_Planes_Hexagon(2),Out_Cladspec.Rounded_Planes_Hexagon(3),Out_Cladspec.Rounded_Planes_Hexagon(4),Out_Cladspec.Rounded_Planes_Hexagon(5),Out_Cladspec.Rounded_Planes_Hexagon(6),Out_Cladspec.Rounded_Planes_Hexagon(7),Out_Cladspec.Rounded_Planes_Hexagon(8),Out_Cladspec.Rounded_Planes_Hexagon(9));
fprintf(fileID,'%i hex %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f  \n',Out_Cladspec.Outside_Plane_Number,Out_Cladspec.Outside_Plane(1),Out_Cladspec.Outside_Plane(2),Out_Cladspec.Outside_Plane(3),Out_Cladspec.Outside_Plane(4),Out_Cladspec.Outside_Plane(5),Out_Cladspec.Outside_Plane(6),Out_Cladspec.Outside_Plane(7),Out_Cladspec.Outside_Plane(8),Out_Cladspec.Outside_Plane(9));
fprintf(fileID,'%i hex %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f  \n',Out_Cladspec.Fuel_Plane_Number,Out_Cladspec.Fuel_Plane(1),Out_Cladspec.Fuel_Plane(2),Out_Cladspec.Fuel_Plane(3),Out_Cladspec.Fuel_Plane(4),Out_Cladspec.Fuel_Plane(5),Out_Cladspec.Fuel_Plane(6),Out_Cladspec.Fuel_Plane(7),Out_Cladspec.Fuel_Plane(8),Out_Cladspec.Fuel_Plane(9));

%%
% Posioned fuel
if isfield(MCNP.FuelSurfs,'PoisonedFuel')

Fuelspec=MCNP.FuelSurfs.PoisonedFuel.Fuel;
In_Cladspec=MCNP.FuelSurfs.PoisonedFuel.In_Clad;
Out_Cladspec=MCNP.FuelSurfs.PoisonedFuel.Out_Clad;
Coolantspec=MCNP.FuelSurfs.PoisonedFuel.Coolant;
[edge_nums,corner_nums] = edge_and_corner_numbers(geom.poisoned.Hex_Size);
    
%fuel
%planes for fuel meat
for kk=1:length(Fuelspec.Plane_Number)
fprintf(fileID,'%i p %.4f %.4f %.4f %.4f\n',Fuelspec.Plane_Number(kk),Fuelspec.Planes(kk,1),Fuelspec.Planes(kk,2),Fuelspec.Planes(kk,3),Fuelspec.Planes(kk,4));
end

%surfaces for clad in channel facing fuel
for kk=1:length(In_Cladspec.Fuel_Plane_Number)
fprintf(fileID,'%i c/z %.4f %.4f %.4f \n',In_Cladspec.Fuel_Plane_Number{kk},In_Cladspec.Chan_Pos{kk}(1),In_Cladspec.Chan_Pos{kk}(2),In_Cladspec.Fuel_Chan_Rad{kk}+In_Cladspec.Thickness{kk});
end

%surfaces for clad in channel facing coolent
for kk=1:length(In_Cladspec.Fuel_Plane_Number)
fprintf(fileID,'%i c/z %.4f %.4f %.4f \n',In_Cladspec.Coolant_Plane_Number{kk},In_Cladspec.Chan_Pos{kk}(1),In_Cladspec.Chan_Pos{kk}(2),In_Cladspec.Fuel_Chan_Rad{kk});
end
 
%surfaces for outside clad
%rounded edges
 for kk=1:length(corner_nums)
 fprintf(fileID,'%i c/z %.4f %.4f %.4f \n',Out_Cladspec.Rounded_Planes_Circles_Number{kk},Out_Cladspec.Rounded_Planes_Circles{kk}(1),Out_Cladspec.Rounded_Planes_Circles{kk}(2),Out_Cladspec.Rounded_Planes_Circles{kk}(3));
end
fprintf(fileID,'%i hex %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f  \n',Out_Cladspec.Rounded_Planes_Hexagon_Plane_Number,Out_Cladspec.Rounded_Planes_Hexagon(1),Out_Cladspec.Rounded_Planes_Hexagon(2),Out_Cladspec.Rounded_Planes_Hexagon(3),Out_Cladspec.Rounded_Planes_Hexagon(4),Out_Cladspec.Rounded_Planes_Hexagon(5),Out_Cladspec.Rounded_Planes_Hexagon(6),Out_Cladspec.Rounded_Planes_Hexagon(7),Out_Cladspec.Rounded_Planes_Hexagon(8),Out_Cladspec.Rounded_Planes_Hexagon(9));
fprintf(fileID,'%i hex %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f  \n',Out_Cladspec.Outside_Plane_Number,Out_Cladspec.Outside_Plane(1),Out_Cladspec.Outside_Plane(2),Out_Cladspec.Outside_Plane(3),Out_Cladspec.Outside_Plane(4),Out_Cladspec.Outside_Plane(5),Out_Cladspec.Outside_Plane(6),Out_Cladspec.Outside_Plane(7),Out_Cladspec.Outside_Plane(8),Out_Cladspec.Outside_Plane(9));
fprintf(fileID,'%i hex %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f  \n',Out_Cladspec.Fuel_Plane_Number,Out_Cladspec.Fuel_Plane(1),Out_Cladspec.Fuel_Plane(2),Out_Cladspec.Fuel_Plane(3),Out_Cladspec.Fuel_Plane(4),Out_Cladspec.Fuel_Plane(5),Out_Cladspec.Fuel_Plane(6),Out_Cladspec.Fuel_Plane(7),Out_Cladspec.Fuel_Plane(8),Out_Cladspec.Fuel_Plane(9));

end
%%
%Normal tietube planes

Tietubespecs=MCNP.TieTubeSurfs.normal;
%Tietubes
    
for kk= 1:length(Tietubespecs.In_Cool.Plane_Number)
fprintf(fileID,'%i c/z %.4f %.4f %.4f\n',Tietubespecs.In_Cool.Plane_Number(kk),Tietubespecs.In_Cool.Plane(kk,1),Tietubespecs.In_Cool.Plane(kk,2),Tietubespecs.In_Cool.Plane(kk,3)) ;
fprintf(fileID,'%i c/z %.4f %.4f %.4f\n',Tietubespecs.In_Metal.Plane_Number(kk),Tietubespecs.In_Metal.Plane(kk,1),Tietubespecs.In_Metal.Plane(kk,2),Tietubespecs.In_Metal.Plane(kk,3)) ;
end
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Moderator.Plane_Number,Tietubespecs.Moderator.Plane); 
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Out_Cool.Plane_Number,Tietubespecs.Out_Cool.Plane) ;
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Out_Metal.Plane_Number,Tietubespecs.Out_Metal.Plane) ;
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.In_Insulator.Plane_Number,Tietubespecs.In_Insulator.Plane) ;
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Out_Insulator.Plane_Number,Tietubespecs.Out_Insulator.Plane) ;

if isfield(Tietubespecs,'Fuel')
fprintf(fileID,'%i hex %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f  \n',Tietubespecs.Fuel.Plane_Number,Tietubespecs.Fuel.Plane(1),Tietubespecs.Fuel.Plane(2),Tietubespecs.Fuel.Plane(3),Tietubespecs.Fuel.Plane(4),Tietubespecs.Fuel.Plane(5),Tietubespecs.Fuel.Plane(6),Tietubespecs.Fuel.Plane(7),Tietubespecs.Fuel.Plane(8),Tietubespecs.Fuel.Plane(9));
end    
%%Poisend tietube planes
if isfield(MCNP.TieTubeSurfs,'poisoned')
Tietubespecs=MCNP.TieTubeSurfs.poisoned;
%Tietubes
    
for kk= 1:length(Tietubespecs.In_Cool.Plane_Number)
fprintf(fileID,'%i c/z %.4f %.4f %.4f\n',Tietubespecs.In_Cool.Plane_Number(kk),Tietubespecs.In_Cool.Plane(kk,1),Tietubespecs.In_Cool.Plane(kk,2),Tietubespecs.In_Cool.Plane(kk,3)) ;
fprintf(fileID,'%i c/z %.4f %.4f %.4f\n',Tietubespecs.In_Metal.Plane_Number(kk),Tietubespecs.In_Metal.Plane(kk,1),Tietubespecs.In_Metal.Plane(kk,2),Tietubespecs.In_Metal.Plane(kk,3)) ;
end
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Moderator.Plane_Number,Tietubespecs.Moderator.Plane); 
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Out_Cool.Plane_Number,Tietubespecs.Out_Cool.Plane) ;
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Out_Metal.Plane_Number,Tietubespecs.Out_Metal.Plane) ;
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.In_Insulator.Plane_Number,Tietubespecs.In_Insulator.Plane) ;
fprintf(fileID,'%i cz %.4f\n',Tietubespecs.Out_Insulator.Plane_Number,Tietubespecs.Out_Insulator.Plane) ;
end



%% Lattic planes
Lattice_Hexspecs=MCNP.Lattice;
Boundaryspecs=MCNP.Boundary;
fprintf(fileID,'%i hex ',Lattice_Hexspecs.Hex_Surf_Number);
for kk=1:9
    if kk~=7
            fprintf(fileID,'%.4f ',Lattice_Hexspecs.Hex_Surfs(kk));
    else
    fprintf(fileID,'%.4f ',Lattice_Hexspecs.Hex_Surfs(kk));
    end
end
fprintf(fileID,'\n');

% for kk=1:length(Lattice_Hexspecs.Plane_Number)
% fprintf(fileID,'%i p %.4f %.4f %.4f %.4f\n',Lattice_Hexspecs.Plane_Number(kk),Lattice_Hexspecs.Planes(kk,1),Lattice_Hexspecs.Planes(kk,2),Lattice_Hexspecs.Planes(kk,3),Lattice_Hexspecs.Planes(kk,4));
% end

%reflecting planes
for kk=1:length(Boundaryspecs.Plane_String)
fprintf(fileID,Boundaryspecs.Plane_String{kk});
fprintf(fileID,' \n');
end

fprintf(fileID,' \n');
%Makes the materials


end

