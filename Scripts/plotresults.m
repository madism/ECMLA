% Plots results for each model/algorithm

%% Set up folder path
clc
clear
folder_path = './Results/BCIC_4_DS_1/1g/';
long_title = 'BCI Competition III - Dataset 4a - Subject 2';
clustergram_title = ' - Clustergram';
corr_matrix_title = ' - Pearson Correlation Matrix'; 

%% AdaBoostM1
% Load model_1 results from .ARFF
model_1 = weka2matlab(loadARFF(strcat(folder_path,'AdaBoostM1.arff')));
% Find the size for all models (they are all the same size)
% n = Rows in data; 
% f = Columns in data;
[n, f] = size(model_1);
% Extract model_1 predictions
model_1_predictions = model_1(:,f-1);
% Add model_1 predictions to algorithm_predictions (column 1)
disp('Adding predictions for AdaBoostM1...');
algorithm_predictions(:, 1) = model_1_predictions;

%% IBk
% Load model_2 results from .ARFF
model_2 = weka2matlab(loadARFF(strcat(folder_path,'IBk.arff')));
% Extract model_2 predictions
model_2_predictions = model_2(:,f-1);
% Add model_2 predictions to algorithm_predictions (column 2)
disp('Adding predictions for IBk...');
algorithm_predictions(:, 2) = model_2_predictions;

%% J48
% Load model_3 results from .ARFF
model_3 = weka2matlab(loadARFF(strcat(folder_path,'J48.arff')));
% Extract model_3 predictions
model_3_predictions = model_3(:,f-1);
% Add model_3 predictions to algorithm_predictions (column 3)
disp('Adding predictions for J48...');
algorithm_predictions(:, 3) = model_3_predictions;

%% Logistic
% Load model_4 results from .ARFF
model_4 = weka2matlab(loadARFF(strcat(folder_path,'Logistic.arff')));
% Extract model_4 predictions
model_4_predictions = model_4(:,f-1);
% Add model_4 predictions to algorithm_predictions (column 4)
disp('Adding predictions for Logistic...');
algorithm_predictions(:, 4) = model_4_predictions;

%% MultilayerPerceptron
% Load model_5 results from .ARFF
model_5 = weka2matlab(loadARFF(strcat(folder_path,'MultilayerPerceptron.arff')));
% Extract model_5 predictions
model_5_predictions = model_5(:,f-1);
% Add model_5 predictions to algorithm_predictions (column 5)
disp('Adding predictions for MultilayerPerceptron...');
algorithm_predictions(:, 5) = model_5_predictions;
    
%% NaiveBayes
% Load model_6 results from .ARFF
model_6 = weka2matlab(loadARFF(strcat(folder_path,'NaiveBayes.arff')));
% Extract model_6 predictions
model_6_predictions = model_6(:,f-1);
% Add model_6 predictions to algorithm_predictions (column 6)
disp('Adding predictions for NaiveBayes...');
algorithm_predictions(:, 6) = model_6_predictions;

%% RandomForest
% Load model_7 results from .ARFF
model_7 = weka2matlab(loadARFF(strcat(folder_path,'RandomForest.arff')));
% Extract model_7 predictions
model_7_predictions = model_7(:,f-1);
% Add model_7 predictions to algorithm_predictions (column 7)
disp('Adding predictions for RandomForest...');
algorithm_predictions(:, 7) = model_7_predictions;

%% RBFNetwork
% Load model_8 results from .ARFF
model_8 = weka2matlab(loadARFF(strcat(folder_path,'RBFNetwork.arff')));
% Extract model_8 predictions
model_8_predictions = model_8(:,f-1);
% Add model_8 predictions to algorithm_predictions (column 8)
disp('Adding predictions for RBFNetwork...');
algorithm_predictions(:, 8) = model_8_predictions;

%% SimpleCart
% Load model_9 results from .ARFF
model_9 = weka2matlab(loadARFF(strcat(folder_path,'SimpleCart.arff')));
% Extract model_9 predictions
model_9_predictions = model_9(:,f-1);
% Add model_9 predictions to algorithm_predictions (column 9)
disp('Adding predictions for SimpleCart...');
algorithm_predictions(:, 9) = model_9_predictions;

%% SMO
% Load model_10 results from .ARFF
model_10 = weka2matlab(loadARFF(strcat(folder_path,'SMO.arff')));
% Extract model_10 predictions
model_10_predictions = model_10(:,f-1);
% Add model_10 predictions to algorithm_predictions (column 10)
disp('Adding predictions for SMO...');
algorithm_predictions(:, 10) = model_10_predictions;

%% The correct predictions
% Extract the correct predictions from model_10
correct_predictions = model_10(:,f);

