function [MCNPspecs,cellcounter,planecounter] = WORPH_Boundary(MCNP,geom,cellcounter,planecounter) 





%
% 1to1
%
if strcmp( MCNP.Fuel2Mod,'1to1')
        [MCNPspecs,cellcounter,planecounter]=Bound1to1(MCNP,geom,cellcounter,planecounter)
elseif strcmp( MCNP.Fuel2Mod,'1to1x2by1')
        [MCNPspecs,cellcounter,planecounter]=Bound1to11to1x2by1(MCNP,geom,cellcounter,planecounter)
elseif strcmp( MCNP.Fuel2Mod,'1to1x2by2')
        [MCNPspecs,cellcounter,planecounter]=Bound1to1x2by2(MCNP,geom,cellcounter,planecounter)
    elseif strcmp( MCNP.Fuel2Mod,'1to2')
        planecounter=planecounter+1;
        MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
       ' imp:n=1 fill=1\n']
    cellcounter=cellcounter+1;
    MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
       ' imp:n=0\n']
    cellcounter=cellcounter+1;
    ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
    edgelength=ftf/(3^0.5);

    MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' hex ',...
    '0 0 -10 0 0 20 0 '...
    num2str(-(ctc/2+edgelength/2+.00001),'%.6f'),' 0'];

elseif strcmp( MCNP.Fuel2Mod,'1to0')
    planecounter=planecounter+1;
    MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
   ' imp:n=1 fill=1\n']
cellcounter=cellcounter+1;
MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
   ' imp:n=0\n']
cellcounter=cellcounter+1;
ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
edgelength=ftf/(3^0.5);

MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' hex ',...
'0 0 -10 0 0 20 '...
num2str(ftf/2+.000001,'%.6f'), ' 0 0'];

elseif strcmp( MCNP.Fuel2Mod,'1to3') 
    
planecounter=planecounter+1;
MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
   ' imp:n=1 fill=1\n']
cellcounter=cellcounter+1;
MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
   ' imp:n=0\n']
cellcounter=cellcounter+1;
ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
edgelength=ftf/(3^0.5);

MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' RPP ',...
num2str(-ftf-.000001,'%.6f'),' ',num2str(ftf+.000001,'%.6f'),' ',...
num2str(-(ctc/2+edgelength/2+.000001),'%.6f'),' ',num2str((ctc/2+edgelength/2+.000001),'%.6f'),...
' -10 10 ']


elseif strcmp( MCNP.Fuel2Mod,'1to0')
    planecounter=planecounter+1;
    MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
   ' imp:n=1 fill=1\n']
cellcounter=cellcounter+1;
MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
   ' imp:n=0\n']
cellcounter=cellcounter+1;
ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
edgelength=ftf/(3^0.5);

MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' hex ',...
'0 0 -10 0 0 20 '...
num2str(ftf/2+.000001,'%.6f'), ' 0 0'];

%2to1
elseif strcmp(MCNP.Fuel2Mod,'2to1')
    


% [Tri_Planes,Cell_Specs] = Make_2to1_Planes(ftf+.00001)
% 
%  planecounter=planecounter+1;
%  MCNPspecs.Boundary.Plane_String{1}= [num2str(planecounter) ' p '...
%     num2str(Tri_Planes(1,1),'%.6f') ' '...
%     num2str(Tri_Planes(1,2),'%.6f') ' '...
%     num2str(Tri_Planes(1,3),'%.6f') ' '...
%     num2str(Tri_Planes(1,4),'%.6f')]
%  planecounter=planecounter+1;
%  MCNPspecs.Boundary.Plane_String{2}= [num2str(planecounter) ' p '...
%     num2str(Tri_Planes(2,1),'%.6f') ' '...
%     num2str(Tri_Planes(2,2),'%.6f') ' '...
%     num2str(Tri_Planes(2,3),'%.6f') ' '...
%     num2str(Tri_Planes(2,4),'%.6f')]
%  planecounter=planecounter+1;
%  MCNPspecs.Boundary.Plane_String{3}= [num2str(planecounter) ' p '...
%     num2str(Tri_Planes(3,1),'%.6f') ' '...
%     num2str(Tri_Planes(3,2),'%.6f') ' ' ...
%     num2str(Tri_Planes(3,3),'%.6f') ' '...
%     num2str(Tri_Planes(3,4),'%.6f')]
%      
% 
%  
%  MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 '...
%      num2str((planecounter-2)*Cell_Specs(1),6),' '...
%      num2str((planecounter-1)*Cell_Specs(2),6),' '...
%      num2str((planecounter)*Cell_Specs(3),6),' '...
%    ' imp:n=1 fill=1\n']
% cellcounter=cellcounter+1;
% MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',...
%      num2str((planecounter-2)*-Cell_Specs(1),6),' '...
%      num2str((planecounter-1)*-Cell_Specs(2),6),' '...
%      num2str((planecounter)*-Cell_Specs(3),6),' '...
%    ' imp:n=0\n']
% cellcounter=cellcounter+1;

 planecounter=planecounter+1;
    MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
   ' imp:n=1 fill=1\n']
