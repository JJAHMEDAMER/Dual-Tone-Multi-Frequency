function tone = tone(frq_low, frq_high, time_sample)
    tone1 = sin(2*pi*frq_low*time_sample);  
    tone2 = sin(2*pi*frq_high*time_sample);
    tone = tone1+tone2;
end