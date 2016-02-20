function [] = WORPH_MCNP_Tallies(MCNP,fileID)

Tallyspec=MCNP.Talllies;
Latticspec=MCNP.Lattice;
Boundaryspec=MCNP.Boundary;


%% F6 tally for fuel
if 1 == Tallyspec.F6.FuelCBC

for kkk= 1:length(MCNP.FuelCell)
    Fuelspec=MCNP.FuelCell{kkk};

fprintf(fileID,'F%i6:n,p (',Fuelspec.Fuel.Cell_Number{2});

ccounter=15;
for kk=1:length(Fuelspec.Fuel.Cell_Number)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,[num2str(Fuelspec.Fuel.Cell_Number{kk}),' ']);
ccounter=cc+ccounter;
end
fprintf(fileID,' & \n');
fprintf(fileID,'< %i[%i %i 0] ',Latticspec.Hex_Cell_Number, Fuelspec.Lat_Hex_Cords(1),Fuelspec.Lat_Hex_Cords(2));

fprintf(fileID,' < (%i)) T',Boundaryspec.Boundery_Cell_Number);
fprintf(fileID,'\n' );
fprintf(fileID,'SD%i6 1 %ir 1',Fuelspec.Fuel.Cell_Number{2},length(Fuelspec.Fuel.Cell_Number)-1);
fprintf(fileID,'\n' );
fprintf(fileID,'FC%i6 Fuel at  %i  %i \n',Fuelspec.Fuel.Cell_Number{2},Fuelspec.Lat_Hex_Cords(1),Fuelspec.Lat_Hex_Cords(2));
end
end

%% F4 Tally for cbc fuel 
if 1 == Tallyspec.F4.FuelCBC
for kkk= 1:length(MCNP.FuelCell)
    Fuelspec=MCNP.FuelCell{kkk};

fprintf(fileID,'F%i4:n,p (',Fuelspec.Fuel.Cell_Number{2});

ccounter=15;
for kk=1:length(Fuelspec.Fuel.Cell_Number)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,[num2str(Fuelspec.Fuel.Cell_Number{kk}),' ']);
ccounter=cc+ccounter;
end
fprintf(fileID,' & \n');
fprintf(fileID,'< %i[%i %i 0] ',Latticspec.Hex_Cell_Number, Fuelspec.Lat_Hex_Cords(1),Fuelspec.Lat_Hex_Cords(2));

fprintf(fileID,' < (%i)) T',Boundaryspec.Boundery_Cell_Number);
fprintf(fileID,'\n' );
fprintf(fileID,'SD%i4 1 %ir 1\n',Fuelspec.Fuel.Cell_Number{2},length(Fuelspec.Fuel.Cell_Number)-1);
%E card
fprintf(fileID,'E%i4 ',Fuelspec.Fuel.Cell_Number{2});
for kk=1:length(Tallyspec.F4.Ecard)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,'%.6e ',Tallyspec.F4.Ecard(kk));
ccounter=cc+ccounter;
end
fprintf(fileID,'\n');
fprintf(fileID,'FC%i4 CBC Fuel at  %i  %i \n',Fuelspec.Fuel.Cell_Number{2},Fuelspec.Lat_Hex_Cords(1),Fuelspec.Lat_Hex_Cords(2));
end
end

%%Whole fuel f4
if 1 == Tallyspec.F4.Fuelwhole
for kkk= 1:length(MCNP.FuelCell)
    Fuelspec=MCNP.FuelCell{kkk};

fprintf(fileID,'F%i4:n,p ((',Fuelspec.Fuel.Cell_Number{1});

ccounter=15;
for kk=1:length(Fuelspec.Fuel.Cell_Number)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,[num2str(Fuelspec.Fuel.Cell_Number{kk}),' ']);
ccounter=cc+ccounter;
end
fprintf(fileID,') & \n');
fprintf(fileID,'< %i[%i %i 0] ',Latticspec.Hex_Cell_Number, Fuelspec.Lat_Hex_Cords(1),Fuelspec.Lat_Hex_Cords(2));

