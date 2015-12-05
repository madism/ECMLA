%% Draw a heatmap for the results table

% Clear
clc
clear

% Load the values
load('results_tables.mat')

% Choose the metric (ca,time,fscore)
% NB! You need to change this for each performance metric!
%metric=ca;
%metric=time;
%metric=fscore;
%metric=avg_ca;
%metric=avg_time;
metric=avg_fscore;

% Name the tick labels
algorithm_xticklabels = {'AB';'KNN';'C45';'LRM';'MPN';'NB';'RF';'RFN';'MCP';'SVM'};
%algorithm_yticklabels = {'S1';'S2';'S3';'S4';'S5';'S6';'S7';'S8';'S9';'S10'};
%algorithm_yticklabels = {'Avg. CA'};
%algorithm_yticklabels = {'Avg. Time'};
algorithm_yticklabels = {'Avg. F-score'};

% Draw the matrix
disp('Drawing a heatmap for the results table...');
imagesc(metric);

% Change the colormap to greyscale 
colormap(flipud(gray));
% colormap(flipud(colormap)); Use this when you want to invert the colors

% Set X tick values
set(gca,'XTickLabel',algorithm_xticklabels);
set(gca,'xaxisLocation','top');
set(gca,'FontSize',20);
% Set Y tick values
set(gca,'YTickLabel',algorithm_yticklabels);
% Draw matrix values on figure
% Create strings from the matrix values
textStrings = num2str(metric(:),'%0.2f');  
% Remove any space padding
textStrings = strtrim(cellstr(textStrings));  
% Create x and y coordinates for the strings
[x,y] = meshgrid(1:10); 
% Plot the strings
hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center', 'FontSize',20);
% Get the middle value of the color range
midValue = mean(get(gca,'CLim'));   
% Choose white or black for the text color of the strings
textColors = repmat(metric(:) > midValue,1,3);
% Change the text colors
set(hStrings,{'Color'},num2cell(textColors,2));  
disp('Done.');