cellcounter=cellcounter+1;
MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
   ' imp:n=0\n']
cellcounter=cellcounter+1;
 
ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
edgelength=ftf/(3^0.5);

c_left_v=[-ftf,0.000001];%center left
u_right_v=[ftf/2-0.0001,(ctc/2+edgelength/2)-0.01]; %uper right
l_right_v=[ftf/2,-(ctc/2+edgelength/2)]; %lower right



MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' ARB ',...
num2str(c_left_v(1),'%.6f'),' ',num2str(c_left_v(2),'%.6f'), ' -10 &\n',...
num2str(u_right_v(1),'%.6f'),' ',num2str(u_right_v(2),'%.6f'), ' -10 &\n',...
num2str(l_right_v(1),'%.6f'),' ',num2str(l_right_v(2),'%.6f'), ' -10 &\n',...
num2str(c_left_v(1),'%.6f'),' ',num2str(c_left_v(2),'%.6f'), ' 10 &\n',...
num2str(u_right_v(1),'%.6f'),' ',num2str(u_right_v(2),'%.6f'), ' 10 &\n',...
num2str(l_right_v(1),'%.6f'),' ',num2str(l_right_v(2),'%.6f'), ' 10 &\n',...
'0 0 0 ',...
'0 0 0 &\n',...
'1230 ',...
'4560 ',...
'1425 ',...
'1436 ',...
'2356 ',...
'0'];

%2to1
elseif strcmp(MCNP.Fuel2Mod,'3to1')
    


% [Tri_Planes,Cell_Specs] = Make_2to1_Planes(ftf+.00001)
% 
%  planecounter=planecounter+1;
%  MCNPspecs.Boundary.Plane_String{1}= [num2str(planecounter) ' p '...
%     num2str(Tri_Planes(1,1),'%.6f') ' '...
%     num2str(Tri_Planes(1,2),'%.6f') ' '...
%     num2str(Tri_Planes(1,3),'%.6f') ' '...
%     num2str(Tri_Planes(1,4),'%.6f')]
%  planecounter=planecounter+1;
%  MCNPspecs.Boundary.Plane_String{2}= [num2str(planecounter) ' p '...
%     num2str(Tri_Planes(2,1),'%.6f') ' '...
%     num2str(Tri_Planes(2,2),'%.6f') ' '...
%     num2str(Tri_Planes(2,3),'%.6f') ' '...
%     num2str(Tri_Planes(2,4),'%.6f')]
%  planecounter=planecounter+1;
%  MCNPspecs.Boundary.Plane_String{3}= [num2str(planecounter) ' p '...
%     num2str(Tri_Planes(3,1),'%.6f') ' '...
%     num2str(Tri_Planes(3,2),'%.6f') ' ' ...
%     num2str(Tri_Planes(3,3),'%.6f') ' '...
%     num2str(Tri_Planes(3,4),'%.6f')]
%      
% 
%  
%  MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 '...
%      num2str((planecounter-2)*Cell_Specs(1),6),' '...
%      num2str((planecounter-1)*Cell_Specs(2),6),' '...
%      num2str((planecounter)*Cell_Specs(3),6),' '...
%    ' imp:n=1 fill=1\n']
% cellcounter=cellcounter+1;
% MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',...
%      num2str((planecounter-2)*-Cell_Specs(1),6),' '...
%      num2str((planecounter-1)*-Cell_Specs(2),6),' '...
%      num2str((planecounter)*-Cell_Specs(3),6),' '...
%    ' imp:n=0\n']
% cellcounter=cellcounter+1;

 planecounter=planecounter+1;
    MCNPspecs.Boundary.Cell_String{7}=[num2str(cellcounter), ' 0 ' num2str(-planecounter) ' '  num2str(-(planecounter+1)) ,'',...
   ' imp:n=1 fill=1\n']
