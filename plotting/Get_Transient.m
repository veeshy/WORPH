function [transient] = Get_Transient(keffmat )
%makes the Transient from a mcnp burn untis of delta k/k


keffs=(keffmat(:,5)-keffmat(1,5))./(keffmat(:,5)*keffmat(1,5)); %lets pertend that this thing starts crit with leakage


transient(:,1)=keffmat(:,11); %time in hours



transient(:,2)=keffs/.0068;%made up beta
transient(:,3) = ((keffmat(:,14)./keffmat(:,5).^2).^2+(keffmat(1,14)./keffmat(1,5).^2).^2).^0.5/.0068;
transient(1,3) = ((keffmat(1,14)./keffmat(1,5).^2).^2).^0.5/.0068;

end

