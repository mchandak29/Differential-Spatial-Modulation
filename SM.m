% Spatial Modulation   
function BER = SM(NTx,MRx,SNR)
%clear all; 
format short e 

SignalSet=[1;-1];  %BPSK Signal Set
BitMapping_q=[0;1];
Es=1;  
S=0;
            
Trail=1000;
NumberOfBits=1e5;
%NTx=input('Input  number of Transmit antennas >> ');
%MRx=input('Input number of receive antennas  >> ');
%SNR=0:2:20;

BitMapping_j=dec2bin(0:NTx-1,2); % Bitmapping for each transmit antenna

qset=length(SignalSet); 
Bits=0;

effq=log2(qset); % Bits per signal set
effj=log2(NTx);  % Bits per antenna

BER=zeros(1,length(SNR));
H=zeros(MRx,NTx);
AWGN=zeros(MRx,1);
Y=zeros(MRx,1);

for jj=1:length(SNR)
    ER=0;
    
    Bits=0;
    
    Sigma2=Es*10^(-SNR(jj)/10);  %% noise variance 
    
    while ((min(ER)<Trail)||((Bits<NumberOfBits)&&(min(ER)>=Trail)))
      
        Indexq=ceil(qset*rand(1,1));   % Signal point
        Indexj=ceil(NTx*rand(1,1));    % Antenna  
        X=SignalSet(Indexq);               
        Bits=Bits+effq+effj;                          %% bit Counter
        
        %% The Fading Channel
        H=abs(sqrt(0.5)*randn(MRx,NTx)+i*sqrt(0.5)*randn(MRx,NTx));
        
        %Generate the Gaussain Noise 
        AWGN=sqrt(Sigma2/2)*randn(MRx,1)+i*sqrt(Sigma2/2)*randn(MRx,1);
        
        Y=H(:,Indexj)*X+AWGN; % one transmission at a time 
        
        % Spatial Demodulator 

        ER=ER+SpatialDem(Y,H,SignalSet,Indexj,Indexq,BitMapping_j,BitMapping_q);

    end % end while loop
    BER(:,jj)=ER/Bits;
    
end %% end SNR loop


%figure;
%hold on;
%semilogy(SNR,BER,'b');
%xlabel('SNR in dB');
%legend('Nt = 2')
%ylabel('BER');

%title('Spatial Modulation performance');