fprintf(fileID,' < (%i)) ',Boundaryspec.Boundery_Cell_Number);
fprintf(fileID,'\n' );
fprintf(fileID,'SD%i4 1 \n',Fuelspec.Fuel.Cell_Number{1});
%E card
fprintf(fileID,'E%i4 ',Fuelspec.Fuel.Cell_Number{1});
for kk=1:length(Tallyspec.F4.Ecard)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,'%.6e ',Tallyspec.F4.Ecard(kk));
ccounter=cc+ccounter;
end
fprintf(fileID,'\n');
fprintf(fileID,'FC%i4 Whole Fuel at  %i  %i \n',Fuelspec.Fuel.Cell_Number{1},Fuelspec.Lat_Hex_Cords(1),Fuelspec.Lat_Hex_Cords(2));
end
end

%%Whole Normal Tietube f4
if 1 == Tallyspec.F4.TieTubeNormalwhole

TieTubespec=MCNP.TieTubeCell{1};

fprintf(fileID,'F%i4:n,p ((',TieTubespec.In_Cool.Cell_Number);

Cell_List(1)=TieTubespec.In_Cool.Cell_Number;
Cell_List(2)=TieTubespec.In_Metal.Cell_Number;
Cell_List(3)=TieTubespec.Moderator.Cell_Number;
Cell_List(4)=TieTubespec.Out_Metal.Cell_Number;
Cell_List(5)=TieTubespec.In_Insulator.Cell_Number;
Cell_List(6)=TieTubespec.Out_Insulator.Cell_Number;
Cell_List(7)=TieTubespec.Out_Cool.Cell_Number;

ccounter=15;
for kk=1:length(Cell_List)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,[num2str(Cell_List(kk)),' ']);
ccounter=cc+ccounter;
end
fprintf(fileID,') & \n');
fprintf(fileID,'< %i ',Latticspec.Hex_Cell_Number);

fprintf(fileID,' < (%i)) ',Boundaryspec.Boundery_Cell_Number);
fprintf(fileID,'\n' );
fprintf(fileID,'SD%i4 1\n',TieTubespec.In_Cool.Cell_Number);
%E card
fprintf(fileID,'E%i4 ',TieTubespec.In_Cool.Cell_Number);
for kk=1:length(Tallyspec.F4.Ecard)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,'%.6e ',Tallyspec.F4.Ecard(kk));
ccounter=cc+ccounter;
end
fprintf(fileID,'\n');
fprintf(fileID,'FC%i4 F4 TieTube Normal \n',TieTubespec.In_Cool.Cell_Number);

end

%%Whole Poisoned  Tietube f4
if 1 == Tallyspec.F4.TieTubePoisonedwhole
TieTubespec=MCNP.TieTubeCell{2};

fprintf(fileID,'F%i4:n,p ((',TieTubespec.In_Cool.Cell_Number);

Cell_List(1)=TieTubespec.In_Cool.Cell_Number;
Cell_List(2)=TieTubespec.In_Metal.Cell_Number;
Cell_List(3)=TieTubespec.Moderator.Cell_Number;
Cell_List(4)=TieTubespec.Out_Metal.Cell_Number;
Cell_List(5)=TieTubespec.In_Insulator.Cell_Number;
Cell_List(6)=TieTubespec.Out_Insulator.Cell_Number;
Cell_List(7)=TieTubespec.Out_Cool.Cell_Number;
ccounter=15;
for kk=1:length(Cell_List)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,[num2str(Cell_List(kk)),' ']);
ccounter=cc+ccounter;
end
fprintf(fileID,') & \n');
fprintf(fileID,'< %i ',Latticspec.Hex_Cell_Number);

fprintf(fileID,' < (%i)) ',Boundaryspec.Boundery_Cell_Number);
fprintf(fileID,'\n' );
fprintf(fileID,'SD%i4 1\n',TieTubespec.In_Cool.Cell_Number);
%E card
fprintf(fileID,'E%i4 ',TieTubespec.In_Cool.Cell_Number);
for kk=1:length(Tallyspec.F4.Ecard)
    if ccounter > 50
        fprintf(fileID,' & \n');
        ccounter=15;
    end
cc=fprintf(fileID,'%.6e ',Tallyspec.F4.Ecard(kk));
ccounter=cc+ccounter;
end
fprintf(fileID,'\n');
fprintf(fileID,'FC%i4 F4 TieTube Poisoned \n',TieTubespec.In_Cool.Cell_Number);
end


end

