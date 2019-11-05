clc
clear

Nt = 3;Nr=[2,3];b = 2;
SNR = [0:3:21];

for j= 1:length(Nr)
    berSM(j,:) = SM(Nt,Nr(j),SNR)
end

for i = 1:length(Nr)
    for n = 1:length(SNR)
        numErrs = 0;
        numBits = 0;
        
        while numErrs < 200 && numBits < 5e5
            len = floor(log2(factorial(Nt))) + Nt*b;
            dataIn = randi([0 1],1,100*len);
            dataOut = DSM(dataIn,Nt,Nr(i),b,SNR(n));
            
            % Calculate the number of bit errors
            nErrors = biterr(dataIn(len+1:100*len),dataOut(len+1:100*len));
            
            % Increment the error and bit counters
            numErrs = numErrs + nErrors;
            numBits = numBits + length(dataIn);
        end
        
        % Estimate the BER
        berDSM(i,n) = numErrs/numBits
    end
end

%figure;
semilogy(SNR,berSM,'-o');
hold on;
grid on;
semilogy(SNR,berDSM,'-s');
xlabel('SNR in dB');
legend({'SM Nt=3 Nr=2 BPSK','SM Nt=3 Nr=3 BPSK','DSM Nt=3 Nr=2 QPSK', 'DSM Nt=3 Nr=3 QPSK'})
ylabel('Bit Error Rate');
title('DSM vs SM');