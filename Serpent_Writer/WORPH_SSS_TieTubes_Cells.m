function [] = WORPH_MCNP_TieTubes_Cells(fileID,MCNP,geom);
for kkk = 1:length(MCNP.TieTubeCell)

Tietubespecs=MCNP.TieTubeCell{kkk};


if strcmp(MCNP.TieTubeCell{kkk}.Type,'normal')
Hex_Size=geom.Hex_Size;


elseif strcmp(MCNP.TieTubeCell{kkk}.Type,'poisoned')
Hex_Size=geom.poisoned.Hex_Size;

    
else 
    error('not a fuel type')
end 

[edge_nums,corner_nums] = edge_and_corner_numbers(Hex_Size);

if 0==strcmp( MCNP.Fuel2Mod,'bighex_counter')
  if 0== strcmp( MCNP.Fuel2Mod,'bighex_align')
      
      %if traditional tie tubes

%Tietubes
%
%in coolant
fprintf(fileID,'cell %i %i %i %.6f ',Tietubespecs.In_Cool.Cell_Number, MCNP.TieTubeCell{kkk}.Universe, Tietubespecs.In_Cool.Cell_Number);
fprintf(fileID,'-%i',Tietubespecs.In_Cool.Plane_Number(1));
fprintf(fileID,'\n');

%In metal
fprintf(fileID,'cell %i %i %i ',Tietubespecs.In_Metal.Cell_Number,MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.In_Metal.Cell_Number);
fprintf(fileID,'-%i %i',Tietubespecs.In_Metal.Plane_Number(1),Tietubespecs.In_Cool.Plane_Number(1));
fprintf(fileID,' \n');

%Moderator
fprintf(fileID,'cell %i %i %i ',Tietubespecs.Moderator.Cell_Number,MCNP.TieTubeCell{kkk}.Universe, Tietubespecs.Moderator.Cell_Number);
fprintf(fileID,'-%i %i',Tietubespecs.Moderator.Plane_Number,Tietubespecs.In_Metal.Plane_Number);
fprintf(fileID,' \n');

%Out Coolant
fprintf(fileID,'cell %i %i %i ',Tietubespecs.Out_Cool.Cell_Number,MCNP.TieTubeCell{kkk}.Universe, Tietubespecs.Out_Cool.Cell_Number);
fprintf(fileID,'-%i %i',Tietubespecs.Out_Cool.Plane_Number,Tietubespecs.Moderator.Plane_Number);
fprintf(fileID,' \n');

%Out Coolant
fprintf(fileID,'cell %i %i %i ',Tietubespecs.Out_Metal.Cell_Number, MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.Out_Metal.Cell_Number);
fprintf(fileID,'-%i %i',Tietubespecs.Out_Metal.Plane_Number,Tietubespecs.Out_Cool.Plane_Number);
fprintf(fileID,'\n');

%In_Insulator
fprintf(fileID,'cell %i %i %i ',Tietubespecs.In_Insulator.Cell_Number, MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.In_Insulator.Cell_Number);
fprintf(fileID,'-%i %i',Tietubespecs.In_Insulator.Plane_Number,Tietubespecs.Out_Metal.Plane_Number);
fprintf(fileID,'\n');


%In_Insulator
fprintf(fileID,'cell %i %i %i ',Tietubespecs.Out_Insulator.Cell_Number,MCNP.TieTubeCell{kkk}.Universe, Tietubespecs.Out_Insulator.Cell_Number);
fprintf(fileID,'%i',Tietubespecs.In_Insulator.Plane_Number);
fprintf(fileID,'\n');


  end
end



end
fprintf(fileID,' \n');
end

