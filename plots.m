clc
close all
clear all
M = 16; 
b=0;
Nt = linspace(1,M,M); 

DSM_theory= 1./(Nt) .* log2(factorial(M)) + b;
DSM_prac = 1./(Nt) .* floor(log2(factorial(M))) + b;
SM_theory = log2(Nt) + b;
SM_prac = floor(log2(Nt)) +b;

hold;
grid on
title('Graph')
xlabel('Number of transmit antennas N_t')
ylabel('Spectral efficiency (bits/s/Hz)')
xlim([2,M])
plot(SM_theory,'-o','MarkerIndices',1:length(Nt))
plot(SM_prac,'-x','MarkerIndices',1:length(Nt))
plot(DSM_theory,'-o','MarkerIndices',1:length(Nt))
plot(DSM_prac,'-x','MarkerIndices',1:length(Nt))

legend({'SM (theory)','SM (practical)','DSM (theory)','DSM (practical)'},'Location','southeast')

function f = factorial(n)
    f = ones(1,n);
    for i=2:n
        f(i)=f(i-1)*i;
    end
end