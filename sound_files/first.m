[amru1,f] = wavread('amru1.wav');
[gunaa1,f] = wavread('gunaa1.wav');
[chappli1,f] = wavread('chappli1.wav');

[amru2,f] = wavread('amru2.wav');
[gunaa2,f] = wavread('gunaa2.wav');
[chappli2,f] = wavread('chappli2.wav');

amru1 = [amru1; zeros(size(chappli1) - size(amru1), 1)];
gunaa1 = [gunaa1; zeros(size(chappli1) - size(gunaa1), 1)];

amru2 = [amru2; zeros(size(chappli2) - size(amru2), 1)];
gunaa2 = [gunaa2; zeros(size(chappli2) - size(gunaa2), 1)];

a_fft = fft(amru1);
g_fft = fft(gunaa1);
c_fft = fft(chappli1);

plot(abs(a_fft))
hold
plot(abs(g_fft), 'r')
plot(abs(c_fft), 'g')

for i=1:size(gunaa1)
   if abs(g_fft(i)) < 40 || abs(a_fft(i)) < 40
       scale1(i) = 1;
   end
end

op = scale1.*g2_fft;
sound_op = ifft(op);
sound(sound_op,f);

amru2 = amru2(1:size(amru1,1));
h_amru2 = hilbert(amru2);
rem_env_amru2 = amru2 ./ abs(h_amru2);


a1_fft = fft(rem_env_amru1);
a2_fft = fft(rem_env_amru2);
g1_fft = fft(rem_env_gunaa1);

scale = abs(g1_fft) ./ abs(a1_fft);

op = a2_fft .* scale;
sound_op = ifft(op);
sound_op_env = sound_op .* abs(h_amru2);

% load sample data

samplesize = 10;
soundsize = 0;

for i = 1:samplesize
    s_a = size(wavread(strcat('aw',int2str(i),'.wav')), 1);
    s_g = size(wavread(strcat('gw',int2str(i),'.wav')), 1);
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
    amru(i,:) = wavread(strcat('words/aw',int2str(i),'.wav'))';
    gunaa(i,:) = wavread(strcat('words/gw',int2str(i),'.wav'))';
end

% remove envelope and find scale

amru_f = zeros(1,soundsize);
gunaa_f = zeros(1,soundsize);

for i = 1:samplesize
    amru_f = amru_f + abs(fft( amru(i,:) ./ abs(hilbert(amru(i,:))) ));
    gunaa_f = gunaa_f + abs(fft( gunaa(i,:) ./ abs(hilbert(gunaa(i,:))) ));
end

scale = gunaa_f ./ amru_f;

[input,f] = wavread('words/aw1.wav');
env = (hilbert(input));
input_re = input ./ abs(env);
fft_output_re = fft(input_re) .* scale;
output_re = ifft(fft_output_re);
output = output_re .* abs(env);

sound(output,f);
 