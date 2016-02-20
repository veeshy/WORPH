function [Fuelspecs,cellcounter,planecounter] = CBC_Fuel_Elm(MCNP,fuelgeom,cellcounter,planecounter)
ftf=fuelgeom.ftf*100;
ftf2=fuelgeom.ftf2*100;
Cool_Chan_Pos=fuelgeom.Cool_Chan_Pos*100;
Hex_Size=fuelgeom.Hex_Size;
Fuel_Chan_Rad=fuelgeom.Fuel_Chan_Rad*100;
Clad_In=fuelgeom.Clad_In*100;
Clad_Out=fuelgeom.Clad_Out*100;
ftf=fuelgeom.ftf*100;


f_error=.00001;
[edge_nums,corner_nums] = edge_and_corner_numbers(Hex_Size);

matcounter=cellcounter;

%
%Fuel meat part

%get all the planes for the inside channels
for kk= 1:length(Cool_Chan_Pos)
    if kk ~= edge_nums
      if kk ~= corner_nums
          
        if kk == 1 %for the first run
         Chan_Pos_i=Cool_Chan_Pos(kk,:);
         [Hex_Planes_i,Cell_Specs_i]=Make_Hex_Planes(Chan_Pos_i,ftf2);
         
         %Hex_Planes is for ploting
         Hex_Planes=Hex_Planes_i;
         %Hex_Planes_search is to make sure no planes are made twice
         Hex_Planes_search=Hex_Planes_i;
         Cell_Specs=Cell_Specs_i;
         plane_index=[planecounter:planecounter+5];
         planecounter=planecounter+5;
        else          
         Chan_Pos_i=Cool_Chan_Pos(kk,:);
         [Hex_Planes_i,Cell_Specs_i]=Make_Hex_Planes(Chan_Pos_i,ftf2);
         for ww=1:6 
        %checks if a plane already exists and only makes planes that there
        %are no close planes
         overlaps=(Hex_Planes_i(ww,1)==Hex_Planes_search(:,1) & ...
                    Hex_Planes_i(ww,2)==Hex_Planes_search(:,2) & ...
                     Hex_Planes_i(ww,3)==Hex_Planes_search(:,3) & ...
                     Hex_Planes_i(ww,4)<=Hex_Planes_search(:,4)+f_error & ...
                      Hex_Planes_i(ww,4)>=Hex_Planes_search(:,4)-f_error);
          if sum(overlaps) > 0
              inonzero=find(overlaps); %gives the first index it lines up at
             plane_index= [plane_index,plane_index( inonzero(1))];
             Hex_Planes_search= [Hex_Planes_search;Hex_Planes_i(ww,:)];
          else 
          planecounter=planecounter+1;
          Hex_Planes= [Hex_Planes;Hex_Planes_i(ww,:)];
          Hex_Planes_search= [Hex_Planes_search;Hex_Planes_i(ww,:)];
          plane_index=[plane_index,planecounter];
          end     
         end
          Cell_Specs=[Cell_Specs,Cell_Specs_i];
 
          
        end
      
          

       end
     end
    end

  
%puts it all into a nice array
Fuelspecs.CBC.Fuel.Planes=Hex_Planes;
Fuelspecs.CBC.Fuel.Plane_Number=[min(plane_index):max(plane_index)];

 hex_counter=1;
for kk= 1:length(Cool_Chan_Pos)
    if kk ~= edge_nums
      if kk ~= corner_nums
          
          Fuelspecs.CBC.Fuel.Cell_Specs{kk}=Cell_Specs(hex_counter:hex_counter+5).*plane_index(hex_counter:hex_counter+5);
          Fuelspecs.CBC.Fuel.Chan_Pos_i{kk}=Cool_Chan_Pos(kk,:);
          Fuelspecs.CBC.Fuel.plane_index{kk}=plane_index(hex_counter:hex_counter+5);
          hex_counter=hex_counter+6;
          Fuelspecs.CBC.Fuel.Cell_Number{kk}=cellcounter;
          cellcounter=cellcounter+1;
          Fuelspecs.CBC.Fuel.Mat_Number(kk)=matcounter;
          Fuelspecs.CBC.In_Clad.Mat_Number(kk)=matcounter+1;
          if strcmp(MCNP.Burnup.Option,'cbc') || strcmp(MCNP.Burnup.Option,'CBC')
          matcounter=matcounter+2;
          end
      end 
    end
    
