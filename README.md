## Comparison of machine learning algorithms

### Running the code:

* Clone the project from GitHub
* Start Matlab
* Inside Matlab, move to the directory you just downloaded (cMLA-GitRepo)
* In order to preprocess and convert a dataset for weka, move to a dataset directory and run (F9) the converter 
(For example: Move to \Datasets\BCIC_3_DS_4a_100hz\, run BCIC_3_DS_4a_converter.m)
* To plot the results (Clustergram and Pearson correlation matrix), run plotresults_new.m
* To plot the average pearson correlation matrix, in plotresults_new.m, remove the comments symbol from lines 187-248
* To add titles to the plots, in plotresults_new.m, remove the comments symbol from lines 156,165,216 and manually rename the title in line 7 accordingly.

### Changelog:

#### 05.12.2015 - 
* Major overhaul (new graphs and results)

#### 13.05.2015 - Updated the graphs
* Clustergrams now only show True Positive and True Negative values (false values are white).
* Minor bugfixes and code changes

##### 27.04.2015 - New datasets

* Instead of using a single EEG dataset we're now using 3 datasets with a total of 10 subjects (basically 10 "datasets").
* Plotting the results draws a clustergram and a pearson correlation matrix
* Clustergram shows True Positive, True Negative, False Positive and False Negative values
* Pearson correlation matrix is based a matrix that has these 4 values (TP,TN,FP,FN)

##### 07.03.2015 - Changed the algorithms

* Plot now uses top 10 of the most accurate algorithms
* Removed the algorithms that are not currently used
* Updated plotresults.m accordingly
* New .png added (Graph#2.png)

##### 03.03.2015 - Minor changes

* Exel file added (contains model times and accuracies for each algorithm)
* Colorfix on the graph (from red/blue to dark red/white)

##### 02.03.2015 - Updated plotting the results

* Added titles to each algorithm of the plot (represented by each column of the graph)
* Added .png of the plot (Graph#1.png)

##### 26.02.2015 - Major overhaul of code:

* Changed the filenames
* .MAT to .ARFF conversion is now skipped if the output .ARFF file already exists
* Created .ARFF result files for 4 Weka algorithms (BayesLogisticRegression.arff, IBk, RandomForest, SMO) using Weka Explorer
* Added weka2matlab scripts for plotting the results in matlab

##### 17.02.2015 - Added code files to GitHub
