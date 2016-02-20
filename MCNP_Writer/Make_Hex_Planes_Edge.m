function [Hex_Planes,Cell_Specs] = Make_Hex_Planes_Edge(Chan_pos,ftf2)
%makes 6 planes for a hex and tells you the directions of the plans to make
%a cell
%http://mathworld.wolfram.com/Plane.html
%http://mathworld.wolfram.com/Point-PlaneDistance.html
%give the 4 planes that are closest to the center
[Hex_Planes_all,Cell_Specs_all]=Make_Hex_Planes(Chan_pos,ftf2)
Hex_Planes_all=Hex_Planes_all

Dis_From_Center=-1*Hex_Planes_all(:,4).*Cell_Specs_all'./((Hex_Planes_all(:,1).^2+Hex_Planes_all(:,2).^2+Hex_Planes_all(:,3).^2).^0.5)

for kk = 1:4 
[~,Hex_index(kk)]=min(Dis_From_Center);
Dis_From_Center(Hex_index(kk))=99999; %set it to really big
end
Cell_Specs=Cell_Specs_all(Hex_index);

Hex_Planes=Hex_Planes_all(Hex_index,:);

end