cellcounter=cellcounter+1;
MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0  (',num2str(planecounter) ':'  num2str((planecounter+1)) ')' ,...
   ' imp:n=0\n']
cellcounter=cellcounter+1;
 
ctc=2/sqrt(3)*ftf; %corner to corner of the small hexes
edgelength=ftf/(3^0.5);

c_left_v=[-ftf,0.0];%center left
u_right_v=[ftf*1.5,edgelength/2+ctc+.00001]; %uper right
l_right_v=[ftf*1.5,-edgelength/2-ctc-.00001]; %lower right


MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' ARB ',...
num2str(c_left_v(1),'%.6f'),' ',num2str(c_left_v(2),'%.6f'), ' -10 &\n',...
num2str(u_right_v(1),'%.6f'),' ',num2str(u_right_v(2),'%.6f'), ' -10 &\n',...
num2str(l_right_v(1),'%.6f'),' ',num2str(l_right_v(2),'%.6f'), ' -10 &\n',...
num2str(c_left_v(1),'%.6f'),' ',num2str(c_left_v(2),'%.6f'), ' 10 &\n',...
num2str(u_right_v(1),'%.6f'),' ',num2str(u_right_v(2),'%.6f'), ' 10 &\n',...
num2str(l_right_v(1),'%.6f'),' ',num2str(l_right_v(2),'%.6f'), ' 10 &\n',...
'0 0 0 ',...
'0 0 0 &\n',...
'1230 ',...
'4560 ',...
'1425 ',...
'1436 ',...
'2356 ',...
'0'];

 planecounter=planecounter+1;

c_left_v=[ftf,0];%center left
u_right_v=[-ftf*1.5,edgelength/2+ctc+.00001]; %uper right
l_right_v=[-ftf*1.5,-edgelength/2-ctc-.00001]; %lower right


MCNPspecs.Boundary.Plane_String{2}=['*',num2str(planecounter) ' ARB ',...
num2str(c_left_v(1),'%.6f'),' ',num2str(c_left_v(2),'%.6f'), ' -10 &\n',...
num2str(u_right_v(1),'%.6f'),' ',num2str(u_right_v(2),'%.6f'), ' -10 &\n',...
num2str(l_right_v(1),'%.6f'),' ',num2str(l_right_v(2),'%.6f'), ' -10 &\n',...
num2str(c_left_v(1),'%.6f'),' ',num2str(c_left_v(2),'%.6f'), ' 10 &\n',...
num2str(u_right_v(1),'%.6f'),' ',num2str(u_right_v(2),'%.6f'), ' 10 &\n',...
num2str(l_right_v(1),'%.6f'),' ',num2str(l_right_v(2),'%.6f'), ' 10 &\n',...
'0 0 0 ',...
'0 0 0 &\n',...
'1230 ',...
'4560 ',...
'1425 ',...
'1436 ',...
'2356 ',...
'0'];






elseif strcmp( MCNP.Fuel2Mod,'bighex_counter')

    bftf= geom.Bighex.ftf*100;
Tietubespecs=MCNP.Tietube;
    
 
%make center fuel elm
part1=[num2str(Lattice_Hexspecs.Cell_Number), ' 0 '];
part2=[num2str(-Lattice_Hexspecs.Plane_Number), ' &\n'];
part3='imp:n=1  u=1 fill=2 \n';
MCNPspecs.Boundary.Cell_String{1}=[part1 part2 part3];

%I reverse the order of the normal tie tube