end

 if strcmp(MCNP.Burnup.Option,'edges') || strcmp(MCNP.Burnup.Option,'Edges')
          matcounter=matcounter+1;
  end

 %uses the the existing planes to make the outside channels
 for kk=[edge_nums, corner_nums]
     if 0 < sum(kk==edge_nums)
  Chan_Pos_i=Cool_Chan_Pos(kk,:);
  [Hex_Planes_i,Cell_Specs_i]=Make_Hex_Planes_Edge(Chan_Pos_i,ftf2);
     elseif  0 < sum(kk==corner_nums)
          Chan_Pos_i=Cool_Chan_Pos(kk,:);
         [Hex_Planes_i,Cell_Specs_i]=Make_Hex_Planes_Corner(Chan_Pos_i,ftf2);
     end 
  counter_ec = 1;
    for ww=1:length(Hex_Planes_i(:,1))
        %checks if a plane already exists 
    coner_and_edge_overlap=(Hex_Planes_i(ww,1)==Hex_Planes_search(:,1) & ...
    Hex_Planes_i(ww,2)==Hex_Planes_search(:,2) & ...
    Hex_Planes_i(ww,3)==Hex_Planes_search(:,3) & ...
    Hex_Planes_i(ww,4)<=Hex_Planes_search(:,4)+f_error & ...
      Hex_Planes_i(ww,4)>=Hex_Planes_search(:,4)-f_error);
 if sum(coner_and_edge_overlap) > 0
     
     inonzero=find(coner_and_edge_overlap);
     usable_plane_for_ec = plane_index(inonzero(1));
     Fuelspecs.CBC.Fuel.plane_index{kk}(counter_ec)=usable_plane_for_ec(1);
     Fuelspecs.CBC.Fuel.Cell_Specs{kk}(counter_ec)=Cell_Specs_i(ww).* usable_plane_for_ec;
     counter_ec = counter_ec +1;
 end 
    end
    Fuelspecs.CBC.Fuel.Chan_Pos_i{kk}=Cool_Chan_Pos(kk,:);
    Fuelspecs.CBC.Fuel.Cell_Number{kk}=cellcounter;
    cellcounter=cellcounter+1;
    Fuelspecs.CBC.Fuel.Mat_Number(kk)=matcounter;
    Fuelspecs.CBC.In_Clad.Mat_Number(kk)=matcounter+1;
    if strcmp(MCNP.Burnup.Option,'cbc') || strcmp(MCNP.Burnup.Option,'CBC')
    matcounter=matcounter+2;
    end
    if strcmp(MCNP.Burnup.Option,'Edges') || strcmp(MCNP.Burnup.Option,'edges')
    matcounter=matcounter+2;
    end
    
 end
  
 %inside clad
 for kk = 1:length(Cool_Chan_Pos)
Fuelspecs.CBC.In_Clad.Fuel_Chan_Rad{kk}=Fuel_Chan_Rad(kk);
Fuelspecs.CBC.In_Clad.Cell_Number{kk}=cellcounter;
Fuelspecs.CBC.In_Clad.Thickness{kk}=Clad_In;
Fuelspecs.CBC.In_Clad.Chan_Pos{kk}=Cool_Chan_Pos(kk,:);
cellcounter=cellcounter+1;
planecounter=planecounter+1;
Fuelspecs.CBC.In_Clad.Fuel_Plane_Number{kk}=planecounter;
planecounter=planecounter+1;
Fuelspecs.CBC.In_Clad.Coolant_Plane_Number{kk}=planecounter;

