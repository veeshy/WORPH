function [MCNPspecs,cellcounter,planecounter] = TieTube_WORPH(MCNP,geom,cellcounter,planecounter)

Mod_Geom=geom.Mod_Geom*100;
ftf=geom.ftf*100;

%find the location of the inner coolant channels

if 1==strcmp( MCNP.Fuel2Mod,'bighex_counter')
bftf=geom.Bighex.ftf*100;
ctc=2/sqrt(3)*bftf; %corner to corner 
edgelength=bftf/(3^0.5);

In_Cool_Pos(1,:)=[-edgelength/2,bftf/2];
In_Cool_Pos(2,:)=[-ctc/2,0];
In_Cool_Pos(3,:)=[-edgelength/2,-bftf/2];
In_Cool_Pos(4,:)=[edgelength/2,-bftf/2];
In_Cool_Pos(5,:)=[ctc/2,0];
In_Cool_Pos(6,:)=[edgelength/2,bftf/2];


MCNPspecs.TieTube.In_Metal.Mat_Areas=(Mod_Geom(5)^2-Mod_Geom(6)^2)*pi*2;
MCNPspecs.TieTube.Moderator.Mat_Areas=bftf^2*3^.5/2-Mod_Geom(4)^2*pi-Mod_Geom(5)^2*pi*2;
MCNPspecs.TieTube.Out_Metal.Mat_Areas=(Mod_Geom(3)^2-Mod_Geom(2)^2)*pi;
MCNPspecs.TieTube.In_Insulator.Mat_Areas=(Mod_Geom(2)^2-Mod_Geom(1)^2)*pi;
MCNPspecs.TieTube.Out_Insulator.Mat_Areas=(Mod_Geom(1)^2)*pi-ftf^2*3^0.5/2;

elseif 1== strcmp( MCNP.Fuel2Mod,'bighex_align')
bftf=geom.Bighex.ftf*100;
ctc=2/sqrt(3)*bftf; %corner to corner
edgelength=bftf/(3^0.5);
    
In_Cool_Pos(1,:)=[0,ctc/2];
In_Cool_Pos(2,:)=[-bftf/2,edgelength/2];
In_Cool_Pos(3,:)=[-bftf/2,-edgelength/2];
In_Cool_Pos(4,:)=[0,-ctc/2];
In_Cool_Pos(5,:)=[bftf/2,-edgelength/2];
In_Cool_Pos(6,:)=[bftf/2,edgelength/2];

MCNPspecs.TieTube.In_Metal.Mat_Areas=(Mod_Geom(5)^2-Mod_Geom(6)^2)*pi*2;
MCNPspecs.TieTube.Moderator.Mat_Areas=bftf^2*3^.5/2-Mod_Geom(4)^2*pi-Mod_Geom(5)^2*pi*2;
MCNPspecs.TieTube.Out_Metal.Mat_Areas=(Mod_Geom(3)^2-Mod_Geom(2)^2)*pi;
MCNPspecs.TieTube.In_Insulator.Mat_Areas=(Mod_Geom(2)^2-Mod_Geom(1)^2)*pi;
MCNPspecs.TieTube.Out_Insulator.Mat_Areas=(Mod_Geom(1)^2)*pi-ftf^2*3^0.5/2;

else
In_Cool_Pos=zeros(1,2);
MCNPspecs.TieTube.In_Metal.Mat_Areas=(Mod_Geom(2)^2-Mod_Geom(1)^2)*pi;
MCNPspecs.TieTube.Moderator.Mat_Areas=(Mod_Geom(3)^2-Mod_Geom(2)^2)*pi;
MCNPspecs.TieTube.Out_Metal.Mat_Areas=(Mod_Geom(5)^2-Mod_Geom(4)^2)*pi;
MCNPspecs.TieTube.In_Insulator.Mat_Areas=(Mod_Geom(6)^2-Mod_Geom(5)^2)*pi;
MCNPspecs.TieTube.Out_Insulator.Mat_Areas=ftf^2*3^0.5/2-(Mod_Geom(6)^2)*pi;

end


%In cool c/z
MCNPspecs.TieTube.In_Cool.Cell_Number=cellcounter;
cellcounter=cellcounter+1;
MCNPspecs.TieTube.In_Metal.Cell_Number=cellcounter;
cellcounter=cellcounter+1;

for kk=1:length(In_Cool_Pos(:,1))
planecounter=planecounter+1;
MCNPspecs.TieTube.In_Cool.Plane_Number(kk)=planecounter;
MCNPspecs.TieTube.In_Cool.Plane(kk,:)=[In_Cool_Pos(kk,:)];


planecounter=planecounter+1;
MCNPspecs.TieTube.In_Metal.Plane_Number(kk)=planecounter;
MCNPspecs.TieTube.In_Metal.Plane(kk,:)=[In_Cool_Pos(kk,:)];

