function ans = DSM(a,Nt,Nr,b,SNR)

St_prev = eye(Nt);
Yt_prev = eye(Nt);
Yt_prev = Yt_prev(1:Nr,:);

len = floor(log2(factorial(Nt))) + Nt*b;
H=sqrt(0.5)*randn(Nr,Nt)+1i*sqrt(0.5)*randn(Nr,Nt);

recieved = '';
for t = [1:size(a,2)/len]
    x = a(len*(t-1)+1:len*t);
    Xt = lookup_map(x,Nt,b);
    St = St_prev*Xt;
    %transmit and recieve
    Sigma=10^(-SNR/10);
    
    AWGN=sqrt(Sigma/2)*randn(Nr,Nt)+1i*sqrt(Sigma/2)*randn(Nr,Nt);
    Yt = H*St + AWGN;
    
    ans = receiver(Nt, b, Yt, Yt_prev);
    recieved = strcat(recieved,ans);
    St_prev = St;
    Yt_prev = Yt;
end

ans = recieved-'0';