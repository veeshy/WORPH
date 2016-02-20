function [Cool_Chan_Pos] = Create_Cool_Chans_WORPH(geom)
%Logic provided by Pete Husemeyer
%not dependant on ftf and will make channels outside of the fuel elm if
%ftf2 is to big 
ftf2 = geom.ftf2;
Hex_Size = geom.Hex_Size;



Chan_Total= (1/2)*(Hex_Size)*(Hex_Size-1);

Hex_Points  = ones(Chan_Total-1,2)*0;


Hex_Points(1:1:(Hex_Size-1))  = 1:Hex_Size-1;

%makes first 1/6 of hexagon

[Hex_Points] = Hexant( Hex_Points,Hex_Size)

%transforms it
[Hex_Points,Transform] = Hexanttrans( Hex_Points,Hex_Size);
Cool_Chan_Pos = (ftf2*[cosd(30),-sind(30);sind(30),cosd(30)]*Transform*Hex_Points')';



