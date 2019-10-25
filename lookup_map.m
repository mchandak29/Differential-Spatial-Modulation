function X = lookup_map(bits, Nt, b)
        % Maps the value of bits to X matrix that belongs to Gm
    % bits1 should be of the size [log2(Nt!)]
    % bits2 should be of the size Nt*b
    len1 = floor(log2(factorial(Nt)));
    len2 = Nt*b;
    bits1 = bits(1:len1);
    bits2 = bits(len1+1:len1+len2);
    % lookup table generation
    tot_tables = 2^(len1);
    
    temp = linspace(1,Nt,Nt);
    lookup = perms(temp);
    lookup = flip(lookup,1);
    lookup = lookup(1:tot_tables,:);
    
    ind = lookup(bi2de(bits1,'left-msb')+1,:);
    matrix = full(ind2vec(ind,Nt));
    count = 1;
    col = 1;
    var = zeros(1,b);
  
    
    for a=bits2
        if count<=b
            var(count)=a;
            count=count+1;
        end
        if count==b+1
            symbol=pskmod(bi2de(var,'left-msb'), 2^b);
            matrix(:,col)= matrix(:,col)*symbol;
            col=col+1;
            var = zeros(1,b);
            count=1;
        end
    end
    
    X = matrix;
end