%inultor Near the fuel
part1=[num2str(Tietubespecs.Out_Insulator.Cell_Number),' ' num2str(Tietubespecs.Out_Insulator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Insulator.Density) ' '];
part3=[num2str(Lattice_Hexspecs.Plane_Number) ' ' num2str(-Tietubespecs.Out_Insulator.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Out_Insulator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{2}=[part1 part2 part3 part4];

%insulator towards coolant
part1=[num2str(Tietubespecs.In_Insulator.Cell_Number),' ' num2str(Tietubespecs.In_Insulator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Insulator.Density) ' '];
part3=[num2str(Tietubespecs.Out_Insulator.Plane_Number) ' ' num2str(-Tietubespecs.In_Insulator.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.In_Insulator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{3}=[part1 part2 part3 part4];


%metal near fuel towards coolant
part1=[num2str(Tietubespecs.Out_Metal.Cell_Number),' ' num2str(Tietubespecs.Out_Metal.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Metal.Density) ' '];
part3=[num2str(Tietubespecs.In_Insulator.Plane_Number) ' ' num2str(-Tietubespecs.Out_Metal.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Out_Metal.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{4}=[part1 part2 part3 part4];

%coolant near fuel
part1=[num2str(Tietubespecs.Out_Cool.Cell_Number),' ' num2str(Tietubespecs.Out_Cool.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Cool.Density) ' '];
part3=[num2str(Tietubespecs.Out_Metal.Plane_Number) ' ' num2str(-Tietubespecs.Out_Cool.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Out_Cool.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{5}=[part1 part2 part3 part4];


%Moderator
part1=[num2str(Tietubespecs.Moderator.Cell_Number),' ' num2str(Tietubespecs.Moderator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Moderator.Density) ' '];
part3=[num2str(Tietubespecs.Out_Cool.Plane_Number) ' ' num2str(-Tietubespecs.Moderator.Plane_Number), ' &\n'];
part4=num2str(Tietubespecs.In_Metal.Plane_Number(1) )
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part4=[part4 ' ' num2str(Tietubespecs.In_Metal.Plane_Number(kk)),' &\n']
end
part5 = [' &\n'] ;
part6=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{6}=[part1 part2 part3 part4 part5 part6];


%Metal away from fuel
part1=[num2str(Tietubespecs.In_Metal.Cell_Number),' ' num2str(Tietubespecs.In_Metal.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Metal.Density)];
part3=[' (' num2str(-Tietubespecs.In_Metal.Plane_Number(1)) ' ' num2str(Tietubespecs.In_Cool.Plane_Number(1))]
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part3=[part3 ':(' num2str(-Tietubespecs.In_Metal.Plane_Number(kk)) ' ' num2str(Tietubespecs.In_Cool.Plane_Number(kk)) ')',' &\n']
end
part4= [') &\n'] ;
part5=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{7}=[part1 part2 part3 part4 part5 ];

%cool away from fuel
part1=[num2str(Tietubespecs.In_Cool.Cell_Number),' ' num2str(Tietubespecs.In_Cool.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Cool.Density)];
part3=[' (' num2str(-Tietubespecs.In_Cool.Plane_Number(1))]
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part3=[part3 '):(' num2str(-Tietubespecs.In_Cool.Plane_Number(kk))]
end
part4 = [' )&\n'] ;
part5=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{8}=[part1 part2 part3 part4 part5]

% the plan to make the relfecting hex

planecounter=planecounter+1;
MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' hex ',...
'0 0 -10 0 0 20 0 '...
num2str(-(bftf/2),'%.6f'),' 0'];


MCNPspecs.Boundary.Cell_String{9}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
   ' imp:n=1 fill=1\n']
cellcounter=cellcounter+1;
MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
   ' imp:n=0\n']
cellcounter=cellcounter+1;


elseif strcmp( MCNP.Fuel2Mod,'bighex_align')
bftf= geom.Bighex.ftf*100;
Tietubespecs=MCNP.Tietube;
    
 
%make center fuel elm
part1=[num2str(Lattice_Hexspecs.Cell_Number), ' 0 '];
part2=[num2str(-Lattice_Hexspecs.Plane_Number), ' &\n'];
part3='imp:n=1  u=1 fill=2 \n';
MCNPspecs.Boundary.Cell_String{1}=[part1 part2 part3];

%I reverse the order of the normal tie tube

%inultor Near the fuel
part1=[num2str(Tietubespecs.Out_Insulator.Cell_Number),' ' num2str(Tietubespecs.Out_Insulator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Insulator.Density) ' '];
part3=[num2str(Lattice_Hexspecs.Plane_Number) ' ' num2str(-Tietubespecs.Out_Insulator.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Out_Insulator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{2}=[part1 part2 part3 part4];

%insulator towards coolant
part1=[num2str(Tietubespecs.In_Insulator.Cell_Number),' ' num2str(Tietubespecs.In_Insulator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Insulator.Density) ' '];
part3=[num2str(Tietubespecs.Out_Insulator.Plane_Number) ' ' num2str(-Tietubespecs.In_Insulator.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.In_Insulator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{3}=[part1 part2 part3 part4];


%metal near fuel towards coolant
part1=[num2str(Tietubespecs.Out_Metal.Cell_Number),' ' num2str(Tietubespecs.Out_Metal.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Metal.Density) ' '];
part3=[num2str(Tietubespecs.In_Insulator.Plane_Number) ' ' num2str(-Tietubespecs.Out_Metal.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Out_Metal.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{4}=[part1 part2 part3 part4];

%coolant near fuel
part1=[num2str(Tietubespecs.Out_Cool.Cell_Number),' ' num2str(Tietubespecs.Out_Cool.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Out_Cool.Density) ' '];
part3=[num2str(Tietubespecs.Out_Metal.Plane_Number) ' ' num2str(-Tietubespecs.Out_Cool.Plane_Number), ' &\n'];
part4=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Out_Cool.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{5}=[part1 part2 part3 part4];


%Moderator
part1=[num2str(Tietubespecs.Moderator.Cell_Number),' ' num2str(Tietubespecs.Moderator.Cell_Number)];
part2=[' ' num2str(Tietubespecs.Moderator.Density) ' '];
part3=[num2str(Tietubespecs.Out_Cool.Plane_Number) ' ' num2str(-Tietubespecs.Moderator.Plane_Number), ' &\n'];
part4=num2str(Tietubespecs.In_Metal.Plane_Number(1) )
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part4=[part4 ' ' num2str(Tietubespecs.In_Metal.Plane_Number(kk)),' &\n']
end
part5 = [' &\n'] ;
part6=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{6}=[part1 part2 part3 part4 part5 part6];


%Metal away from fuel
part1=[num2str(Tietubespecs.In_Metal.Cell_Number),' ' num2str(Tietubespecs.In_Metal.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Metal.Density)];
part3=[' (' num2str(-Tietubespecs.In_Metal.Plane_Number(1)) ' ' num2str(Tietubespecs.In_Cool.Plane_Number(1))]
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part3=[part3 ':(' num2str(-Tietubespecs.In_Metal.Plane_Number(kk)) ' ' num2str(Tietubespecs.In_Cool.Plane_Number(kk)) ')',' &\n']
end
part4= [') &\n'] ;
part5=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{7}=[part1 part2 part3 part4 part5 ]

%cool away from fuel
part1=[num2str(Tietubespecs.In_Cool.Cell_Number),' ' num2str(Tietubespecs.In_Cool.Cell_Number)];
part2=[' ' num2str(Tietubespecs.In_Cool.Density)];
part3=[' (' num2str(-Tietubespecs.In_Cool.Plane_Number(1))]
for kk = 2:length(Tietubespecs.In_Metal.Plane_Number)
part3=[part3 '):(' num2str(-Tietubespecs.In_Cool.Plane_Number(kk))]
end
part4 = [' )&\n'] ;
part5=['imp:n=1 u=1 vol=1 tmp=' num2str(Tietubespecs.Moderator.Temp) '\n'] ;
MCNPspecs.Boundary.Cell_String{8}=[part1 part2 part3 part4 part5]

% the plan to make the relfecting hex

planecounter=planecounter+1;
MCNPspecs.Boundary.Plane_String{1}=['*',num2str(planecounter) ' hex ',...
'0 0 -10 0 0 20 '...
num2str(-(bftf/2),'%.6f'),'0 0'];


MCNPspecs.Boundary.Cell_String{9}=[num2str(cellcounter), ' 0 -',num2str(planecounter),...
   ' imp:n=1 fill=1\n']
cellcounter=cellcounter+1;
MCNPspecs.Boundary.Graveyard_Cell_String{1}=[num2str(cellcounter), ' 0 ',num2str(planecounter),...
   ' imp:n=0\n']
cellcounter=cellcounter+1;


else
    
    error('fuel to moderator ratio not supported')
end


end