end


planecounter=planecounter+1;
MCNPspecs.TieTube.Moderator.Plane_Number=planecounter;
MCNPspecs.TieTube.Moderator.Cell_Number=cellcounter;
MCNPspecs.TieTube.Moderator.Plane=Mod_Geom(3);
cellcounter=cellcounter+1;


planecounter=planecounter+1;
MCNPspecs.TieTube.Out_Cool.Plane_Number=planecounter;
MCNPspecs.TieTube.Out_Cool.Cell_Number=cellcounter;
MCNPspecs.TieTube.Out_Cool.Plane=Mod_Geom(4);
cellcounter=cellcounter+1;

planecounter=planecounter+1;
MCNPspecs.TieTube.Out_Metal.Plane_Number=planecounter;
MCNPspecs.TieTube.Out_Metal.Cell_Number=cellcounter;
MCNPspecs.TieTube.Out_Metal.Plane=Mod_Geom(5);
cellcounter=cellcounter+1;

planecounter=planecounter+1;
MCNPspecs.TieTube.In_Insulator.Plane_Number=planecounter;
MCNPspecs.TieTube.In_Insulator.Cell_Number=cellcounter;
MCNPspecs.TieTube.In_Insulator.Plane=Mod_Geom(6);
cellcounter=cellcounter+1;

planecounter=planecounter+1;
MCNPspecs.TieTube.Out_Insulator.Plane_Number=planecounter;
MCNPspecs.TieTube.Out_Insulator.Cell_Number=cellcounter;
MCNPspecs.TieTube.Out_Insulator.Plane=Mod_Geom(6)*10;
cellcounter=cellcounter+1;


MCNPspecs.TieTube.Graveyard.Cell_Number=cellcounter;
cellcounter=cellcounter+1;

%Differnt mod geom conventions

if 1==strcmp( MCNP.Fuel2Mod,'bighex_counter')
    
    
MCNPspecs.TieTube.In_Cool.Plane=[MCNPspecs.TieTube.In_Cool.Plane,Mod_Geom(6)*ones(6,1)];
MCNPspecs.TieTube.In_Metal.Plane=[MCNPspecs.TieTube.In_Metal.Plane,Mod_Geom(5)*ones(6,1)];
MCNPspecs.TieTube.Moderator.Plane=bftf*10;
MCNPspecs.TieTube.Out_Cool.Plane=Mod_Geom(4);
MCNPspecs.TieTube.Out_Metal.Plane=Mod_Geom(3);
MCNPspecs.TieTube.In_Insulator.Plane=Mod_Geom(2);
MCNPspecs.TieTube.Out_Insulator.Plane=Mod_Geom(1);
planecounter=planecounter+1;
MCNPspecs.TieTube.Fuel.Plane_Number=planecounter;
MCNPspecs.TieTube.Fuel.Plane=[0 0 -11 0 0 22 ftf/2 0 0]; % the outside of the fuel in bighex    

elseif 1== strcmp( MCNP.Fuel2Mod,'bighex_align')

MCNPspecs.TieTube.In_Cool.Plane=[MCNPspecs.TieTube.In_Cool.Plane,Mod_Geom(6)*ones(6,1)];
MCNPspecs.TieTube.In_Metal.Plane=[MCNPspecs.TieTube.In_Metal.Plane,Mod_Geom(5)*ones(6,1)];
MCNPspecs.TieTube.Moderator.Plane=bftf*10;
MCNPspecs.TieTube.Out_Cool.Plane=Mod_Geom(4);
MCNPspecs.TieTube.Out_Metal.Plane=Mod_Geom(3);
MCNPspecs.TieTube.In_Insulator.Plane=Mod_Geom(2);
MCNPspecs.TieTube.Out_Insulator.Plane=Mod_Geom(1);
planecounter=planecounter+1;
MCNPspecs.TieTube.Fuel.Plane_Number=planecounter;
MCNPspecs.TieTube.Fuel.Plane=[0 0 -11 0 0 22  ftf/2 0 0]; % the outside of the fuel in bighex
    
    

else
    
MCNPspecs.TieTube.In_Cool.Plane=[MCNPspecs.TieTube.In_Cool.Plane,Mod_Geom(1)];
MCNPspecs.TieTube.In_Metal.Plane=[MCNPspecs.TieTube.In_Metal.Plane,Mod_Geom(2)];
MCNPspecs.TieTube.Moderator.Plane=Mod_Geom(3);
MCNPspecs.TieTube.Out_Cool.Plane=Mod_Geom(4);
MCNPspecs.TieTube.Out_Metal.Plane=Mod_Geom(5);
MCNPspecs.TieTube.In_Insulator.Plane=Mod_Geom(6);
MCNPspecs.TieTube.Out_Insulator.Plane=Mod_Geom(6)*10;

end


end

