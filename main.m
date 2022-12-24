function main()
    close all;
    fs = 8000;
    time_sample = 0:(1/fs):0.1;
    
    [frq_low, frq_high] = sym2frq('0');

    tone_test = tone(frq_low, frq_high, time_sample);
    disp(tone_test)

    figure()
    plot(tone_test)
%     title('Tone Test')
%     xlabel('Time Sample')
%     ylabel('Frequency')
%     grid on;
    audiowrite('tone.wav',tone_test,fs);

    phone_num = '01548754792';
    
    % Guard Tone
    time_sample_guard = 0:(1/fs):0.02;
    guard_tone = tone(0, 0, time_sample_guard);

    % Phone Tone
    phone_num_tone = [];
    for i = 1:length(phone_num)
        [frq_low, frq_high] = sym2frq(phone_num(i));
        ton = tone(frq_low, frq_high, time_sample);
        phone_num_tone = [phone_num_tone guard_tone ton];
    end
    
    figure()
    plot(phone_num_tone)
    audiowrite('phone_num_tone.wav',phone_num_tone,fs);

%%%%%%%%%% Noise %%%%%%%%%%
    
    % noise = wgn(length(phone_num_tone),1,1);
    % noise = transpose(noise);
    
    noise = sqrt(0.1)*randn(1,length(phone_num_tone));
    phone_num_tone_noise = phone_num_tone + noise;

    figure()
    plot(phone_num_tone_noise)
    audiowrite('phone_num_tone_noise.wav', phone_num_tone_noise, fs);
    
%%%%%%%%%% FTT %%%%%%%%%%
    
    phone_num_tone_noise_FFT = abs(fft(phone_num_tone_noise));
    figure()
    plot( phone_num_tone_noise_FFT)
    
%%%%%%%%%% Sliding Window %%%%%%%%%%

window = [16 64 256 1024 4096];
width = window/2; % 50%
nff = 2^14;

% for i = 1:length(window)
%     rectangle_phone_num_tone = rectwin(window(i));
%     figure()
%     base_name = 'project/rect';
%     num = int2str(i);
%     ext = '.png';
%     spectrogram(phone_num_tone, rectangle_phone_num_tone, width(i), nff, fs);
%     saveas(gcf,strcat(base_name, num, ext))
% end
% 
% for i = 1:length(window)
%     blackman_phone_num_tone = blackman(window(i));
%     figure()
%     base_name = 'project/blackman';
%     num = int2str(i);
%     ext = '.png';
%     spectrogram(phone_num_tone, blackman_phone_num_tone, width(i), nff, fs);
%     saveas(gcf,strcat(base_name, num, ext))
% end

% fontSize = 12;
% figure(1)
% for i = 1:length(window)
%     rectangle_phone_num_tone = rectwin(window(i));
%     subplot(2,3,i)
%     spectrogram(phone_num_tone, rectangle_phone_num_tone, width(i), nff, fs);
%     title(strcat('Window: ', int2str(window(i))), 'FontSize', fontSize) 
% end
% saveas(gcf,'rect.png')
% 
% 
% figure(2)
% for i = 1:length(window)
%     blackman_phone_num_tone = blackman(window(i));
%     subplot(2,3,i)
%     spectrogram(phone_num_tone, blackman_phone_num_tone, width(i), nff, fs);
%     title(strcat('Window: ', int2str(window(i))), 'FontSize', fontSize) 
% end
% saveas(gcf,'blackman.png')


%%%%%%%%%% GET PHONE NUMBER %%%%%%%%%%%%
number_of_samples = (length(time_sample)+length(time_sample_guard));

start = 1;
ended = number_of_samples;

f = [697 770 852 941 1209 1336 1477 1633];
freq_indices = round(f/fs*number_of_samples) + 1; 

figure()
for i = 1:length(phone_num)
    dft_data = goertzel(phone_num_tone(start:ended), freq_indices);
    subplot(3,4,i)
    stem(f, abs(dft_data))
    
    start = start + 962;
    ended = ended + 962;
end

end