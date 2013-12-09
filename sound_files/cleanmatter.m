num_samples = 10;

for i=1:num_samples
   [a,f] = wavread(strcat('words/vw_dtw',int2str(i), '.wav'));
   var = a(2000:end-1000);
   index = find(var > 0.15);
   a_new = var(index(1):index(end));

   
   g = wavread(strcat('words/ggw_dtw',int2str(i), '.wav'));
   var = g(2000:end-1000);
%   index = find(var > 0.1);
   g_new = var(index(1):index(end));
   
   %m = min(size(a_new,1),size(g_new,1));
   
   %a_new = a_new(1:m);
   %g_new = g_new(1:m);
   
   wavwrite(a_new, f, strcat('words/vw_dtw_c', int2str(i),'.wav'));
   wavwrite(g_new, f, strcat('words/ggw_dtw_c', int2str(i), '.wav'));
   
   
   
end