function [low_frq, high_frq] = sym2frq(symbol)

symbol = double(symbol);

x= ['1' '2' '3' 'A' '4' '5' '6' 'B' '7' '8' '9' 'C' '*' '0' '#' 'D'];

frq = [ double(x);
        697 697 697 697 770 770 770 770 852 852 852 852 941 941 941 941;
        1209 1336 1477 1633 1209 1336 1477 1633 1209 1336 1477 1633 1209 1336 1477 1633;
];

for i = 1:length(frq)
    if frq(1,i) == symbol
        low_frq = frq(2,i);
        high_frq = frq(3,i);
    end
end



 