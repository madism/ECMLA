%% Draw an example signal before and after Fourier Transform (FFT)
% Time specifications:
Fs = 8000;                   % samples per second
dt = 1/Fs;                   % seconds per sample
StopTime = 0.25;             % seconds
t = (0:dt:StopTime-dt)';     % seconds
L = length(t);
n = 2^nextpow2(L);

% Sine wave:
Fc = 10;                     % hertz
x = cos(2*pi*Fc*t);
Y = fft(x,n);
f = Fs*(0:(n/2))/n;
P = abs(Y/n);

% Plot the the signal before Fourier Transform (Time vs Amplitude):
figure;
plot(t,x);
xlabel('Time (s)');
ylabel('Amplitude')
zoom xon;

% Plot the the signal after Fourier Transform (Frequency vs Power):
%bar(f,P(1:n/2+1))
%xlabel('Frequency (Hz)')
%ylabel('Power')