%% Body Fat Estimation LABORVERSUCH HSM 
% This example illustrates how a function fitting neural network can estimate
% body fat percentage based on anatomical measurements.

%   Copyright 2010-2016 The MathWorks, Inc.

%% The Problem: Estimate Body Fat Percentage
% In this example we attempt to build a neural network that can estimate
% the body fat percentage of a person described by thirteen
% physical attributes:
%
% * Age (years)
% * Weight (lbs)
% * Height (inches)
% * Neck circumference (cm)
% * Chest circumference (cm)
% * Abdomen 2 circumference (cm)
% * Hip circumference (cm)
% * Thigh circumference (cm)
% * Knee circumference (cm)
% * Ankle circumference (cm)
% * Biceps (extended) circumference (cm)
% * Forearm circumference (cm)
% * Wrist circumference (cm)
%
% This is an example of a fitting problem, where inputs are matched up to
% associated target outputs, and we would like to create a neural network
% which not only estimates the known targets given known inputs, but can
% generalize to accurately estimate outputs for inputs that were not
% used to design the solution.
%
%% Why Neural Networks?
% Neural networks are very good at function fit problems.  A neural network
% with enough elements (called neurons) can fit any data with arbitrary
% accuracy. They are particularly well suited for addressing nonlinear
% problems. Given the nonlinear nature of real world phenomena, like
% like body fat accretion, neural networks are a good candidate for solving
% the problem.
%
% The thirteen physical attributes will act as inputs to a neural
% network, and the body fat percentage will be the target.
%
% The network will be designed by using the anatomical quantities of bodies
% whose body fat percentage is already known to train it to produce
% the target valuations.
%
%% Preparing the Data
% Data for function fitting problems are set up for a neural network by
% organizing the data into two matrices, the input matrix X and the target
% matrix T.
%
% Each ith column of the input matrix will have thirteen elements
% representing a body with known body fat percentage.
% 
% Each corresponding column of the target matrix will have one element,
% representing the body fat percentage.
%
% Here such a dataset is loaded.

[x,t] = bodyfat_dataset;

%%
% We can view the sizes of inputs X and targets T.
%
% Note that both X and T have 252 columns. These represent 252 physiques
% (inputs) and associated body fat percentages (targets).
%
% The input matrix X has thirteen rows, for the thirteen attributes. The
% target matrix T has only one row, as for each example we only have one
% desired output, the body fat percentage.

size(x)
size(t)

%% Fitting a Function with a Neural Network
% The next step is to create a neural network that will learn to estimate
% body fat percentages.
%
% Since the neural network starts with random initial weights, the results
% of this example will differ slightly every time it is run. The random seed
% is set to avoid this randomness. However this is not necessary for your
% own applications.

% setdemorandstream(491218382)

%%
% Two-layer (i.e. one-hidden-layer) feed forward neural networks can fit
% any input-output relationship given enough neurons in the hidden layer.
% Layers which are not output layers are called hidden layers.
%
% We will try a single hidden layer of 15 neurons for this example. In
% general, more difficult problems require more neurons, and perhaps more
% layers.  Simpler problems require fewer neurons.
%
% The input and output have sizes of 0 because the network has not yet
% been configured to match our input and target data.  This will happen
% when the network is trained.

net = fitnet(15);
view(net)

%%
% Now the network is ready to be trained. The samples are automatically
% divided into training, validation and test sets. The training set is
% used to teach the network. Training continues as long as the network
% continues improving on the validation set. The test set provides a
% completely independent measure of network accuracy.
%
% The NN Training Tool shows the network being trained and the algorithms
% used to train it.  It also displays the training state during training
% and the criteria which stopped training will be highlighted in green.
%
% The buttons at the bottom  open useful plots which can be opened during
% and after training.  Links next to the algorithm names and plot buttons
% open documentation on those subjects.

[net,tr] = train(net,x,t);
nntraintool

