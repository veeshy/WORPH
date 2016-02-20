function [keff_mat] = Get_keffmat_sss(File_loc)

[pathstr,name,ext] = fileparts(File_loc)

try
run([pathstr '\' 'w.m'])
catch
    movefile([pathstr '\' 'WORPH_SSS.ip_res.m'],[pathstr '\' 'w.m'])
 run([pathstr '\' 'w.m'])
end
    
keff_mat(:,1)=(0:1:(length(ABS_KEFF(:,1))-1))';
keff_mat(:,5)=ABS_KEFF(:,1);
keff_mat(:,14)=ABS_KEFF(:,2);
keff_mat(:,11)=BURN_DAYS(:,1)*24;
keff_mat(:,4)= TOT_POWER(:,1);
end

