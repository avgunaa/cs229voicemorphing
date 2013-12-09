X = rand(1000,1);

Y = rand(1000,1);


num_classes = 10; % number of classes in mixture of gaussian

q = 10; % length of vector x_i

num_samples = length(X)/q; % number of vectors x_i

Xt = [];
Yt = [];
phi = zeros(num_classes, 1);
mean = zeros(num_classes, q);
var = zeros(num_classes, q, q);

for i = 1:num_samples
    Xt = [Xt; X(i:i+q-1)]; %  dimension of Xt = num_samples x q
    Yt = [Yt; Y(i:i+q-1)];
end

% First Estep
probability = (1/num_classes)*zeros(num_samples, num_classes);

while(no convergence)
   % Mstep
    for j = 1:num_classes
        phi(j) = (1/num_samples) * sum(probability(:,j));
        
        mean(j) = (probability(:,j)'*Xt)/sum(probability(:,j));
        
        temp_sigma = zeros(q,q);
        for k = 1:num_samples
            temp_sigma = temp_sigma + (probability(k,j)*(Xt(k,:)-mean(j))'*(Xt(k,:)-mean(j)));            
        end
        sigma(j,:,:) = temp_sigma/sum(probability(:,j));
    end
   % Estep
    
end
 