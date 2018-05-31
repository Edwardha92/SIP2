input = [1 0 0  1 0 0 1 0 0 1 0 0 1];

output = calculate_akf(input);

if size(output(output > 0.001),2) == 5
    sprintf("OK")
end

plot(output);