end
%  
  %Coolant
for kk = 1:length(Cool_Chan_Pos)
Fuelspecs.CBC.Coolant.Cell_Number{kk}=cellcounter;
Fuelspecs.CBC.Coolant.Chan_Pos{kk}=Cool_Chan_Pos(kk,:);
cellcounter=cellcounter+1;
end
  
%  %outside clad

%make a hexigon 
%circle is cented on the channel
Fuelspecs.CBC.Out_Clad.Cell_Number{kk}=cellcounter;
planecounter=planecounter+1;
Fuelspecs.CBC.Out_Clad.Thickness=Clad_Out;

Fuelspecs.CBC.Out_Clad.Fuel_Plane=[0,0,-300,0,0,600,ftf/2-Clad_Out,0,0];
planecounter=planecounter+1;
Fuelspecs.CBC.Out_Clad.Fuel_Plane_Number=planecounter;
Fuelspecs.CBC.Out_Clad.Outside_Plane=[0,0,-300,0,0,600,ftf*10,0,0];
planecounter=planecounter+1;
Fuelspecs.CBC.Out_Clad.Outside_Plane_Number=planecounter;


Outside_webbing=(ftf/2-Clad_Out)-(Cool_Chan_Pos(edge_nums(1),1)+Fuel_Chan_Rad(edge_nums(1))+Clad_In);

Rounded_edge_rad=Outside_webbing+Clad_In+Fuel_Chan_Rad(corner_nums(1));

Inner_Hexagon_side=Cool_Chan_Pos(corner_nums(1),2)+sin(60*pi/180)*(Outside_webbing+Clad_In+Fuel_Chan_Rad(edge_nums(1)));

for kk=1:6
corner_chan=corner_nums(kk);
Fuelspecs.CBC.Out_Clad.Rounded_Planes_Circles{kk}=[Cool_Chan_Pos(corner_chan,1),Cool_Chan_Pos(corner_chan,2),Rounded_edge_rad];
planecounter=planecounter+1;
Fuelspecs.CBC.Out_Clad.Rounded_Planes_Circles_Number{kk}=planecounter;
end

Fuelspecs.CBC.Out_Clad.Rounded_Planes_Hexagon=[0 0 -301 0 0 602 0 Inner_Hexagon_side 0];
planecounter=planecounter+1;
Fuelspecs.CBC.Out_Clad.Rounded_Planes_Hexagon_Plane_Number=planecounter;


Fuelspecs.CBC.Out_Clad.Out_Clad_Cell_Number=cellcounter;
cellcounter=cellcounter+1;
Fuelspecs.CBC.Out_Clad.Graveyard=cellcounter;
cellcounter=cellcounter+1;

if Fuel_Chan_Rad(corner_nums(1)) ~= Fuel_Chan_Rad(edge_nums(1));
error('all outside channels must be the same size ')
end
 
% [Hex_Planes_i,Cell_Specs_i] = Make_Hex_Planes_Lattic(ftf)
%   for kk=1:6
%   Fuelspecs.CBC.Lattice_Hex.Planes(kk,:)=Hex_Planes_i(kk,:)
%   
%   planecounter=planecounter+1;
%   Fuelspecs.CBC.Lattice_Hex.Cell_Specs(kk)=planecounter.*Cell_Specs_i(kk);
%   Fuelspecs.CBC.Lattice_Hex.Plane_Number(kk)=planecounter;
%   Fuelspecs.CBC.Lattice_Hex.Cell_Number=cellcounter;
%   cellcounter=cellcounter+1;
% 
%   end
planecounter=planecounter+1;
Fuelspecs.CBC.Lattice_Hex.Plane_Number=planecounter;
Fuelspecs.CBC.Lattice_Hex.Cell_Number=cellcounter;
cellcounter=cellcounter+1;
Fuelspecs.CBC.Lattice_Hex.Plane=[0,0,-300,0,0,600,ftf/2,0,0];


