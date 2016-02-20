function [keffmat] = Get_keffmat(output_file_location)

output_string = fileread(output_file_location);
kstart=findstr(output_string, ' neutronics and burnup data')

kend=findstr(output_string,'Individual Material Burnup');

%sometimes mcnp lists things differnelty 
if size(kend,2)==0
kend=findstr(output_string,'nuclide data are');
end

keff_string=output_string(kstart+227:kend(1)-1);

keff_string_fixed=strrep(keff_string, 'undefined', '00000000');

keffmat=str2num(keff_string_fixed)

kstart2=findstr(output_string, 'burn time')
kend2=findstr(output_string, 'pfrac')
keff_string=output_string(kstart2+10:kend2(1)-1)
keff_string=regexprep(keff_string,'\d\d\d-' ,' ')
keff_string=regexprep(keff_string,'\d\d\d\d-' ,' ')
keff_string=regexprep(keff_string,'' ,' ')
keff_string=strrep(keff_string,'&',' ')
burnp=str2num(regexprep(keff_string,'\s',' '));% gets the burn perioeds


keffmat(1,11)=0; %time in hours
for kk=1:length(burnp)
keffmat(kk+1,11)=keffmat(kk,11)+burnp(kk)*24; %time in hours
end 
%% does not work if you start with a decay step
burnks=findstr(output_string, 'final result')
bkk_counter=1;
kstring=output_string(burnks(1)+15:burnks(1)+43);
kstringnum=str2num(kstring);
keffmat(1,14)=kstringnum(2);
for kk= 2:length(keffmat(:,13))
if keffmat(kk,4) > .00001
    bkk_counter=bkk_counter+2;
else
    bkk_counter=bkk_counter+1;
end

kstring=output_string(burnks(bkk_counter)+15:burnks(bkk_counter)+43);
kstringnum=str2num(kstring);
keffmat(kk,14)=kstringnum(2);

end 
    
    

end

