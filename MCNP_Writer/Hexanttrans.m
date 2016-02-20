function [Hex_Points,Transform] = Hexanttrans( Hex_Points,Hex_Size)

Inv_Transform = (2/((3)^.5))*[((3)^.5)/2,-.5;0,1];

Transform = [1,.5;0,(3)^.5/2];


if Hex_Size > 2


  
  %simple rotation matrix
  RHex1 = ((Inv_Transform*[cosd(60),-sind(60);sind(60),cosd(60)]*Transform)*Hex_Points')';
  RHex2 = ((Inv_Transform*[cosd(120),-sind(120);sind(120),cosd(120)]*Transform)*Hex_Points')';
    RHex3 = ((Inv_Transform*[cosd(180),-sind(180);sind(180),cosd(180)]*Transform)*Hex_Points')';
      RHex4 = ((Inv_Transform*[cosd(240),-sind(240);sind(240),cosd(240)]*Transform)*Hex_Points')';
        RHex5 = ((Inv_Transform*[cosd(300),-sind(300);sind(300),cosd(300)]*Transform)*Hex_Points')';
        
        
Hex_Points = [Hex_Points;  RHex1;RHex2;RHex3;RHex4;RHex5];


Hex_Points = round([[0,0];Hex_Points]);
elseif  Hex_Size == 2
    
Hex_Points= [0,0;1,0;-1,0;-1,1;0,1;0,-1;1,-1];

else 
    Hex_Points = [0,0];
end 

end

