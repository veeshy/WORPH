function [] = Write_WORPH_SSS(MCNP,geom,inputFile)


[currentFolder] = fileparts(inputFile);
fileID = fopen([currentFolder,'/WORPH_SSS.ip'],'wb');


fprintf(fileID,'%%  WORPH - Serpent Version - SULEU - Graph 1 \n\n');

%lattice and boundries
fprintf(fileID,'%%  Lattice \n');
WORPH_SSS_Lattice(fileID,MCNP,geom);
fprintf(fileID,'\n');

if strcmp( MCNP.Fuel2Mod,'bighex_align') || strcmp( MCNP.Fuel2Mod,'bighex_counter')
    fprintf(fileID,'%%  Fuel \n');
    WORPH_SSS_Fuel_Cells_bighex(fileID,MCNP,geom);
    fprintf(fileID,'\n');
    fprintf(fileID,'%%  TT \n');
    WORPH_SSS_TieTubes_Cells_bighex(fileID,MCNP,geom);
    
else
    fprintf(fileID,'%%  Fuel \n');
    WORPH_SSS_Fuel_Cells(fileID,MCNP,geom);
    fprintf(fileID,'\n');
    fprintf(fileID,'%%  TT \n');
    WORPH_SSS_TieTubes_Cells(fileID,MCNP,geom);
    fprintf(fileID,' \n');
    
end
fprintf(fileID,'%% Surfaces \n');
WORPH_SSS_Surfs(fileID,MCNP,geom);
fprintf(fileID,' \n');


%Physics and burn up
if strcmp(MCNP.Burnup.Option,'cbc') || strcmp(MCNP.Burnup.Option,'whole') || strcmp(MCNP.Burnup.Option,'edges')
    [MCNP]=SSS_WORPH_Burnup(fileID,MCNP);
    fprintf(fileID,MCNP.Burnup.String,' \n');
end
fprintf(fileID,'%%  \n');
fprintf(fileID,MCNP.Physics_String,' \n');
Write_SSS_Fuel_Mats(MCNP,fileID);
Write_SSS_Tietube_Mats(MCNP,fileID);

%WORPH_MCNP_Tallies(MCNP,fileID)


fprintf(fileID,' \n');
fprintf(fileID,' \n');
fclose all;
