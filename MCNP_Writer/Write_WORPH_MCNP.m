function [] = Write_WORPH_MCNP(MCNP,geom,inputFile)


[currentFolder] = fileparts(inputFile);
fileID = fopen([currentFolder,'/WORPH_MCNP.ip'],'wb');


fprintf(fileID,'WORPH \n');

%lattice and boundries

WORPH_MCNP_Lattice(fileID,MCNP,geom);

if strcmp( MCNP.Fuel2Mod,'bighex_align') || strcmp( MCNP.Fuel2Mod,'bighex_counter')
fprintf(fileID,'c fuel \n');
WORPH_MCNP_Fuel_Cells_bighex(fileID,MCNP,geom);
fprintf(fileID,'c TT \n');
WORPH_MCNP_TieTubes_Cells_bighex(fileID,MCNP,geom);
    
else
fprintf(fileID,'c fuel \n');
WORPH_MCNP_Fuel_Cells(fileID,MCNP,geom);
fprintf(fileID,'c TT \n');
WORPH_MCNP_TieTubes_Cells(fileID,MCNP,geom);

end

WORPH_MCNP_Surfs(fileID,MCNP,geom);


%Physics and burn up
fprintf(fileID,'c DATA \n');
if strcmp(MCNP.Burnup.Option,'cbc') || strcmp(MCNP.Burnup.Option,'whole') || strcmp(MCNP.Burnup.Option,'edges')
WORPH_Burnup(fileID,MCNP);
end 
fprintf(fileID,MCNP.Physics_String,' \n');

fprintf(fileID,'c Material \n');
WORPH_Materials(MCNP,fileID)
fprintf(fileID,'c Tally \n');
WORPH_MCNP_Tallies(MCNP,fileID)


fprintf(fileID,' \n');
fprintf(fileID,' \n');
fclose all;