%%
% To see how the network's performance improved during training, either
% click the "Performance" button in the training tool, or call PLOTPERFORM.
%
% Performance is measured in terms of mean squared error, and shown in
% log scale.  It rapidly decreased as the network was trained.
%
% Performance is shown for each of the training, validation and test sets.
% The version of the network that did best on the validation set is
% was after training.

plotperform(tr)

%% Testing the Neural Network
% The mean squared error of the trained neural network can now be measured
% with respect to the testing samples. This will give us a sense of how
% well the network will do when applied to data from the real world.

testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY = net(testX);

perf = mse(net,testT,testY)

%%
% Another measure of how well the neural network has fit the data is the
% regression plot.  Here the regression is plotted across all samples.
%
% The regression plot shows the actual network outputs plotted in terms of
% the associated target values.  If the network has learned to fit the
% data well, the linear fit to this output-target relationship should
% closely intersect the bottom-left and top-right corners of the plot.
%
% If this is not the case then further training, or training a network
% with more hidden neurons, would be advisable.

y = net(x);
figure(3)
plotregression(t,y)
%%
% Another third measure of how well the neural network has fit data is the
% error histogram.  This shows how the error sizes are distributed. 
% Typically most errors are near zero, with very few errors far from that.

e = t - y;
figure(5)
ploterrhist(e)

%%
% This example illustrated how to design a neural network that estimates
% the body fat percentage from physical characteristics.
%
% Explore other examples and the documentation for more insight into neural
% networks and their applications.

%% Aufgaben
% B. WIR 8.12.2017 
%
%% 1 Plotten Sie die Regressionsgeraden getrennt für
% Trainings-, Test- und Validierungsdaten

figure(10)
plotregression(t(:,tr.trainInd),y(:,tr.trainInd),'TRAIN',t(:,tr.testInd),y(:,tr.testInd),'TEST',t(:,tr.valInd),y(:,tr.valInd),'VALID')

%% 2 Trainieren Sie das Netz 10 mal und plotten Sie die zugehörigen 
% Korrelationskoeffizienten und die mse-Werte 
nntraintool('close'); 
x = x(:,1:40); % später 20 Datensätze für den Lernvorgang
t = t(:,1:40);

N=10; % anzahl Experimente
R_werte = zeros(3,N);
mse_werte = zeros(3,N); % Train-,Test, Validierungsfehler

for i=1:N;
    net = fitnet(15); %neues Netz anlegen
    % net = fitnet(5);
    [net,tr] = train(net,x,t);
    
    mse_werte(1,i) = mse(t(:,tr.trainInd),y(:,tr.trainInd));
    mse_werte(2,i) = mse(t(:,tr.testInd),y(:,tr.testInd));
    mse_werte(3,i) = mse(t(:,tr.valInd),y(:,tr.valInd));
    
    [r,m,b] = regression(t(:,tr.trainInd),y(:,tr.trainInd))
    R_werte(1,i) = r;
    [r,m,b] = regression(t(:,tr.testInd),y(:,tr.testInd))
    R_werte(2,i) = r;
    [r,m,b] = regression(t(:,tr.valInd),y(:,tr.valInd))
    R_werte(3,i) = r;
    
    
    figure(21);
    plotperform(tr);
end   
    figure(22);
    plot( mse_werte(1,:)); hold on;  plot( mse_werte(2,:));plot( mse_werte(3,:));
    legend('Train', 'Test', 'Valid'); title('MSE'); hold  off; 
    
    figure(23);
    plot( R_werte(1,:)); hold on;  plot( R_werte(2,:));plot( R_werte(3,:));
    legend('Train', 'Test', 'Valid'); title('R'); hold off; xlabel('Experiment')
    
% FAZIT: Je nach Initialisierung ist das Netz unterschiedlich gut 

%% 2 B Reduzieren Sie die die verfügbaren auf 40 Datensätze  und wiederholen 3A 
%

