function ans = DSM(a,Nt,b)

St_prev = eye(Nt);
len = floor(log2(factorial(Nt))) + Nt*b;

recieved = '';
for t = [1:size(a,2)/len]
    x = a(len*(t-1)+1:len*t);
    Xt = lookup_map(x,Nt,b);
    St = St_prev*Xt;
    ans = receiver(Nt, b, St, St_prev);
    recieved = strcat(recieved,ans);
    %transmit and recieve blah blahh
    St_prev = St;
end
