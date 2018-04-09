function output = core (input)

%     input = [0 0 1 0 0 0 0 0 0 0 0];

    b = [1 0 1];
    a = [1];

    output = filter(b,a, input);
end