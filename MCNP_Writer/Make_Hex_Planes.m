function [Hex_Planes,Cell_Specs] = Make_Hex_Planes(Chan_pos,ftf2)
%makes 6 planes for a hex and tells you the directions of the plans to make
%a cell
%http://mathworld.wolfram.com/Plane.html
nx=cos(30/180*pi); %normal x vec
ny=sin(30/180*pi); %normal x vec

Hex_Planes=[0 1 0 (ftf2/2+Chan_pos(2)); ...
 0 1 0 (-ftf2/2+Chan_pos(2));
 -nx,-ny,0,(nx*ftf2/2+Chan_pos(1))*-nx+(ny*ftf2/2+Chan_pos(2))*-ny; ...
 -nx,-ny,0,(-nx*ftf2/2+Chan_pos(1))*-nx+(-ny*ftf2/2+Chan_pos(2))*-ny; ...
 -nx,ny,0,(nx*ftf2/2+Chan_pos(1))*-nx+(-ny*ftf2/2+Chan_pos(2))*ny;  ...
 -nx,ny,0,(-nx*ftf2/2+Chan_pos(1))*-nx+(ny*ftf2/2+Chan_pos(2))*ny ];
 
Cell_Specs=[-1,1,1,-1,1,-1]

end

