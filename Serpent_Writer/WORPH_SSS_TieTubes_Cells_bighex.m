function [] = WORPH_MCNP_TieTubes_Cells_bighex(fileID,MCNP,geom);
for kkk = 1:length(MCNP.TieTubeCell)

Tietubespecs=MCNP.TieTubeCell{kkk};




    
 
%make center fuel elm

%I reverse the order of the normal tie tube

%inultor Near the fuel
part1=[num2str(Tietubespecs.Out_Insulator.Cell_Number),' ' num2str(Tietubespecs.Out_Insulator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Insulator.Density) ' '];
part3=[num2str(Tietubespecs.Fuel.Plane_Number) ' ' num2str(-Tietubespecs.Out_Insulator.Plane_Number), ' &\n'];
part4=['imp:n=1 u=2 vol=1 tmp=' num2str(Tietubespecs.Out_Insulator.Temp) '\n'] ;
fprintf(fileID,[part1 part2 part3 part4]);

%insulator towards coolant
part1=[num2str(Tietubespecs.In_Insulator.Cell_Number),' ' num2str(Tietubespecs.In_Insulator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Insulator.Density) ' '];
part3=[num2str(Tietubespecs.Out_Insulator.Plane_Number) ' ' num2str(-Tietubespecs.In_Insulator.Plane_Number), ' &\n'];
part4=['imp:n=1 u=2 vol=1 tmp=' num2str(Tietubespecs.In_Insulator.Temp) '\n'] ;
fprintf(fileID,[part1 part2 part3 part4]);



%metal near fuel towards coolant
part1=[num2str(Tietubespecs.Out_Metal.Cell_Number),' ' num2str(Tietubespecs.Out_Metal.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Metal.Density) ' '];
part3=[num2str(Tietubespecs.In_Insulator.Plane_Number) ' ' num2str(-Tietubespecs.Out_Metal.Plane_Number), ' &\n'];
part4=['imp:n=1 u=2 vol=1 tmp=' num2str(Tietubespecs.Out_Metal.Temp) '\n'] ;
fprintf(fileID,[part1 part2 part3 part4]);


%coolant near fuel
part1=[num2str(Tietubespecs.Out_Cool.Cell_Number),' ' num2str(Tietubespecs.Out_Cool.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Cool.Density) ' '];
part3=[num2str(Tietubespecs.Out_Metal.Plane_Number) ' ' num2str(-Tietubespecs.Out_Cool.Plane_Number), ' &\n'];
part4=['imp:n=1 u=2 vol=1 tmp=' num2str(Tietubespecs.Out_Cool.Temp) '\n'] ;
fprintf(fileID,[part1 part2 part3 part4]);



%Moderator
part1=[num2str(Tietubespecs.Moderator.Cell_Number),' ' num2str(Tietubespecs.Moderator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Moderator.Density) ' '];
part3=[num2str(Tietubespecs.Out_Cool.Plane_Number) ' ' num2str(-Tietubespecs.Moderator.Plane_Number), ' &\n'];
part4=num2str(Tietubespecs.In_Metal.Plane_Number(1) )
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part4=[part4 ' ' num2str(Tietubespecs.In_Metal.Plane_Number(kk)),' &\n']
end
part5 = [' &\n'] ;
part6=['imp:n=1 u=2 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
fprintf(fileID,[part1 part2 part3 part4 part5 part6]);


%Metal away from fuel
part1=[num2str(Tietubespecs.In_Metal.Cell_Number),' ' num2str(Tietubespecs.In_Metal.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Metal.Density)];
part3=[' (' num2str(-Tietubespecs.In_Metal.Plane_Number(1)) ' ' num2str(Tietubespecs.In_Cool.Plane_Number(1))]
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part3=[part3 ':(' num2str(-Tietubespecs.In_Metal.Plane_Number(kk)) ' ' num2str(Tietubespecs.In_Cool.Plane_Number(kk)) ')',' &\n']
end
part4= [') &\n'] ;
part5=['imp:n=1 u=2 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
fprintf(fileID,[part1 part2 part3 part4 part5]);


%cool away from fuel
part1=[num2str(Tietubespecs.In_Cool.Cell_Number),' ' num2str(Tietubespecs.In_Cool.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Cool.Density)];
part3=[' (' num2str(-Tietubespecs.In_Cool.Plane_Number(1))]
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part3=[part3 '):(' num2str(-Tietubespecs.In_Cool.Plane_Number(kk))]
end
part4 = [' )&\n'] ;
part5=['imp:n=1 u=2 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
fprintf(fileID,[part1 part2 part3 part4 part5]);





end
fprintf(fileID,' \n');
end

