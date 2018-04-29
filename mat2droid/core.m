function output = core (input)

    b = [1 0 1];
    a = [1];

    output = filter(b,a, input);
end