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
fprintf(fileID,'%i %i %.6f ',Tietubespecs.In_Cool.Cell_Number, Tietubespecs.In_Cool.Cell_Number,Tietubespecs.In_Cool.Density);
fprintf(fileID,'-%i',Tietubespecs.In_Cool.Plane_Number(1));
 fprintf(fileID,' & \n');
fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.In_Cool.Temp);

%In metal
fprintf(fileID,'%i %i %.6f ',Tietubespecs.In_Metal.Cell_Number, Tietubespecs.In_Metal.Cell_Number,Tietubespecs.In_Metal.Density);
fprintf(fileID,'-%i %i',Tietubespecs.In_Metal.Plane_Number(1),Tietubespecs.In_Cool.Plane_Number(1));
fprintf(fileID,' & \n');
fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.In_Metal.Temp);

%Moderator
fprintf(fileID,'%i %i %.6f ',Tietubespecs.Moderator.Cell_Number, Tietubespecs.Moderator.Cell_Number,Tietubespecs.Moderator.Density);
fprintf(fileID,'-%i %i',Tietubespecs.Moderator.Plane_Number,Tietubespecs.In_Metal.Plane_Number);
fprintf(fileID,' & \n');
fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.Moderator.Temp);

%Out Coolant
fprintf(fileID,'%i %i %.6f ',Tietubespecs.Out_Cool.Cell_Number, Tietubespecs.Out_Cool.Cell_Number,Tietubespecs.Out_Cool.Density);
fprintf(fileID,'-%i %i',Tietubespecs.Out_Cool.Plane_Number,Tietubespecs.Moderator.Plane_Number);
fprintf(fileID,' & \n');
fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.Out_Cool.Temp);

%Out Metal
fprintf(fileID,'%i %i %.6f ',Tietubespecs.Out_Metal.Cell_Number, Tietubespecs.Out_Metal.Cell_Number,Tietubespecs.Out_Metal.Density);
fprintf(fileID,'-%i %i',Tietubespecs.Out_Metal.Plane_Number,Tietubespecs.Out_Cool.Plane_Number);
fprintf(fileID,' & \n');
fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.Out_Metal.Temp);

%In_Insulator
fprintf(fileID,'%i %i %.6f ',Tietubespecs.In_Insulator.Cell_Number, Tietubespecs.In_Insulator.Cell_Number,Tietubespecs.In_Insulator.Density);
fprintf(fileID,'-%i %i',Tietubespecs.In_Insulator.Plane_Number,Tietubespecs.Out_Metal.Plane_Number);
fprintf(fileID,' & \n');
fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.In_Insulator.Temp);

%In_Insulator
fprintf(fileID,'%i %i %.6e ',Tietubespecs.Out_Insulator.Cell_Number, Tietubespecs.Out_Insulator.Cell_Number,Tietubespecs.Out_Insulator.Density);
fprintf(fileID,'-%i %i',Tietubespecs.Out_Insulator.Plane_Number,Tietubespecs.In_Insulator.Plane_Number);
fprintf(fileID,' & \n');
fprintf(fileID,'imp:n=1 u=%i tmp=%.6e \n',MCNP.TieTubeCell{kkk}.Universe,Tietubespecs.Out_Insulator.Temp);

%Graveyard
fprintf(fileID,'%i 0  ',Tietubespecs.Graveyard.Cell_Number);
fprintf(fileID,' %i ',Tietubespecs.Out_Insulator.Plane_Number);
fprintf(fileID,'imp:n=0 u=%i \n',MCNP.TieTubeCell{kkk}.Universe);
  end
end



end
fprintf(fileID,' \n');
end

