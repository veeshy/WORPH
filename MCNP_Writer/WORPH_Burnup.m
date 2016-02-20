function [] = WORPH_Burnup(fileID,MCNP)

%build the burn up list
Burnspecs.Mat_NumberUnique=MCNP.FuelCell{1}.Fuel.Mat_NumberUnique;
Burnspecs.Mat_Areas=MCNP.FuelCell{1}.Fuel.Mat_Areas;
%% burn up for fuel parts 
if 1< length(MCNP.FuelCell)
for kkk = 2:length(MCNP.FuelCell)    
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.FuelCell{kkk}.Fuel.Mat_NumberUnique];
Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas MCNP.FuelCell{kkk}.Fuel.Mat_Areas]
end
end

fuel_vol_total=sum(Burnspecs.Mat_Areas)*20;


if MCNP.Burnup.In_Clad==1
for kkk = 1:length(MCNP.FuelCell)    
 Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.FuelCell{kkk}.In_Clad.Mat_NumberUnique];
Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas MCNP.FuelCell{kkk}.In_Clad.Mat_Areas]; 
end
end

if MCNP.Burnup.Out_Clad==1
for kkk = 1:length(MCNP.FuelCell)    
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.FuelCell{kkk}.Out_Clad.Out_Clad_Cell_Number];
Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas MCNP.FuelCell{kkk}.Out_Clad.Mat_Areas]; 
end
end
%% burn up for normal tietubes 


Nparts=MCNP.Burnup.Normal_TieTube_Number;
if MCNP.Burnup.In_Metal_Normal==1
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{1}.In_Metal.Cell_Number];
Area_i= MCNP.TieTubeCell{1}.In_Metal.Mat_Areas*Nparts;
Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 

end


if MCNP.Burnup.In_Metal_Normal==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{1}.In_Metal.Cell_Number];

Area_i= MCNP.TieTubeCell{1}.In_Metal.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end


if MCNP.Burnup.Moderator_Normal==1    
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{1}.Moderator.Cell_Number];

Area_i= MCNP.TieTubeCell{1}.Moderator.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end

if MCNP.Burnup.Out_Metal_Normal==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{1}.Out_Metal.Cell_Number];

Area_i= MCNP.TieTubeCell{1}.Out_Metal.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end


if MCNP.Burnup.Out_Insulator_Normal==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{1}.Out_Insulator.Cell_Number];

Area_i= MCNP.TieTubeCell{1}.Out_Insulator.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end


if MCNP.Burnup.In_Insulator_Normal==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{1}.In_Insulator.Cell_Number];

Area_i= MCNP.TieTubeCell{1}.In_Insulator.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end

%% burn up for poisend tietubes 
if length(MCNP.TieTubeCell)==2
Nparts=MCNP.Burnup.Poisoned_TieTube_Number;

if MCNP.Burnup.In_Metal_Poisoned==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{2}.In_Metal.Cell_Number];

Area_i= MCNP.TieTubeCell{2}.In_Metal.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end


if MCNP.Burnup.Moderator_Poisoned==1    
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{2}.Moderator.Cell_Number];

Area_i= MCNP.TieTubeCell{2}.Moderator.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end

if MCNP.Burnup.Out_Metal_Poisoned==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{2}.Out_Metal.Cell_Number];

Area_i= MCNP.TieTubeCell{2}.Out_Metal.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end


if MCNP.Burnup.Out_Insulator_Poisoned==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{2}.Out_Insulator.Cell_Number];

Area_i= MCNP.TieTubeCell{2}.Out_Insulator.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end


if MCNP.Burnup.In_Insulator_Poisoned==1  
Burnspecs.Mat_NumberUnique=[Burnspecs.Mat_NumberUnique MCNP.TieTubeCell{2}.In_Insulator.Cell_Number];

Area_i= MCNP.TieTubeCell{2}.In_Insulator.Mat_Areas*Nparts;

Burnspecs.Mat_Areas=[Burnspecs.Mat_Areas Area_i]; 
end

end
%% print stuff


if ~strcmp(MCNP.Burnup.Option,'none') || ~strcmp(MCNP.Burnup.Option,'None');
  fprintf(fileID,MCNP.Burnup.String);


   
   Inf_power=MCNP.Burnup.Power_Desnity*fuel_vol_total/1000;
   fprintf(fileID,'      power= %.6e \n',Inf_power);
     ccounter=20;
    fprintf(fileID,'       mat=');
               for kk = 1:length( Burnspecs.Mat_NumberUnique);
                   if ccounter > 60;
                   fprintf(fileID,'   &\n        ');
                   ccounter=10;
                   end
                   cc=fprintf(fileID,' %i', Burnspecs.Mat_NumberUnique(kk));
                   ccounter=ccounter+cc;
               end
     fprintf(fileID,'\n');
    
    
    ccounter=20;
    fprintf(fileID,'       matvol=');
               for kk = 1:length(Burnspecs.Mat_NumberUnique);
                   if ccounter > 60;
                   fprintf(fileID,'   &\n        ');
                   ccounter=10;
                   end
                   cc=fprintf(fileID,' %.6e',Burnspecs.Mat_Areas(kk)*20); %all boundires must be 20 cm tall
                   ccounter=ccounter+cc;
               end
               
     fprintf(fileID,'\n');



end

end

