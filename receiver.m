function bits = receiver(N_t, b, Y_t, Y_t_hat)
    y = (Y_t')*Y_t_hat;
    
    num_perm = floor(log(factorial(N_t))/log(2));
    num_bits = N_t*b;
    p=[1:N_t];
    permutations = flip(perms(p),1);
    bin_com = [0:2^(N_t*b)-1];
    bin_com = dec2bin(bin_com);
    max=intmin;
    
    for i=[1:(2^num_perm)]
        mat1 = zeros(N_t);
        for j=[1:length(bin_com)]
            for k=[1:N_t]
                val=pskmod(bin2dec(bin_com(j,(k-1)*b+1:k*b)),2^b);
                mat1(permutations(i,k),k)=val;end
            
            
            temp_mat = y*mat1;
            temp_val = trace(real(temp_mat));
            if temp_val>max
                max=temp_val;
                X_t = mat1;
                final_i=i;
            end
        end
    end
    str1=dec2bin(final_i-1,num_perm);
    
    for i=[1:N_t]
        str2=dec2bin(pskdemod(X_t(permutations(final_i,i),i),2^b), b);
        str1=strcat(str1,str2);
    end
    bits = str1;
end