%%
% %% 3 A Optinieren Sie die Netz Topologie (Anzahl Neuronen in der
% %  verdeckten Schicht anhand vom Korrelationskoeffizienten R 
% % x = x+ 0.02 *randn(size(x))* mean(mean(x)); %später Rauschen dazu
% 
%     ANZ_N = 15;
%     R_werte_mittel = ones(3,ANZ_N);
%         
%     for j = ANZ_N:-1:1
%         N = 10 % Experimente
%         for i=1:N;
%             net = fitnet(j); %neues Netz anlegen
%            [net,tr] = train(net,x,t);
% 
%            
%             [r,m,b] = regression(t(:,tr.trainInd),y(:,tr.trainInd))
%             R_werte_mittel(1,j) = R_werte_mittel(1,j)+ r;
%             [r,m,b] = regression(t(:,tr.testInd),y(:,tr.testInd))
%             R_werte_mittel(2,j) = R_werte_mittel(2,j)+ r;
%             [r,m,b] = regression(t(:,tr.valInd),y(:,tr.valInd))
%             R_werte_mittel(3,j) = R_werte_mittel(3,j)+ r;
% 
%         end   
%         R_werte_mittel(:,j)= R_werte_mittel(:,j)/N;
%     end    
%     figure(14);
%     plot( R_werte_mittel(1,:)); hold on;  plot( R_werte_mittel(2,:));plot( R_werte_mittel(3,:));
%     legend('Train', 'Test', 'Valid'); title('Optimierung Netzdimension'); hold off;
%     % FAZIT: 2 Neuronen genügen in der verdeckten Schicht R = ca 0.9 +-0.3
%     % PC mit 3 HAupkomponenten - > R > o.9+-0.3 bringt wenig ; die
%     % Verdeckte schicht kann das was PCA macht, mit PCA genügt 1 Neuron in VS 
    


%% 4 Nutzen Sie PCA zur Datenreduction
    
[COEFF, SCORE, LATENT] = pca(x);
figure(20) 
subplot(1,3,1);imagesc(COEFF); title('PCA-COEFF')
subplot(1,3,2);imagesc(SCORE); title('PCA-SCORE')
subplot(1,3,3);plot(LATENT);title('PCA-Eigenwerte')


[x_n_pca,settings_pca] = processpca(x,'maxfrac',0.001); % 
x = x_n_pca;
size(x)

N = 10 % N Experimente
for i=1:N;
    net = fitnet(1); %neues Netz anlegen
    [net,tr] = train(net,x,t);
    
    mse_werte(1,i) = mse(t(:,tr.trainInd),y(:,tr.trainInd));
    mse_werte(2,i) = mse(t(:,tr.testInd),y(:,tr.testInd));
    mse_werte(3,i) = mse(t(:,tr.valInd),y(:,tr.valInd));
    
    [r,m,b] = regression(t(:,tr.trainInd),y(:,tr.trainInd))
    R_werte(1,i) = r;
    [r,m,b] = regression(t(:,tr.testInd),y(:,tr.testInd))
    R_werte(2,i) = r;
    [r,m,b] = regression(t(:,tr.valInd),y(:,tr.valInd))
    R_werte(3,i) = r;
    
    
    figure(14);
    plotperform(tr);
end   
    figure(15);
    plot( mse_werte(1,:)); hold on;  plot( mse_werte(2,:));plot( mse_werte(3,:));
    legend('Train', 'Test', 'Valid'); title('MSE'); hold  off; 
    
    figure(16);
    plot( R_werte(1,:)); hold on;  plot( R_werte(2,:));plot( R_werte(3,:));
    legend('Train', 'Test', 'Valid'); title('R_{PCA}'); hold off; xlabel('Experiment');
    
view(net)
% 
% 
% 
%     % FAZIT: 2 Neuronen genügen in der verdeckten Schicht R = ca 0.9 +-0.3
%     % PC mit 3 HAupkomponenten - > R > o.9+-0.3 bringt wenig ; die
%     % Verdeckte schicht kann das was PCA macht, mit PCA genügt 1 Neuron in VS 
    