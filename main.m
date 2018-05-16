close all
clear all
clc
%%
[audioinput,path]=uigetfile('*'); % select the audio file
% [y,Fs] = audioread('testnext1.wav');
[y,Fs] = audioread([path,audioinput]); % reading audio files
speech.y=y;
sound(y,Fs);
%% magnitude spectrum compensation
output=spectrumsubtraction(y,Fs);% noise reduction
%% phase spectrum compensation
speech.noisy=output;
time = [0:length(speech.noisy)-1]/Fs; % create time vector
Tw = 32; % analysis frame duration (ms) 
Ts = Tw/8; % analysis frame shift (ms)
lambda = 3.74; % scale of compensation 

% enhance noisy speech using the PSC method
[speech.psc_B] = psc(speech.noisy, Fs, Tw, Ts, 'G&L', lambda);
%%
subplot(3,2,1)
plot(y),
% subplot(3,2,2),myspectrogram(y, Fs)
subplot(3,2,2),spectrogram(y(:,2),128,120,128,1e3)
subplot(3,2,3)
plot(output)
% subplot(3,2,4),myspectrogram(output, Fs)
subplot(3,2,4),spectrogram(output,128,120,128,1e3)
subplot(3,2,5)
plot(speech.psc_B)
% spectrogram(speech.psc_B,128,120,128,1e3)
% subplot(3,2,6),myspectrogram(speech.psc_B, Fs)
subplot(3,2,6),spectrogram(speech.psc_B,128,120,128,1e3)