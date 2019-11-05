function BE=SpatialDem(r,H,SignalSet,Inputj,Inputq,BitMapping_j,BitMapping_q)
[MRx,NTx]=size(H);
a=zeros(NTx,1);
Metric=zeros(NTx,1);
for jj=1:NTx
    [Metric(jj),a(jj)]=Detector(r,H(:,jj),SignalSet);  %% detection
end

[mm,Detj]=min(Metric);
Detq=a(Detj);

BE=sum(sum(mod(BitMapping_j(Inputj,:)+BitMapping_j(Detj,:),2)+mod(BitMapping_q(Inputq,:)+BitMapping_q(Detq,:),2)));

function [mm,Out]=Detector(y,hj,SignalSet)
qset=length(SignalSet); 
Metric=zeros(qset,1);
%%
for qq=1:qset
    Metric(qq)=(hj*SignalSet(qq))'*(hj*SignalSet(qq))-2*real(y'*hj*SignalSet(qq)); %same as paper 
end
%% ML Detector
[mm,Out]=min(Metric);

 

