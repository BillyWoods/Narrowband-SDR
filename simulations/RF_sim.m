clear all; close all;

% simulation settings
t_step = 1e-10;
Nyq = 1/(2*t_step);
t = 0:t_step:1500e-7;

% tuner settings (band it's tuned to, IF frequency and BW, local oscillator frequency, etc.)
tuned_freq = 100 * 1e6;
F_IF = 450 * 1e3;
IF_BW = 200 * 1e3; % 300 * 1e3
F_LO = tuned_freq - F_IF;

% ADC setup (for a RF single channel, i.e. one set of both I and Q)
ADC_Fs = 3 * 1e6;
channel_Fs =  ADC_Fs / (4*2); % sample rate per I/Q channel
ADC_BW = 50 * 1e6; % 3dB bandwidth of the ADC front end
% TODO: adc quantization, full scale, number of bits

%% setup the signals to input
% signal of interest
w_s = 100 * 1e6 * 2 * pi; % [rad/s]
A_s = 10 * 1e-6; % [volts]
s = A_s * cos(w_s * t);

% interferer
w_i = 100.2 * 1e6 * 2 * pi; % [rad/s]
A_i = 10 * 1e-6; % [volts]
s_i = A_i * cos(w_i * t);

% noise
k = 1.380649e-23;
T = 25 + 273;
N0 = k*T;% [W/Hz]
noise_power = N0 * Nyq;
n = sqrt(noise_power) * randn(size(t));

rf_in = s + s_i + n;

%% plots of input signals
figure()
% time domain
subplot(2,1,1);
plot(t, s, t, s_i, t, n);
legend('signal', 'interferer', 'noise');
xlabel('time (s)');
ylabel('voltage (v)');
title('RF Input Signals (Separate) in the Time Domain');
xlim([8.9e-6 9e-6]);
% freq domain
subplot(2,1,2);
f = abs(fftshift(fft(rf_in)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
xlabel('frequency (Hz)');
title('RF Input Signals (Combined) in the Frequency Domain');
xlim([98e6 102e6]);


%% External LNA
% models the gain, (non)-linearity and NF of the external LNA
gain = 14; % dB
NF = 2.8; % dB
IIP3 = 29 - gain; % dBm
[LNA_out, LNA_transfer] = LNA(gain, NF, IIP3, rf_in);

%% plot what the LNA is doing
figure();
% transfer function of LNA
subplot(2,1,1);
plot(LNA_transfer.x, LNA_transfer.y);
title('Input vs. Output for LNA');
xlabel('Input [V]');
ylabel('Output [V]');
% input vs. output in FD
subplot(2,1,2);
f = abs(fftshift(fft(rf_in)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold on;
f = abs(fftshift(fft(LNA_out)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold off;
xlabel('frequency (Hz)');
title('Frequency Domain');
legend('Signal into LNA', 'Signal Out of LNA');
xlim([98e6 102e6]);

%% Channel selection filter
% this channel selection is done by the tuner, but is more easily modelled out the front here
[CS_out, CS_transfer] = channel_selection_filter(F_LO + F_IF, IF_BW, t, LNA_out);

%% plot what's happening with the channel selection filter
figure();
% fft of input compared with freq response of filter
subplot(3,1,1);
f = abs(fftshift(fft(LNA_out)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold on;
semilogy(CS_transfer.f, CS_transfer.H);
hold off;
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('Input', '|H(f)| of filter');
xlim([98e6 102e6]);
title('Input to Tuner and |H(f)| of Channel Selection Filter');
% filtered signal in freq domain
subplot(3,1,2);
f = abs(fftshift(fft(CS_out)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
title('Output Signal (Frequency Domain)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([98e6 102e6]);
% filtered signal in time domain
subplot(3,1,3);
plot(t, CS_out);
xlim([8.9e-6 9e-6]);
xlabel('Time [s]');
ylabel('s(t) [v]');
title('Output Signal (Time Domain)');


%% RF part of tuner
% models the tuner's overall gain (frequency dependent)
% models all non-linearities in tuner
% models all noise introduced by tuner (except phase noise)
tuner_RF_out = CS_out; % TODO: proper implementation

%% Baseband part of tuner
% models downconversion (ideal--should this be ideal? maybe not to model IIP3, etc.)
% models phase noise on local oscillator
% models I/Q phase mismatch
% models I/Q amplitude mismatch
[I_LO, Q_LO] = local_oscillator(F_LO, t);

[I_tmp, Q_tmp] = mixer(tuner_RF_out, I_LO, Q_LO);

% filter again
I_baseband = fft_lowpass(I_tmp, t, ADC_BW);
Q_baseband = fft_lowpass(Q_tmp, t, ADC_BW);

%% plot the downconversion stuff
figure();
% look at LO signals
subplot(2,2,1);
plot(t, I_LO, t, Q_LO);
xlabel('Time [s]');
ylabel('v(t) [V]');
title('Local Oscillator Output');
legend('In-phase', 'Quadrature');
xlim([0 10*1e-8]);
subplot(2,2,2);
f = abs(fftshift(fft(I_LO + Q_LO)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold on;
f = abs(fftshift(fft(tuner_RF_out)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold off;
title('Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('Local Oscillator Output', 'RF (filtered and amplified)');
xlim([(F_LO - 5e6) (F_LO + 5e6)]);
% look at the mixer output
subplot(2,2,3);
plot(t, I_baseband, t, Q_baseband);
xlabel('Time [s]');
ylabel('v(t) [V]');
title('Mixer Output');
legend('In-phase', 'Quadrature');
subplot(2,2,4);
f = abs(fftshift(fft(I_baseband)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold on;
f = abs(fftshift(fft(Q_baseband)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold off;
title('Mixer Output (Frequency Domain)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('In-phase', 'Quadrature');
xlim([0 3*tuned_freq]);

%% Sampling and digitisation of baseband
[I_samples, I_t, I_debug] = ADC(channel_Fs, ADC_BW, 0, I_baseband, t);
T_delay = 1 / ADC_Fs;
[Q_samples, Q_t, Q_debug] = ADC(channel_Fs, ADC_BW, T_delay, Q_baseband, t);

%% plots of digitised signals
figure();
% LP filtered BB (time domain)
subplot(2,2,1);
plot(t, I_debug.s_LP, t, Q_debug.s_LP);
legend('I','Q');
title('Baseband LP Filtered by ADC Front End (Time Domain)');
xlabel('Time [s]');
ylabel('Magnitude');
% LP filtered BB (time domain)
subplot(2,2,2);
f = abs(fftshift(fft(I_debug.s_LP)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold on;
f = abs(fftshift(fft(Q_debug.s_LP)));
freqs = linspace(-Nyq, Nyq, length(f));
semilogy(freqs, f);
hold off;
title('Baseband LP Filtered by ADC Front End (Freq. domain)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('In-phase', 'Quadrature');
xlim([0 3*tuned_freq]);
% sampled BB (time domain)
subplot(2,2,3);
plot(I_t, I_samples, Q_t, Q_samples);
legend('I','Q');
title('Baseband Sampled by ADC (Time Domain)');
xlabel('Time [s]');
ylabel('Magnitude');
% sampled BB (freq domain)
subplot(2,2,4);
digital_Nyq = channel_Fs / 2;
f = abs(fftshift(fft(I_samples)));
freqs = linspace(-digital_Nyq, digital_Nyq, length(f));
semilogy(freqs, f);
hold on;
f = abs(fftshift(fft(Q_samples)));
freqs = linspace(-digital_Nyq, digital_Nyq, length(f));
semilogy(freqs, f);
hold off;
title('Baseband Sampled by ADC (Freq. Domain)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
legend('I','Q');
xlim([0, digital_Nyq]);
% the filter used in the FE
fvtool(I_debug.D);

%% modules and stuff
% an ideal filter which follows the filter profile provided in the
% MSi001 datasheet
function [s_out, transfer] = channel_selection_filter(F, IF_BW, t, s_in)
    Nyq = (1/2) * 1/(t(2) - t(1));
    % freq response profile of the IF mode of the filter (per datasheet)
    f = [F - 4*IF_BW, F - 3*IF_BW, F - 2*IF_BW, F - IF_BW, F - 0.5*IF_BW, ...
       F, F + 0.5*IF_BW, F + IF_BW, F + 2*IF_BW, F + 3*IF_BW, F + 4*IF_BW];
    H_db = [-100, -89, -71, -39, -0.5, 0, -0.5, -39, -71, -89, -100];
    % mirror for the negative frequencies
    f = [f-2*F, f];
    H_db = [H_db, H_db];
    % extend response up to nyquist
    f = [-Nyq, f, Nyq];
    H_db = [-100, H_db, -100];
    
    ft = fftshift(fft(s_in));
    % do filtering
    % interpolate out freq response of filter to be of same length as ft
    df = 2*Nyq / (length(ft)-1);
    f_interp = linspace(-Nyq, Nyq, length(ft));
    H_interp_db = interp1(f, H_db, f_interp);
    
    % now apply the filter
    H_interp = 10.^(H_interp_db/20); % from dB to scaling factors for volts
    ft = ft .* H_interp;
    
    % back to the time domain
    s_out = ifft(ifftshift(ft));
    
    % for visualisation
    transfer = struct('f', f_interp, 'H', H_interp);
end

% gain in dB, NF in dB, IIP3 in dBm
function [s_out, transfer] = LNA(gain, NF, IIP3, s_in)
    alpha_1 = 10^(gain/20);
    alpha_2 = 0;
    % alpha_3 = -4*G/(3*V_IP3^2) = -4*G/(3*IIP3)
    IIP3_watts = 1000 * 10^(IIP3/10);
    alpha_3 = -4*alpha_1/(3*IIP3_watts); %-1e10;
    s_out = alpha_1 * s_in + alpha_2 * s_in.^2 + alpha_3 * s_in.^3;
    
    % for display of input vs. output
    x = linspace(-100e-6, 100e-6, 1000);
    y = alpha_1 * x + alpha_2 * x.^2 + alpha_3 * x.^3;
    transfer = struct('x', x, 'y', y);
    % TODO: noise figure
end

% TODO: phase noise, I/Q mismatch
function [I_out, Q_out] = local_oscillator(F_LO, t)
    % ideal downconversion/mixing uses exp(-jwt)=cos(wt)-j*sin(wt)
    I_out = cos(2*pi*F_LO * t);
    Q_out = -sin(2*pi*F_LO * t);
end

% TODO: I/Q amplitude imbalance
function [I_out, Q_out] = mixer(s_in, I_LO, Q_LO)
    complex_LO = I_LO + j*Q_LO;
    I_out = real(s_in.*complex_LO);
    Q_out = imag(s_in.*complex_LO);
end

% this is an ideal ADC that has an instant aperture, no RC time constant,
% etc. TODO: make this a bit more realistic.
% Fs is ADC sample rate in Hz, BW is ADC analog input bandwidth in Hz,
% delay is for offsetting sampling and is in seconds.
function [s_out, t_out, debug] = ADC(Fs, BW, delay, s_in, t_in)
    input_Nyq = 0.5 * 1/(t_in(2) - t_in(1));
    [s_LP, D] = lowpass(s_in, BW, input_Nyq, 'Steepness', 0.95);
    t_out = t_in(1) : 1/Fs : t_in(end) - delay;
    t_out = t_out + delay;
    s_out = interp1(t_in, s_LP, t_out);
    debug = struct('s_LP', s_LP, 't', t_in, 'D', D);
end

function [s_out] = fft_lowpass(s_in, t_in, BW)
    input_Nyq = 0.5 * 1/(t_in(2) - t_in(1));
    ft = fft(s_in);
    df = ((length(ft)-1)*(t_in(2) - t_in(1)))^(-1);
    cutoff_index = floor(BW/df) + 1;
    ft(cutoff_index : end-cutoff_index) = 0;
    s_out = ifft(ft);
end



