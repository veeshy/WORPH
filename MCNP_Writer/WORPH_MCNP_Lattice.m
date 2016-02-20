function [] =WORPH_MCNP_Lattice(fileID,MCNP,geom)


Latticespecs=MCNP.Lattice;
Boundaryspecs=MCNP.Boundary;


%the space to fill with the lattic
for kk=1:length(Latticespecs.Lattic_String)
fprintf(fileID,Latticespecs.Lattic_String{kk});
end

%the lattice
latcounter=15;
for kk=1:length(Latticespecs.Lattic_Specs)
    if latcounter > 50
        fprintf(fileID,' & \n');
        latcounter=15;
    end
cc=fprintf(fileID,[num2str(Latticespecs.Lattic_Specs(kk)),' ']);
latcounter=cc+latcounter;
end
fprintf(fileID,' \n');

%the boundrey that cuts up the lattice
for kk=1:length(Boundaryspecs.Cell_String)
fprintf(fileID,Boundaryspecs.Cell_String{kk});
end
for kk=1:length(Boundaryspecs.Graveyard_Cell_String)
fprintf(fileID,Boundaryspecs.Graveyard_Cell_String{kk});
end


end

