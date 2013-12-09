#import mlpy
#import numpy
#import scipy
#import io
#
#[g,f] = scipy.io.wavfile.read('../sound_files/words/gw1.wav')
#

#g = np.array[]
#a = np.array[]

#mlpy.Dtw(onlydist = False)

#!usr/bin/env python  
#coding=utf-8  

import pyaudio  
import wave  

#define stream chunk   
chunk = 1024  

#open a wav format music  
f = wave.open(r"../sound_files/words/gw3.wav","rb")  
#instantiate PyAudio  
p = pyaudio.PyAudio()  
#open stream  
stream = p.open(format = p.get_format_from_width(f.getsampwidth()),  
                channels = f.getnchannels(),  
                rate = f.getframerate(),  
                output = True)  
#read data  
data = f.readframes(chunk)  

#paly stream  
while data != '':  
    stream.write(data)  
    data = f.readframes(chunk)  

#stop stream  
stream.stop_stream()  
stream.close()  

#close PyAudio  
p.terminate()  
