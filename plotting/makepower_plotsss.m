function [powerdata] = makepower_plot(keffmat)
%makes a step graph of the data

powers=keffmat(:,4)/max(keffmat(:,4));
powers=[powers(end); powers(1:(end-1))];
powers=round(powers);
times=keffmat(:,11);

powerdata(1,:)=[-10,0];
powerdata(2,:)=[0,0];
powerdata(3,:)=[0,powers(1)];

% times(1)=keffmat(1,2); %time in hours
% for kk=2:length(keffmat(:,2))
% times(kk)=keffmat(kk,2)+times(kk-1); %time in hours
% end

qq=3
for kk=2:length(times)

if powerdata(qq,2)==powers(kk);
qq=qq+1;
powerdata(qq,:)=[times(kk),powers(kk)];
else
qq=qq+1;
powerdata(qq,:)=[times(kk-1),powers(kk)];
qq=qq+1;
powerdata(qq,:)=[times(kk),powers(kk)];
end
end
if powers(end) ~= 0
powerdata(qq+1,:)=[times(kk),0];
powerdata(qq+2,:)=[times(kk)*10,0];
end


if powers(end) == 0
powerdata(qq+2,:)=[times(kk)*10,0];
end


end

