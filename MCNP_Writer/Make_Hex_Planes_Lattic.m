function [Hex_Planes,Cell_Specs] = Make_Tri_Planes(ftf)
%makes 6 planes for a hex and tells you the directions of the plans to make
%a cell
%http://mathworld.wolfram.com/Plane.html
nx=cos(60/180*pi); %normal x vec
ny=sin(60/180*pi); %normal x vec
Chan_pos=[0,0]


Hex_Planes=[1 0 0 (ftf/2); ...
 1 0 0 (-ftf/2);
 -nx,-ny,0,(nx*ftf/2+Chan_pos(1))*-nx+(ny*ftf/2+Chan_pos(2))*-ny; ...
 -nx,-ny,0,(-nx*ftf/2+Chan_pos(1))*-nx+(-ny*ftf/2+Chan_pos(2))*-ny; ...
 -nx,ny,0,(nx*ftf/2+Chan_pos(1))*-nx+(-ny*ftf/2+Chan_pos(2))*ny;  ...
 -nx,ny,0,(-nx*ftf/2+Chan_pos(1))*-nx+(ny*ftf/2+Chan_pos(2))*ny ];
 
Cell_Specs=[-1,1,1,-1,1,-1]

end

