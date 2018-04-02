%% Lineares NN
%
%  Trainieren Sie ein Lineares NN für die Trainingsdaten:
% HSM, B. Wir 7.10.2011 
clear all; close all;


X = [ -0.5 -0.5 +0.3 -0.1 ; ...
      -0.5 +0.5 -0.5 +1.0 ]; 
Y = [1 1 0 0 ];
plotpv(X,Y);

%% Trainieren
% Bias ergänzen

% X =  [ X; 
%        1 1 1 1]
X = [X;
      ones(1,size(X,2))]
% Gewichte
w = [ 0 0 0];
%w = 0.2*randn(1,3)
% Lernrate
 mu = sum(sum(X.^2))/(length(Y)*2)

% Training (inkrementell)
for epoche = 1:10
    for i = 1: length(Y); % 
        a = w * X(:,i);
        e = Y(i) - a;
        w = w + mu * e * X(:,i)'; 
    end
    % Klassifikationsgerade
%     w(1)X(1) + w(2)X(2) + w(3)*1 = 0.5
%     X(2) = (0.5 -  w(1)X(1) - w(3))/w(2)
    X1 = [-1 :0.1:1];
    X2 = (0.5 - w(1)* X1  - w(3))/w(2);
    hold on
    plot(X1,X2,'g');
    hold off
    drawnow
end
hold on
plot(X1,X2,'r');
hold off

