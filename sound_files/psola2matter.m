p = 220;

numsamples = 2;

sa = [];
sg = [];

for i = 1:5
    [sa_temp,f] = wavread(strcat('words/gw_dtw_c', int2str(i), '.wav'));
    sa = [sa; sa_temp];
    size(sa_temp);
    sg_temp = wavread(strcat('words/aw_dtw_c', int2str(i),'.wav'));
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
    Xa(i,:) = sa((i-1)*p+1:i*p);
end

Ya = sa(p+1:na);

Aa = inv(Xa'*Xa)*Xa'*Ya;

Aa = [-Aa; 1];
    
for i = 1:num_Xg
    Xg(i,:) = sg((i-1)*p+1:i*p);
end

% Xa Xg is the training set Xa(i) is of length 220

Yg = sg(p+1:ng);

Ag = inv(Xg'*Xg)*Xg'*Yg;

gu_a = conv(sa,fliplr(Aa));

%gu_a = [sa; zeros(p-1,1)];
%gu_a = gu_a(round(p/2)+1:na + round(p/2));
v_a = zeros(na, p);

for i = 1:na
    v_a(i,:) = gu_a(i:i+p-1);
end

G = inv(v_a'*v_a)*v_a'*sg;

g_out = conv(fliplr(G),gu_a);

%{
k= 100;

g_out = [];
k_new = floor(na-p/k);
for j = 1:k_new
    g_out = [g_out; deconv(gu_a((j-1)*k+1:j+k),fliplr(Aa))];
end

%}

sound(sa,f);

sound(sg,f);

sound(g_out, f);