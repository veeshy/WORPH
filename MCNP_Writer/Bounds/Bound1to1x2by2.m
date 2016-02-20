function [MCNP,cellcounter,planecounter]=Bound1to1x1by2(MCNP,geom,cellcounter,planecounter)
Latticespecs=MCNP.Lattice;
%makes the lattice strings and an boundry
[Fuel_Hex_Cords, TieTube_Tally, hexradX, hexradY] =  CordsandSize(MCNP);

    ftf=geom.ftf*100;
   %firstline of lattice
    part1=[num2str(Latticespecs.Hex_Cell_Number), ' 0 '];
    part2=[num2str(-Latticespecs.Hex_Surf_Number), ' &\n'];
    part3='imp:n=1 u=1 lat=2 fill='
    part4=[num2str(-hexradX) ':' num2str(hexradX) ' '  num2str(-hexradY) ':' num2str(hexradY)]
    part5= [' 0:0 &\n'];
    MCNP.Lattice.Lattic_String{1}=[part1 part2 part3 part4 part5]
        
    planecounter=planecounter+1;
    MCNP.Boundary.Boundery_Cell_Number=cellcounter;
    MCNP.Boundary.Cell_String{1}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
       ' imp:n=1 fill=1 lat=1 \n '];
    cellcounter=cellcounter+1;
    MCNP.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
       ' imp:n=0\n'];
    cellcounter=cellcounter+1;
    ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
    edgelength=ftf/(3^0.5);

    boundY=ctc+edgelength+.000001;
    boundX=ftf+.000001;
    MCNP.Boundary.Plane_String{1}=[num2str(planecounter) ' RPP ',...
    num2str(-boundX,'%.4f'),' ',num2str(boundX,'%.4f'),' ',...
    num2str(-(boundY),'%.4f'),' ',num2str((boundY),'%.4f'),...
    ' -10 10 '];
end

