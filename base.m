clc
clear
Nt = 2;
b = 1;
SNR = [0:3:30]


for n = 1:length(SNR)
    
    numErrs = 0;
    numBits = 0;
    
    while numErrs < 200 && numBits < 1e5
        len = floor(log2(factorial(Nt))) + Nt*b;
        dataIn = randi([0 1],1,10*len);
        
        dataOut = DSM(dataIn,Nt,b);
        
        % Calculate the number of bit errors
        nErrors = biterr(dataIn,dataOut);
        
        % Increment the error and bit counters
        numErrs = numErrs + nErrors
        numBits = numBits + length(dataIn);
    end
    
    % Estimate the BER
    berEst(n) = numErrs/numBits;
end