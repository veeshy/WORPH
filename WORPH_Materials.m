function [] = WORPH_Materials(MCNP,fileID,code)

Write_MCNP_Fuel_Mats(MCNP,fileID);
Write_MCNP_Tietube_Mats(MCNP,fileID);


% %Out clad
%       fprintf(fileID,'m%i ',Out_Cladspec.Out_Clad_Cell_Number)
%       fprintf(fileID,Out_Cladspec.Material_String)
%         if isfield(Out_Cladspec,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Out_Cladspec.Cell_Number{kk});
%           fprintf(fileID,out_Cladspec.Material_SAB_String);
%         end  
% 
% %In Clad
% for kk=1:length(In_Cladspec.Cell_Number)
%       fprintf(fileID,'m%i ', In_Cladspec.Cell_Number{kk})
%       fprintf(fileID,In_Cladspec.Material_String)
%         if isfield(In_Cladspec,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', In_Cladspec.Cell_Number{kk});
%           fprintf(fileID,In_Cladspec.Material_SAB_String);
%         end  
% end
% 
% %Fuel coolant
% for kk=1:length(Coolantspec.Cell_Number)
%       fprintf(fileID,'m%i ', Coolantspec.Cell_Number{kk})
%       fprintf(fileID,Coolantspec.Material_String)
%         if isfield(Coolantspec,'Material_SAB_String')
%           fprintf(fileID,'mt%i ' ,Coolantspec.Cell_Number{kk});
%           fprintf(fileID,Coolantspec.Material_SAB_String);
%         end  
% end
%     
% 
% %fuel
% 
%   Mat_Num=unique(Fuelspec.Mat_Number)
% for kk=1:length(unique(Fuelspec.Mat_Number))
%       fprintf(fileID,'m%i ' ,Mat_Num(kk))
%       fprintf(fileID,Fuelspec.Material_String)
%         if isfield(Fuelspec,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Mat_Num(kk));
%           fprintf(fileID,Fuelspec.Material_SAB_String);
%         end  
% end
% %% Tietube 
% 
% %In_cool 
% fprintf(fileID,'m%i ',Tietubespecs.In_Cool.Cell_Number)
% fprintf(fileID,Tietubespecs.In_Cool.Material_String)
%         if isfield(Tietubespecs.In_Cool,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.In_Cool.Cell_Number{kk});
%           fprintf(fileID,Tietubespecs.In_Cool.Material_SAB_String);
%         end  
%         
% %In_Metal
% fprintf(fileID,'m%i ',Tietubespecs.In_Metal.Cell_Number)
% fprintf(fileID,Tietubespecs.In_Metal.Material_String)
%         if isfield(Tietubespecs.In_Metal,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.In_Metal.Cell_Number{kk});
%           fprintf(fileID,Tietubespecs.In_Metal.Material_SAB_String);
%         end  
% 
% 
% %Moderator
% fprintf(fileID,'m%i ',Tietubespecs.Moderator.Cell_Number)
% fprintf(fileID,Tietubespecs.Moderator.Material_String)
%         if isfield(Tietubespecs.Moderator,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Moderator.Cell_Number);
%           fprintf(fileID,Tietubespecs.Moderator.Material_SAB_String);
%         end  
% 
% %Out_Cool
% fprintf(fileID,'m%i ',Tietubespecs.Out_Cool.Cell_Number)
% fprintf(fileID,Tietubespecs.Out_Cool.Material_String)
%         if isfield(Tietubespecs.Out_Cool,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Out_Cool.Cell_Number);
%           fprintf(fileID,Tietubespecs.Out_Cool.Material_SAB_String);
%         end  
%         
%         
% %Out_Metal
% fprintf(fileID,'m%i ',Tietubespecs.Out_Metal.Cell_Number)
% fprintf(fileID,Tietubespecs.Out_Metal.Material_String)
%         if isfield(Tietubespecs.Out_Metal,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Out_Metal.Cell_Number);
%           fprintf(fileID,Tietubespecs.Out_Metal.Material_SAB_String);
%         end  
%     
% 
% %In_Insulator
% fprintf(fileID,'m%i ',Tietubespecs.In_Insulator.Cell_Number)
% fprintf(fileID,Tietubespecs.In_Insulator.Material_String)
%         if isfield(Tietubespecs.In_Insulator,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.In_Insulator.Cell_Number);
%           fprintf(fileID,Tietubespecs.In_Insulator.Material_SAB_String);
%         end 
% 
% %Out_Insulator
% fprintf(fileID,'m%i ',Tietubespecs.Out_Insulator.Cell_Number)
% fprintf(fileID,Tietubespecs.Out_Insulator.Material_String)
%         if isfield(Tietubespecs.Out_Insulator,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Out_Insulator.Cell_Number);
%           fprintf(fileID,Tietubespecs.Out_Insulator.Material_SAB_String);
%         end 
%         
% %% Tietube poisioned
% %Moderator
% fprintf(fileID,'m%i ',Tietubespecs.Moderator.Cell_Number)
% fprintf(fileID,Tietubespecs.Moderator.Material_String)
%         if isfield(Tietubespecs.Moderator,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Moderator.Cell_Number);
%           fprintf(fileID,Tietubespecs.Moderator.Material_SAB_String);
%         end  
% 
% %Out_Cool
% fprintf(fileID,'m%i ',Tietubespecs.Out_Cool.Cell_Number)
% fprintf(fileID,Tietubespecs.Out_Cool.Material_String)
%         if isfield(Tietubespecs.Out_Cool,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Out_Cool.Cell_Number);
%           fprintf(fileID,Tietubespecs.Out_Cool.Material_SAB_String);
%         end  
%         
%         
% %Out_Metal
% fprintf(fileID,'m%i ',Tietubespecs.Out_Metal.Cell_Number)
% fprintf(fileID,Tietubespecs.Out_Metal.Material_String)
%         if isfield(Tietubespecs.Out_Metal,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Out_Metal.Cell_Number);
%           fprintf(fileID,Tietubespecs.Out_Metal.Material_SAB_String);
%         end  
%     
% 
% %In_Insulator
% fprintf(fileID,'m%i ',Tietubespecs.In_Insulator.Cell_Number)
% fprintf(fileID,Tietubespecs.In_Insulator.Material_String)
%         if isfield(Tietubespecs.In_Insulator,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.In_Insulator.Cell_Number);
%           fprintf(fileID,Tietubespecs.In_Insulator.Material_SAB_String);
%         end 
% 
% %Out_Insulator
% fprintf(fileID,'m%i ',Tietubespecs.Out_Insulator.Cell_Number)
% fprintf(fileID,Tietubespecs.Out_Insulator.Material_String)
%         if isfield(Tietubespecs.Out_Insulator,'Material_SAB_String')
%           fprintf(fileID,'mt%i ', Tietubespecs.Out_Insulator.Cell_Number);
%           fprintf(fileID,Tietubespecs.Out_Insulator.Material_SAB_String);
%         end 
        
end





