function [MCNP,cellcounter,planecounter]=Make_MCNP_Lattice(MCNP,geom,cellcounter,planecounter)
ftf=geom.ftf*100;

%MAKE_MCNP_LATTICE makes the lattice for the MCNP writer to print
if isfield(MCNP,'Lattice');
    %incase there is no poisoned
Latticespecs=MCNP.Lattice;
end
ftf=geom.ftf*100;
Latticespecs.Hex_Surf_Number=planecounter;
Latticespecs.Hex_Cell_Number=cellcounter;
cellcounter=cellcounter+1;

if strcmp( MCNP.Fuel2Mod,'bighex_align')
    bftf=geom.Bighex.ftf*100;
Latticespecs.Hex_Surfs=[0,0,-300,0,0,600,bftf/2,0,0];
elseif strcmp( MCNP.Fuel2Mod,'bighex_counter')
    bftf=geom.Bighex.ftf*100;
Latticespecs.Hex_Surfs=[0,0,-300,0,0,600,0,bftf/2,0];
 else 
Latticespecs.Hex_Surfs=[0,0,-300,0,0,600,ftf/2,0,0];
end 
unicounter=2;
   % u=1 is for the lat
   % u=2 is for tie tubes
    
   
    [Fuel_Hex_Cords, TieTube_Tally,hexradX,hexradY] = CordsandSize(MCNP);
  
    Lattic=ones(hexradX*2+1,hexradY*2+1)*unicounter; % fill with tie tube
    unicounter=unicounter+1;
    
    if strcmp( MCNP.Fuel2Mod,'bighex_align') || strcmp( MCNP.Fuel2Mod,'bighex_counter')
   unicounter=unicounter-1; %mod and tietube are in the same uni
    end

    %location of fuel elenets in hex space
   
               
    %location of posioned fuel elms and taking out the normal fuel elm
   kk=1;
    if isfield(Latticespecs,'Poisoned_Fuel_Hex_Cords')
       for  kk=1:length(Latticespecs.Poisoned_Fuel_Hex_Cords(:,1))
           rownumber=ismember(Fuel_Hex_Cords,Latticespecs.Poisoned_Fuel_Hex_Cords(kk,:),'rows');
           if rownumber == 0
               error('The posioned fuel you tired to input does not overlap with a fuel elm')
           end
           Fuel_Hex_Cords(rownumber,:)=[];
       end
       
              %put in the posion fuel elemntents
    for kk = 1:length(Latticespecs.Poisoned_Fuel_Hex_Cords(:,1));
               LatX=Latticespecs.Poisoned_Fuel_Hex_Cords(kk,1)+hexradX+1;
               LatY=Latticespecs.Poisoned_Fuel_Hex_Cords(kk,2)+hexradY+1;
               FuelCellspecs{kk}.Type='poisoned';
               FuelCellspecs{kk}.Lat_Hex_Cords=Latticespecs.Poisoned_Fuel_Hex_Cords(kk,:);
               FuelCellspecs{kk}.Universe=unicounter;
               Lattic(LatX,LatY)=unicounter;
               unicounter=unicounter+1;

     end
    end
       
    %location of the posioned tietubes
     if isfield(Latticespecs,'Poisoned_TieTube_Hex_Cords')
       for  kk= 1: length(Latticespecs.Poisoned_TieTube_Hex_Cords(:,1))
           rownumber=ismember( TieTube_Tally,Latticespecs.Poisoned_TieTube_Hex_Cords(kk,:),'rows')
%            if rownumber == 0
%             %   error('The posioned Tietube you tired to input does not overlap with a tallied tietube')
%            end
           TieTube_Tally(rownumber,:)=[];
       end
     end
     
      

       

    
 %normal tietubes
       TieTubespecs{1}.Lat_Hex_Cords=TieTube_Tally;
       TieTubespecs{1}.Universe=2;
       TieTubespecs{1}.Type='normal';
        
    
 %put the normal fuel elems into the lattice
 for kk = 1:(length(Fuel_Hex_Cords(:,1)))
    
     %becuse fuel posined fuel elms may or may not be made before
     if isfield(Latticespecs,'Poisoned_Fuel_Hex_Cords')
      kkk=length(Latticespecs.Poisoned_Fuel_Hex_Cords(:,1))+kk;
     else 
         kkk=kk
     end
     
       LatX=Fuel_Hex_Cords(kk,1)+hexradX+1;
       LatY=Fuel_Hex_Cords(kk,2)+hexradY+1;
       FuelCellspecs{kkk}.Type='normal';
       FuelCellspecs{kkk}.Lat_Hex_Cords=Fuel_Hex_Cords(kk,:);
       FuelCellspecs{kkk}.Universe=unicounter;
       Lattic(LatX,LatY)=unicounter;
       unicounter=unicounter+1;
 end

%location of posioned TT
 if isfield(Latticespecs,'Poisoned_TieTube_Hex_Cords')
       for kk = 1:length(Latticespecs.Poisoned_TieTube_Hex_Cords(:,1))
            LatX=Latticespecs.Poisoned_TieTube_Hex_Cords(kk,1)+hexradX+1;
             LatY=Latticespecs.Poisoned_TieTube_Hex_Cords(kk,2)+hexradY+1;
             TieTubespecs{kk+1}.Type='poisoned';
             TieTubespecs{kk+1}.Lat_Hex_Cords=Latticespecs.Poisoned_TieTube_Hex_Cords(kk,:);
             TieTubespecs{kk+1}.Universe=unicounter;
             Lattic(LatX,LatY)=unicounter;
             unicounter=unicounter+1;
       end
 end

 
   
Latticespecs.Lattic_Specs=reshape(Lattic,[1,(hexradX*2+1)*(hexradY*2+1)]);



MCNP.FuelCell=FuelCellspecs;
MCNP.TieTubeCell=TieTubespecs;
MCNP.Lattice=Latticespecs;
end

