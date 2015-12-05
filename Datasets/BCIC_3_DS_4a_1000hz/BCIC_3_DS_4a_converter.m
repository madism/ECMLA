% Format the data file, then convert it with mat2arffmod (.mat->.arff)

% Init
clc
clear

% PS! Need to change this for each file
filename = 'BCIC_3_DS_4a_S5';
input_filename = 'BCIC_3_DS_4a_S5_converted';
output_filename = 'BCIC_3_DS_4a_S5_converted.arff';
disp('Loading file into memory...');
load(filename);

% Transpose matrices
disp('Changing data file to a proper format...');
start_pos = transpose(mrk.pos);
class_values = transpose(mrk.y);
[m,~] = size(start_pos);

% Convert from int16 to double
data_to_double = 0.1*double(cnt);

% Use only the following (16) EEG channels:
% AF3 AF4 F3 F4 FC5 FCz FC6 C5 C6 CP5 CPz CP6 P5 P6  O1  O2
%   7   8 16 20  33  36  39 51 57  69  72  75 88 94 112 114
data = data_to_double(:,[7 8 16 20 33 36 39 51 57 69 72 75 88 94 112 114]);

% For ii length sometimes needs to be changed to 1:m-1;
% Class values also need to be changed (in this case to 1 & 2)
for ii = 1:m
    if class_values(ii,1) == 1
          class_1{ii} = data(start_pos(ii,1):start_pos(ii+1,1),:);
    elseif class_values(ii,1) == 2
          class_2{ii} = data(start_pos(ii,1):start_pos(ii+1,1),:);
    end
end

% Remove empty cells
class_1_no_empty_cells = class_1(~cellfun(@isempty, class_1));
class_2_no_empty_cells = class_2(~cellfun(@isempty, class_2));

% Create trials for class_1
% Each column of trials_class_1 contains 3 subtrials each with the size of
% 1166 rows (3500/3=1166 ms) and 16 columns (16 prechosen EEG channels)
[~,n] = size(class_1_no_empty_cells);
for ii = 1:n
    trials_class_1{1,ii} = class_1_no_empty_cells{1,ii}(1:1166,:);
    trials_class_1{2,ii} = class_1_no_empty_cells{1,ii}(1167:2332,:); 
    trials_class_1{3,ii} = class_1_no_empty_cells{1,ii}(2333:3498,:); 
end

% Create trials for class_2
% Each column of trials_class_1 contains 3 subtrials each with the size of
% 1166 rows (3500/3 = 1166 ms) and 16 columns (16 prechosen EEG channels)
[~,n] = size(class_2_no_empty_cells);
for ii = 1:n
    trials_class_2{1,ii} = class_2_no_empty_cells{1,ii}(1:1166,:);
    trials_class_2{2,ii} = class_2_no_empty_cells{1,ii}(1167:2332,:); 
    trials_class_2{3,ii} = class_2_no_empty_cells{1,ii}(2333:3498,:); 
end

% Fast Fourier Transform
Fu = 120;                               % Max frequency used
Fs = 1000;                              % Sampling frequency
T = 1/Fs;                               % Sample time
L = 1166;                               % Length of signal
t = (0:L-1)*T;                          % Time vector   
NFFT = 2^nextpow2(L);                   % Next power of 2 from length of y
f = Fs/(Fs/Fu)*linspace(0,1,NFFT/2+1);  % 1000/120 = 25/3

% Perform Fast Fourier Transform for all subtrials of trials_class_1
[m,n] = size(trials_class_1);
for jj = 1:m
    for ii = 1:n
        y = detrend(trials_class_1{jj,ii});   % Detrend
        Y = abs(fft(y,NFFT)/L);             % Use abs() and correct length
        Y = Y(1:Fu,:);                      % Use only 120 Hz
        trials_class_1_fft{jj,ii} = Y;
    end
end

% Perform Fast Fourier Transform for all subtrials of trials_class_2
[m,n] = size(trials_class_2);
for jj = 1:m
    for ii = 1:n
        y = detrend(trials_class_2{jj,ii});   % Detrend
        Y = abs(fft(y,NFFT)/L);             % Use abs() and correct length
        Y = Y(1:Fu,:);                      % Use only 120 Hz
        trials_class_2_fft{jj,ii} = Y;
    end
end