% Asign areas to each
ctc=2/sqrt(3)*ftf2; %corner to corner of the small hexes
edgelength=ftf2/(3^0.5);


% total area for rounded and not round
if strcmp(fuelgeom.Hex_Corner,'rounded') || strcmp(fuelgeom.Hex_Corner,'Rounded')
    Area_Total_Hex=(ftf-Clad_Out*2)^2*sqrt(3)/2;
    Area_Edge_Parallelogram=Rounded_edge_rad^2*tan(30/180*pi);
    Area_Edge_Circle=1/6*Rounded_edge_rad^2*pi;
    Area_Total=Area_Total_Hex-Area_Edge_Parallelogram*6+Area_Edge_Circle*6;
elseif strcmp(fuelgeom.Hex_Corner,'pointed') || strcmp(fuelgeom.Hex_Corner,'Pointed')
    Area_Total=(ftf-Clad_Out*2)^2*sqrt(3)/2;
else
    error('corner type not supported')
end


    Area_Edge_Hex=(((ctc-edgelength)/2)*ftf2)/2+(ftf2*edgelength/2)+(ftf2*((ftf/2-Clad_Out)-(Cool_Chan_Pos(edge_nums(1),1))));

    Area_Inside_Hex=(ftf2)^2*sqrt(3)/2;

    Area_Corners_Hex=(Area_Total-(Area_Edge_Hex*length(edge_nums))-(Area_Inside_Hex*(length(Cool_Chan_Pos)-length(edge_nums)-length(corner_nums))))/6;





Fuelspecs.CBC.Fuel.Mat_NumberUnique=unique(Fuelspecs.CBC.Fuel.Mat_Number);
Fuelspecs.CBC.Fuel.Mat_Areas=zeros(1,length(Fuelspecs.CBC.Fuel.Mat_NumberUnique));


%area for fuel
for kk= 1:length(Cool_Chan_Pos)
    %find what kind hex it is
    if 0 < sum(kk == edge_nums)
    Area_i=Area_Edge_Hex;  
    elseif 0 < sum(kk == corner_nums)
    Area_i=Area_Corners_Hex;  
    else
    Area_i=Area_Inside_Hex;
    end
    
%minus the coolant channel
Area_i=Area_i-(Fuel_Chan_Rad(kk)+Clad_In)^2*pi;

hole_i=find(Fuelspecs.CBC.Fuel.Mat_NumberUnique==Fuelspecs.CBC.Fuel.Mat_Number(kk));

Fuelspecs.CBC.Fuel.Mat_Areas(hole_i)=Fuelspecs.CBC.Fuel.Mat_Areas(hole_i)+Area_i;

end




%area for coolantchannels
Fuelspecs.CBC.In_Clad.Mat_NumberUnique=unique(Fuelspecs.CBC.In_Clad.Mat_Number);
Fuelspecs.CBC.In_Clad.Mat_Areas=zeros(1,length(Fuelspecs.CBC.In_Clad.Mat_NumberUnique));

for kk= 1:length(Cool_Chan_Pos)
    
Area_i=(Fuel_Chan_Rad(kk)+Clad_In)^2*pi-(Fuel_Chan_Rad(kk))^2*pi;

hole_i=find(Fuelspecs.CBC.In_Clad.Mat_NumberUnique==Fuelspecs.CBC.In_Clad.Mat_Number(kk));

Fuelspecs.CBC.In_Clad.Mat_Areas(hole_i)=Fuelspecs.CBC.In_Clad.Mat_Areas(hole_i)+Area_i;
  

end


% area of outside clad
Fuelspecs.CBC.Out_Clad.Mat_Areas=(ftf)^2*sqrt(3)/2-Area_Total;


end


