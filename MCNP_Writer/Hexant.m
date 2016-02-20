function [Hex_Points] = Hexant( Hex_Points,Hex_Size)

for i=2:Hex_Size-1;
    kk = 1;
    qq = Hex_Points(i,:);
    
    while qq(kk,1)~=1
        
        qq(kk+1,:) = qq(kk,:) + [-1,1];
        
        kk = kk +1;        
    end    
   
    Hex_Points(((i-2)*(i-1)*.5 + Hex_Size):(.5*i*(i-1)+Hex_Size-1),:) = qq(2:end,:);       
end


end

