function env_new = envelope(sequence)

env = [];
hil = abs(hilbert(sequence));
val = 10;

for i = 1:length(hil)-val
   env = [env sum(hil(i:i+val-1))/val]; 
end

env = [env hil(end-val+1:end)'];

env_new = [];
hil_new = abs(hilbert(env'));
val = 10;

for i = 1:length(hil_new)-val
   env_new = [env_new sum(hil_new(i:i+val-1))/val]; 
end

env_new = [env_new hil_new(end-val+1:end)'];
% 
% figure
% plot(sequence);
% hold on
% plot(env,'r');
% plot(env_new,'g');
% hold off