%% Create a new matrix that has FalseFalse,FalseTrue,TrueFalse,TrueTrue values
predictions_4_values = algorithm_predictions;
for ii = 1:size(predictions_4_values,1) 
    for jj = 1:size(predictions_4_values,2)
		% True Negative (TN)
        % The correct prediction is 0 and the algorithm predicts 0 (Color: Dark Blue / "Green Vogue")
        if (correct_predictions(ii,1) == 0) && (algorithm_predictions(ii,jj) == 0)
            predictions_4_values(ii,jj) = -1;
            %predictions_4_values(ii,jj) = -1;
            %predictions_4_values(ii,jj) = -1;
		% False Negative (FN)
        % The correct prediction is 0 and the algorithm predicts 1 (Color: Light Blue / "Morning Glory")
        elseif (correct_predictions(ii,1) == 0) && (algorithm_predictions(ii,jj) == 1) 
            predictions_4_values(ii,jj) = 1;
            %predictions_4_values(ii,jj) = 0;
            %predictions_4_values(ii,jj) = -0.3333;
		% False Positive (FP)
        % The correct prediction is 1 and the algorithm predicts 0 (Color: Light Orange / "Tacao")
        elseif (correct_predictions(ii,1) == 1) && (algorithm_predictions(ii,jj) == 0) 
            predictions_4_values(ii,jj) = 1;
            %predictions_4_values(ii,jj) = 0;
            %predictions_4_values(ii,jj) = 0.3333;
		% True Positive (TP)
        % The correct prediction is 1 and the algorithm predicts 1 (Color: Dark Red / "Bordeaux")
        elseif (correct_predictions(ii,1) == 1) && (algorithm_predictions(ii,jj) == 1) 
            predictions_4_values(ii,jj) = -1;
            %predictions_4_values(ii,jj) = 1;
            %predictions_4_values(ii,jj) = 1;
        end
    end
end

%% Create a clustergram 
disp('Creating a clustergram...');
algorithm_xticklabels = {
    'AB (0.544)';
    'KNN (0.539)';
    'C45 (0.551)';
    'LRM (0.647)';
    'MPN (0.590)';
    'NB (0.508)';
    'RF (0.561)';
    'RFN (0.502)';
    'MCP (0.553)';
    'SVM (0.631)'
};
% clustergram(Data,Do not cluster, Rows, Change colormap to, Red&Blue,
% Order by nearest leaves, False)
CGobj = clustergram(predictions_4_values,'Cluster','row','Colormap',redgreencmap, ... 
    'OptimalLeafOrder',false,'ColumnLabels',algorithm_xticklabels);
% Add title for clustergram
%addTitle(CGobj,strcat(long_title,clustergram_title));
disp('Done.');

%% Compute Pearson's linear correlation coeficcient
disp('Computing Pearsons linear correlation coeficcient...');
corr_pearson = corr(algorithm_predictions);
% Draw the correlation matrix
imagesc(corr_pearson);
% Add a title for correlation matrix
%title(strcat(long_title,corr_matrix_title)); 
% Set X tick values
set(gca,'XTickLabel',algorithm_xticklabels);
% Move X tick values to the top
set(gca,'xaxisLocation','top');
% Set Y tick values
set(gca,'YTickLabel',algorithm_xticklabels);
% Draw matrix values on figure
% Create strings from the matrix values
textStrings = num2str(corr_pearson(:),'%0.2f');  
% Remove any space padding
textStrings = strtrim(cellstr(textStrings));  
% Create x and y coordinates for the strings
[x,y] = meshgrid(1:10); 
% Plot the strings
hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
% Get the middle value of the color range
midValue = mean(get(gca,'CLim'));   
% Choose white or black for the text color of the strings
textColors = repmat(corr_pearson(:) < midValue,1,3);
% Change the text colors
set(hStrings,{'Color'},num2cell(textColors,2));  
disp('Done.');

% %% Compute Pearson's linear correlation coeficcient over all subjects
% % Load all the correlation matrices into memory
% load('./Results/Corr_average_over_all_subjects/S01.mat');
% corr_averages_1 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S02.mat');
% corr_averages_2 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S03.mat');
% corr_averages_3 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S04.mat');
% corr_averages_4 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S05.mat');
% corr_averages_5 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S06.mat');
% corr_averages_6 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S07.mat');
% corr_averages_7 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S08.mat');
% corr_averages_8 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S09.mat');
% corr_averages_9 = corr_pearson;
% load('./Results/Corr_average_over_all_subjects/S10.mat');
% corr_averages_10 = corr_pearson;
% % Find the mean value for the Pearson correlation matrices
% corr_averages = (corr_averages_1+corr_averages_2+corr_averages_3+ ...
%     corr_averages_4+corr_averages_5+corr_averages_6+corr_averages_7+ ...
%     corr_averages_8+corr_averages_9+corr_averages_10)/10;
% % Draw the correlation matrix
% imagesc(corr_averages);
% % Set title
% %title('Average Pearson correlation matrix over all subjects'); 
% % Set X tick values (in brackets is the average F-score for each algorithm) 
% corr_avg_xticklabels = {
%     'AB (0.601)';
%     'KNN (0.555)' ;
%     'C45 (0.555)';
%     'LRM (0.662)';
%     'MPN (0.625)';
%     'NB (0.542)';
%     'RF (0.613)';
%     'RFN (0.567)';
%     'MCP (0.567)';
%     'SVM (0.650)'
% };
% set(gca,'XTickLabel',corr_avg_xticklabels);
% % Move X tick values to the top
% set(gca,'xaxisLocation','top');
% % Set Y tick values
% set(gca,'YTickLabel',corr_avg_xticklabels);
% % Draw matrix values on figure
% % Create strings from the matrix values
% textStrings = num2str(corr_averages(:),'%0.2f');  
% %% Remove any space padding
% textStrings = strtrim(cellstr(textStrings));  
% %% Create x and y coordinates for the strings
% [x,y] = meshgrid(1:10); 
% %% Plot the strings
% hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
% %% Get the middle value of the color range
% midValue = mean(get(gca,'CLim'));   
% %% Choose white or black for the text color of the strings
% textColors = repmat(corr_averages(:) < midValue,1,3);
% %% Change the text colors
% set(hStrings,{'Color'},num2cell(textColors,2));  
% disp('Done.');