function main()
    fs = 8000;
    time_sample = 0:(1/fs):0.1;

    [frq_low, frq_high] = sym2frq('0');

    tone_test = tone(frq_low, frq_high, time_sample);

    figure()
    plot(tone_test)
    audiowrite('tone.wav',tone_test,fs);

    
end