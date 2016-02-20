function [MCNPspecs,cellcounter,planecounter] = Tietube_WORPH(MCNP,geom,cellcounter,planecounter)

Mod_Geom=geom.Mod_Geom*100;


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

else
In_Cool_Pos=zeros(1,2);
end


%In cool c/z
MCNPspecs.Tietube.In_Cool.Cell_Number=cellcounter;
cellcounter=cellcounter+1;
MCNPspecs.Tietube.In_Metal.Cell_Number=cellcounter;
cellcounter=cellcounter+1;

for kk=1:length(In_Cool_Pos(:,1))
planecounter=planecounter+1
MCNPspecs.Tietube.In_Cool.Plane_Number(kk)=planecounter;
MCNPspecs.Tietube.In_Cool.Plane(kk,:)=[In_Cool_Pos(kk,:)]


planecounter=planecounter+1
MCNPspecs.Tietube.In_Metal.Plane_Number(kk)=planecounter;
MCNPspecs.Tietube.In_Metal.Plane(kk,:)=[In_Cool_Pos(kk,:)]

end


planecounter=planecounter+1
MCNPspecs.Tietube.Moderator.Plane_Number=planecounter;
MCNPspecs.Tietube.Moderator.Cell_Number=cellcounter;
MCNPspecs.Tietube.Moderator.Plane=Mod_Geom(3);
cellcounter=cellcounter+1;


planecounter=planecounter+1
MCNPspecs.Tietube.Out_Cool.Plane_Number=planecounter;
MCNPspecs.Tietube.Out_Cool.Cell_Number=cellcounter;
MCNPspecs.Tietube.Out_Cool.Plane=Mod_Geom(4);
cellcounter=cellcounter+1;

planecounter=planecounter+1
MCNPspecs.Tietube.Out_Metal.Plane_Number=planecounter;
MCNPspecs.Tietube.Out_Metal.Cell_Number=cellcounter;
MCNPspecs.Tietube.Out_Metal.Plane=Mod_Geom(5);
cellcounter=cellcounter+1;

planecounter=planecounter+1
MCNPspecs.Tietube.In_Insulator.Plane_Number=planecounter;
MCNPspecs.Tietube.In_Insulator.Cell_Number=cellcounter;
MCNPspecs.Tietube.In_Insulator.Plane=Mod_Geom(6);
cellcounter=cellcounter+1;

planecounter=planecounter+1
MCNPspecs.Tietube.Out_Insulator.Plane_Number=planecounter;
MCNPspecs.Tietube.Out_Insulator.Cell_Number=cellcounter;
MCNPspecs.Tietube.Out_Insulator.Plane=Mod_Geom(6)*10;
cellcounter=cellcounter+1;


MCNPspecs.Tietube.Graveyard.Cell_Number=cellcounter;
cellcounter=cellcounter+1;

%Differnt mod geom conventions

if 1==strcmp( MCNP.Fuel2Mod,'bighex_counter')
    
    
MCNPspecs.Tietube.In_Cool.Plane=[MCNPspecs.Tietube.In_Cool.Plane,Mod_Geom(6)*ones(6,1)];
MCNPspecs.Tietube.In_Metal.Plane=[MCNPspecs.Tietube.In_Metal.Plane,Mod_Geom(5)*ones(6,1)];
MCNPspecs.Tietube.Moderator.Plane=bftf*10;
MCNPspecs.Tietube.Out_Cool.Plane=Mod_Geom(4);
MCNPspecs.Tietube.Out_Metal.Plane=Mod_Geom(3);
MCNPspecs.Tietube.In_Insulator.Plane=Mod_Geom(2);
MCNPspecs.Tietube.Out_Insulator.Plane=Mod_Geom(1)
    

elseif 1== strcmp( MCNP.Fuel2Mod,'bighex_align')

MCNPspecs.Tietube.In_Cool.Plane=[MCNPspecs.Tietube.In_Cool.Plane,Mod_Geom(6)*ones(6,1)];
MCNPspecs.Tietube.In_Metal.Plane=[MCNPspecs.Tietube.In_Metal.Plane,Mod_Geom(5)*ones(6,1)];
MCNPspecs.Tietube.Moderator.Plane=bftf*10;
MCNPspecs.Tietube.Out_Cool.Plane=Mod_Geom(4);
MCNPspecs.Tietube.Out_Metal.Plane=Mod_Geom(3);
MCNPspecs.Tietube.In_Insulator.Plane=Mod_Geom(2);
MCNPspecs.Tietube.Out_Insulator.Plane=Mod_Geom(1)
    
    

else
    
MCNPspecs.Tietube.In_Cool.Plane=[MCNPspecs.Tietube.In_Cool.Plane,Mod_Geom(1)];
MCNPspecs.Tietube.In_Metal.Plane=[MCNPspecs.Tietube.In_Metal.Plane,Mod_Geom(2)];
MCNPspecs.Tietube.Moderator.Plane=Mod_Geom(3);
MCNPspecs.Tietube.Out_Cool.Plane=Mod_Geom(4);
MCNPspecs.Tietube.Out_Metal.Plane=Mod_Geom(5);
MCNPspecs.Tietube.In_Insulator.Plane=Mod_Geom(6);
MCNPspecs.Tietube.Out_Insulator.Plane=Mod_Geom(6)*10;
end


end