% Find the mean values for each frequency subset of trials_class_1_fft
[m,n] = size(trials_class_1_fft);
for jj = 1:m
    for ii = 1:n
        trials_class_1_m{jj,ii}(1,:) = mean(trials_class_1_fft{jj,ii}(1:3,:));      %  1 -  3 Hz 
        trials_class_1_m{jj,ii}(2,:) = mean(trials_class_1_fft{jj,ii}(4:7,:));      %  4 -  7 Hz 
        trials_class_1_m{jj,ii}(3,:) = mean(trials_class_1_fft{jj,ii}(8:15,:));     %  8 - 15 Hz
        trials_class_1_m{jj,ii}(4,:) = mean(trials_class_1_fft{jj,ii}(16:31,:));    % 16 - 31 Hz
        trials_class_1_m{jj,ii}(5,:) = mean(trials_class_1_fft{jj,ii}(32:50,:));    % 32 - 50 Hz 
        trials_class_1_m{jj,ii}(6,:) = mean(trials_class_1_fft{jj,ii}(51:80,:));    % 51 - 80 Hz
        trials_class_1_m{jj,ii}(7,:) = mean(trials_class_1_fft{jj,ii}(81:Fu,:));    % 81 - Fu Hz
    end
end

% Find the mean values for each frequency subset of trials_class_2_fft
[m,n] = size(trials_class_2_fft);
for jj = 1:m
    for ii = 1:n
        trials_class_2_m{jj,ii}(1,:) = mean(trials_class_2_fft{jj,ii}(1:3,:));      %  1 -  3 Hz 
        trials_class_2_m{jj,ii}(2,:) = mean(trials_class_2_fft{jj,ii}(4:7,:));      %  4 -  7 Hz 
        trials_class_2_m{jj,ii}(3,:) = mean(trials_class_2_fft{jj,ii}(8:15,:));     %  8 - 15 Hz
        trials_class_2_m{jj,ii}(4,:) = mean(trials_class_2_fft{jj,ii}(16:31,:));    % 16 - 31 Hz
        trials_class_2_m{jj,ii}(5,:) = mean(trials_class_2_fft{jj,ii}(32:50,:));    % 32 - 50 Hz 
        trials_class_2_m{jj,ii}(6,:) = mean(trials_class_2_fft{jj,ii}(51:80,:));    % 51 - 80 Hz
        trials_class_2_m{jj,ii}(7,:) = mean(trials_class_2_fft{jj,ii}(81:Fu,:));    % 81 - Fu Hz
    end
end

% Transform each matrix from trials_class_1_m into a vector
[~,n] = size(trials_class_1_m);
for ii = 1:n
    class_1_for_weka(ii,:) = reshape(trials_class_1_m{1,ii}.',1,[]);
    class_1_for_weka(ii+n,:) = reshape(trials_class_1_m{2,ii}.',1,[]);
    class_1_for_weka(ii+2*n,:) = reshape(trials_class_1_m{3,ii}.',1,[]);
end

% Transform each matrix from trials_class_2_m into a vector
[~,n] = size(trials_class_2_m);
for ii = 1:n
    class_2_for_weka(ii,:) = reshape(trials_class_2_m{1,ii}.',1,[]);
    class_2_for_weka(ii+n,:) = reshape(trials_class_2_m{2,ii}.',1,[]);
    class_2_for_weka(ii+2*n,:) = reshape(trials_class_2_m{3,ii}.',1,[]);
end

% Add class values (in this case 0) to the final column of class_1_for_weka 
% Also class_1 is renamed into data_class0
data_class0 = [class_1_for_weka zeros(size(class_1_for_weka,1),1)];

% Add class values (in this case 1) to the final column of class_2_for_weka 
% Also class_2 is renamed into data_class1
data_class1 = [class_2_for_weka ones(size(class_2_for_weka,1),1)];

% Merge data_class0 and data_class1 into a single matrix
data_merged = [data_class0;data_class1];

% Shuffle data_merged by using random permutations
data_merged_shuffled = data_merged(randperm(size(data_merged,1)),:);

% Save as .mat file
save(input_filename, 'data_merged_shuffled');

% Call mat2arffmod
disp('Finished changing data file to a proper format.');
disp('Calling mat2arffmod for .mat to .arff file conversion...');
mat2arffmod(input_filename, output_filename, 'classes');