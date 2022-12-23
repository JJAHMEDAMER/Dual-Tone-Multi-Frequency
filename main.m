function main()
    fs = 8000;
    time_sample = 0:(1/fs):0.1;

    [frq_low, frq_high] = sym2frq('0');

    tone_test = tone(frq_low, frq_high, time_sample);

    figure()
    plot(tone_test)
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

    
    % Noise
    noise = wgn(length(phone_num_tone),1,1);
    noise = transpose(noise);
    phone_num_tone_noise = phone_num_tone + noise;

    figure()
    plot(phone_num_tone_noise)
    audiowrite('phone_num_tone_noise.wav', phone_num_tone_noise, fs);
end