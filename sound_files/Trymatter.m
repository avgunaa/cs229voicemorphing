% FFT of short sound signals and doing linear regression

p = 100;

numsamples = 2;

sa = [];
sg = [];

envelope(rand(1000,1));

for i = 1:9
    [sa_temp,f] = wavread(strcat('words/aw_dtw_c', int2str(i), '.wav'));
    sa = [sa; sa_temp];
    size(sa_temp);
    sg_temp = wavread(strcat('words/gw_dtw_c', int2str(i),'.wav'));
    sg = [sg; sg_temp];
    size(sg_temp);
end

na = size(sa,1);
ng = size(sg,1);


num_Xa = floor(na/p);
num_Xg = floor(ng/p);

Xa = zeros(num_Xa,p);
Xg = zeros(num_Xg,p);

for i = 1:num_Xa
    Xa(i,:) = envelope((abs(fft(sa((i-1)*p+1:i*p)))));
end

% Ya = sa(p+1:na);
% 
% Aa = inv(Xa'*Xa)*Xa'*Ya;
% 
% Aa = [-Aa; 1];
    
for i = 1:num_Xg
    Xg(i,:) = envelope((abs(fft(sg((i-1)*p+1:i*p)))));
end

theta = inv(Xg'*Xg)*Xg'*Xa;

sg_test = wavread(strcat('words/aw_dtw_c', int2str(1), '.wav'));

num_Xgtest = floor(length(sg_test)/p);

Xgtest = zeros(num_Xgtest,p);
A_output = zeros(length(sg_test),1);

for i = 1:num_Xgtest
    Xgtest(i,:) = ((abs(fft(sg_test((i-1)*p+1:i*p)))));
    A_output((i-1)*p+1:i*p) = abs(ifft(theta*Xgtest(i,:)'));
end


