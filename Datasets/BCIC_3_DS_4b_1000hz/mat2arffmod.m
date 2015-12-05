function [ success_value ] = mat2arffmod( mat_filename, arff_filename, relation)
% Modified version of the MAT2ARFF function 
% which converts .mat files into .arff 
% for use with the WEKA3 datamining toolkit. 
% The .mat files have to contain a two dimensional feature matrix. 
% 
% MAT2ARFF author:
% (c) Jens Bandener 2011 [Jens.Bandener@ruhr-uni-bochum.de]
%                                     script version v0.2 (02-dec-2011)

fid1 = fopen(arff_filename, 'r');
if fid1 == -1 
    emptyFile = 1;
else
    emptyFile = 0;
	fclose(fid1);
end

fid = fopen(arff_filename, 'a+');
load(mat_filename);
feature_matrix = [data_merged_shuffled];

if emptyFile == 1
	% Display status messages in MATLAB
    disp('Creating the .ARFF file...');
    disp('Generating .ARFF file header...');
	% Add some comments to the ARFF file
    fprintf(fid, '%% %s \n', 'Created with a modified version of the mat2arff script');
    fprintf(fid, '%% Created on: %s \n\n', datestr(now));
    fprintf(fid, '@RELATION %s \n', relation);
    % Create ATTRIBUTE entries for each variable
    if(length(size(feature_matrix)) == 2)
        for x=1:size(feature_matrix,2)-1
            string_value = sprintf('var%i',x);
            fprintf(fid, '@ATTRIBUTE %s NUMERIC\n', string_value);
        end
	% Exit when feature matrix has an incorrect format
    else
        disp('Feature matrix (feature_matrix) has an incorrect format. Exiting.');
        success_value = 0;
        close;
    end
    fprintf(fid, '@ATTRIBUTE class {%s} \n', '0,1');
    fprintf(fid, '@DATA \n');
	% Display status messages in MATLAB
    disp('Writing data from .MAT file to .ARFF file...');
	disp('Please wait, this might take a while...');
    % Append dataset for each feature-set
	% Iterate over the first half of data set
    for x1=1:size(feature_matrix,1)
        for y1=1:size(feature_matrix,2) 
            fprintf(fid, '%d,', feature_matrix(x1,y1));
        end
		% New-line and class value (class0 or '0') added at the end of each dataset
    	fprintf(fid, '\n');
    end
 	% Display status message in MATLAB
	disp('Done.');
	fclose(fid);
else
    disp('ERROR! Output file is not empty or already exists!');
	disp('Skipping .mat to .arff file conversion...');
end