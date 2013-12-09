% sa = [];
% sg = [];
% 
% p = 200;
% m = 50;
% 
% ka = 20;
% kg = 20;
% 
% for i = 1:9
%     [sa_temp,f] = wavread(strcat('words/vw_dtw_c', int2str(i), '.wav'));
%     sa = [sa; sa_temp];
%     size(sa_temp);
%     sg_temp = wavread(strcat('words/ggw_dtw_c', int2str(i),'.wav'));
%     sg = [sg; sg_temp];
%     size(sg_temp);
% end
% 
% na = size(sa,1);
% ng = size(sg,1);
% 
% 
% num_Xa = floor(na/p);
% num_Xg = floor(ng/p);
% 
% Xa = zeros(num_Xa,p);
% Xg = zeros(num_Xg,p);
% 
% for i = 1:num_Xa
%     Xa(i,:) = sa((i-1)*p+1:i*p)';
%     Xg(i,:) = sg((i-1)*p+1:i*p)';
% end
% 
% [class, means] = kmeans(Xg,m);
% 
% theta = zeros(m,ka+kg-1);
% 
% for i=1:m
%    index = find(class == i); 
% 
%    temp_X = [];
%    temp_Y = [];
%    for j=1:length(index)
%        for k=ka:p
%            T1 = Xa(index(j),k-ka+1:k-1);
%            T2 = Xg(index(j),k-kg+1:k);
%            temp_X = [temp_X;T1 T2];
%            temp_Y = [temp_Y; Xa(index(j),k)];
%            %valuemuhahahaha = size(temp_X)
%        end
%    end
%    
%    theta(i,:) = inv(temp_X'*temp_X)*temp_X'*temp_Y;    
% end

sg_new = wavread(strcat('words/ggw_dtw_c', int2str(3), '.wav'));
ng_new = length(sg_new);
num_Xg_new = floor(length(sg_new)/p);

Xg_new = zeros(ng_new,p);
for i = 1:num_Xg_new
    Xg_new(i,:) = sg_new((i-1)*p+1:i*p)';
end


Xa_new = zeros(ng_new,p);
Xa_new = [];

for i=1:num_Xg_new
    norm_min = Inf;
    class_new = 0;
    for j=1:m
        diff = means(j,:) - Xg_new(i,:);
        if norm(diff) < norm_min
            class_new = j;
            norm_min = norm(diff);
        end
    end
    tempXg = [zeros(kg-1,1) ; Xg_new(i,:)' ];
    tempXa = zeros(p+ka-1,1);
    
    for k=1:p
        temp_vector = [tempXa(k:k+ka-2); tempXg(k:k+kg-1)];
        tempXa(ka+k-1) = theta(class_new,:)*temp_vector;
    end
    
    Xa_new = [Xa_new tempXa(ka:end)'];
%     
%     Xa_new(i,:) = theta(class_new,:)*Xg_new(i,:);
end

% x
% kmeans = zeros(m,p);
% for i=1:m
%    kmeans(i,:) = Xa(i,:); 
% end
% 
% class = zeros(num_Xa,1);
% 
% converge = false;
% while(~converge)
%     converge = true;
%     
%     % Assign a class for each sample
%     for i=1:num_Xa
%         for j=1:m
%             distance = kmeans(j,:) -  
%         end
%         
%         class(i) = 
%     end
%     
% end
% 
