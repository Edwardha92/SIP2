function [output] = classify(feature_vector)
    output = -1;
    if size(feature_vector,1) ~= 26
%         sprintf('feature vector does not match the required size');
        return;
    end
    net = load('bestNet100.mat');
    output = net.bestNet100(feature_vector);
end

