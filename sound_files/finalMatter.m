
sa = [];
sg = [];

for i = [1 4 5]
    [sa_temp,f] = wavread(strcat('words/aw_dtw_c', int2str(i), '.wav'));
    sa = [sa; sa_temp];
    size(sa_temp);
    sg_temp = wavread(strcat('words/gw_dtw_c', int2str(i),'.wav'));
    sg = [sg; sg_temp];
    size(sg_temp);
end

num_classes = 50;
q = 8;

X = sg(1:length(sg)-mod(length(sa),q));

Y = sa(1:length(sa)-mod(length(sa),q));

%Ynew;

X = X';

Y = Y';

Xt = [];

Yt = [];

[phi, mean, sigma, probability] = EM2matter(X, num_classes, q);

numSamples = floor(length(X)/q);
num_newSamples = floor(length(Xnew)/q);

for i = 1:numSamples
    Xt = [Xt; X((i-1)*q+1:i*q)]; %  dimension of Xt = num_samples x q
    Yt = [Yt; Y((i-1)*q+1:i*q)];
end

Xt = Xt';
Yt = Yt';

Xaug = [Xt; ones(1, numSamples)];

lambda = zeros(num_classes*(q+1), numSamples);
lambda = [];

%lambda = probability;

for i = 1:numSamples
    temp_vector = [];
    for j = 1:num_classes
       temp_vector = [temp_vector probability(i,j)*Xaug(:,i)'];
    end
    lambda = [lambda; temp_vector];
end

lambda = lambda';

  
% for i=1:num_newSamples
%         for k = 1:num_classes
%             numerator = (1/det(sigma(:,:,k))) * exp(-1*(Xtnew(i,:) - mean(k,:)) * inv(sigma(:,:,k)) * (Xtnew(i,:) - mean(k,:))') * phi(k);
%             lambda(i,k) = numerator;
%         end
%         lambda(i,:) = probability(i,:)/sum(probability(i,:));
% end




[sg_new,f] = wavread(strcat('words/gw_dtw_c', int2str(4), '.wav'));

Xnew = sg_new(1:length(sg_new)-mod(length(sa),q));
Xnew = Xnew';
Xtnew = [];

for i = 1:num_newSamples
    Xtnew = [Xtnew; Xnew((i-1)*q+1:i*q)]; %  dimension of Xt = num_samples x q
    %Yt = [Yt; Y(i:i+q-1)];
end

Xtnew = Xtnew';
Xnew_aug = [Xtnew; ones(1, num_newSamples)];

lambda_new = [];
probability_new = ones(num_newSamples, num_classes);

for i = 1:num_newSamples
    temp_vector = [];
    for j = 1:num_classes
       probability_new(i,j) = (1/det(sigma(:,:,j))) * exp(-1*(Xtnew(:,i)' - mean(j,:)) * inv(sigma(:,:,j)) * (Xtnew(:,i)' - mean(j,:))') * phi(j);
       temp_vector = [temp_vector probability_new(i,j)*Xnew_aug(:,i)']; 
    end
    temp_vector = temp_vector/sum(probability_new(i,:));
    lambda_new = [lambda_new; temp_vector];
end

lambda_new = lambda_new';

W = Yt * lambda' * inv (lambda * lambda');

Y_new = W*lambda_new;

output = Y_new(:);