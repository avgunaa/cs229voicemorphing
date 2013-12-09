% load sample data

samplesize = 10;
soundsize = 0;

for i = 1:samplesize
    s_a = size(wavread(strcat('words/aw',int2str(i),'.wav')), 1);
    s_g = size(wavread(strcat('words/gw',int2str(i),'.wav')), 1);
    if (s_a > soundsize)
        soundsize = s_a;
    end
    if (s_g > soundsize)
        soundsize = s_g;
    end
end
        
amru = zeros(samplesize, soundsize); 
gunaa = zeros(samplesize, soundsize); 
        
for i = 1:samplesize
    temp = wavread(strcat('words/aw',int2str(i),'.wav'))';    
    amru(i,:) = [temp zeros(1, soundsize - size(temp, 2))];
    
    temp = wavread(strcat('words/gw',int2str(i),'.wav'))';
    gunaa(i,:) = [temp zeros(1, soundsize - size(temp ,2))];
end

% remove envelope and find scale

amru_f = zeros(1,soundsize);
gunaa_f = zeros(1,soundsize);

for i = 1:samplesize
    amru_f = amru_f + abs(fft( amru(i,:) ./ abs(hilbert(amru(i,:))) ));
    gunaa_f = gunaa_f + abs(fft( gunaa(i,:) ./ abs(hilbert(gunaa(i,:))) ));
end

scale = gunaa_f ./ amru_f;

[input,f] = wavread('words/aw10.wav');
input = input';
input = [input zeros(1, soundsize - size(input,2))];
env = (hilbert(input));
input_re = input ./ abs(env);
fft_output_re = abs(fft(input_re)) .* scale;
output_re = ifft(fft_output_re);
output = output_re .* abs(env);

sound(output,f);
