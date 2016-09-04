# Getting-and-Cleaning-Data
Getting and Cleaning Data Course Project
All the functionality is performed with by script – run_analysis.R
The script perform the following steps, with each step using the result of previous step(s):
-	Download the project zip file and unzip it into several files
-	Read the activity, subject, and feature data from corresponding test and training set of files
-	Merge the test and training data (activity, subject, and feature data)
-	Assign names to the variables in merged data frame created in previous step (get the features names from file features.txt)
-	Pull out measurements (features) on the mean and standard deviation into a separate data frame
-	Modify the names of variables (feature names) to make them more descriptive (get rid of abbreviations)
-	Calculate means for each measurement (feature) grouped by subject and activity
-	Write out the resulted data frame into a text file
