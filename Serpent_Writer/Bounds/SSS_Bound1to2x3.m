function [MCNP,cellcounter,planecounter]=SSS_Bound1to2x3(MCNP,geom,cellcounter,planecounter)
Latticespecs=MCNP.Lattice;
%makes the lattice strings and an boundry
[Fuel_Hex_Cords, TieTube_Tally, hexradX, hexradY] =  CordsandSize(MCNP);

    ftf=geom.ftf*100;
   %lattice
    MCNP.Lattice.Lattic_String{1}=['lat 1 2 0 0 ', num2str(2*hexradX)+1,' ',num2str(2*hexradY)+1,' ',num2str(ftf),'\n'];

   %lattice cell 
    planecounter=planecounter+1;
    MCNP.Boundary.Boundery_Cell_Number=cellcounter;
    MCNP.Boundary.Cell_String{1}=['cell ',num2str(cellcounter), ' 0 fill 1 -',num2str(planecounter),'\n'];
    cellcounter=cellcounter+1;
   %outside
    MCNP.Boundary.Graveyard_Cell_String{1}=['cell ',num2str(cellcounter), ' 0 outside ',num2str(planecounter),'\n'];
    cellcounter=cellcounter+1;
    ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
    edgelength=ftf/(3^0.5);

    MCNP.Boundary.Plane_String{1}=['surf ', num2str(planecounter) ' hexxc ', '0 0 ',num2str((ftf*1.5+.00001),'%.4f'), ' \n' ];

  
end


