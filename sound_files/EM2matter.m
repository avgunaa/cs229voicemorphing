function [phi, mean, sigma, probability] = EM2matter(X, num_classes, q)

% X = rand(1,10000);

Y = rand(1000,1);


% num_classes = 50; % number of classes in mixture of gaussian

% q = 5; % length of vector x_i

num_samples = length(X)/q; % number of vectors x_i

Xt = [];
Yt = [];
phi = (1/num_classes) * ones(num_classes, 1);
mean = rand(num_classes, q);
sigma = ones(q, q, num_classes);

for i=1:num_classes
   sigma(:,:,i) = eye(q); 
end

for i = 1:num_samples
    Xt = [Xt; X((i-1)*q+1:i*q)]; %  dimension of Xt = num_samples x q
    %Yt = [Yt; Y(i:i+q-1)];
end

% a = size(Xt)


% First Estep
probability = rand(num_samples, num_classes);

%for i = 1:num_samples
% probability(i,:) = probability(i,:) / sum(probability(i,:));
%end
converge = false;
num_iter = 0;

num_iter

while(~converge)
    
    old_probability = probability;
    converge = true;
    max_diff = 0;
    
%     b = size(probability)
   % Estep
    for i = 1:num_samples
        
    %    denominator = 0;
    %   for k = 1:num_classes
    %        denominator = denominator + (1/det(sigma(:,:,k))) * exp(-1*(Xt(i,:) - mean(k,:)) * inv(sigma(:,:,k)) * (Xt(i,:) - mean(k,:))');
    %    end
        
        for k = 1:num_classes
            numerator = (1/det(sigma(:,:,k))) * exp(-1*(Xt(i,:) - mean(k,:)) * inv(sigma(:,:,k)) * (Xt(i,:) - mean(k,:))') * phi(k);
            probability(i,k) = numerator;
        end
        probability(i,:) = probability(i,:)/sum(probability(i,:));
%         if max(abs(probability(i,:) - old_probability(i,:))) > 0.001
%             converge = false;
%             max_diff = max(abs(probability(i,:) - old_probability(i,:)));
%         end
    end
     
    max_diff = norm(probability - old_probability);
    if max_diff > 1
        converge = false;
    end
    num_iter = num_iter + 1;
    num_iter
    max_diff

   % Mstep

    phi = (1/num_samples) * sum(probability);
    
    for j = 1:num_classes
        %phi(j) = (1/num_samples) * sum(probability(:,j));
        
        mean(j,:) = (probability(:,j)'*Xt)/sum(probability(:,j));
        
        temp_sigma = zeros(q,q);
        for k = 1:num_samples
            temp_sigma = temp_sigma + (probability(k,j)*(Xt(k,:)-mean(j,:))'*(Xt(k,:)-mean(j,:)));
        end
        sigma(:,:,j) = temp_sigma/sum(probability(:,j));
    end

end
 