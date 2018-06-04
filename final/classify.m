function [output] = classify(feature_vector)
%CLASSIFTY will return a real values indicating the probability of the 
%feauture_vector corresponds to an apnoe event or not.
%Output value of 1 indicates 100% certainty of apnoe, a 0 respectivally 0% 
%apnoe or 100% NO apnoe.
%The feature vector must be a 1x26 element vector. The first 13 values must
%be the maximum values, the last elements contain the corresponding
%indeces [[1x13 = max values] [1x13 = indeces]]. If the feature vector does
%not match the required length, the classification returns -1 indicating an
%error.
    output = -1;
    if size(feature_vector,1) ~= 26
%         sprintf('feature vector does not match the required size');
        return;
    end
        
    net = load('bestNet100.mat');
    output = net.bestNet100(feature_vector);
end

