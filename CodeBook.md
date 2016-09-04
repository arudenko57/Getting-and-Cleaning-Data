# Code Book
## Project: Getting and Cleaning Data
#### The outcome of the project is a tidy data frame containing the means of every measurement (linear acceleration and angular velocity) grouped by subject (a person who performed the activity) and the activity type (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 

#### The resulted data frame has the following structure: (better viewed in Raw mode) 

 str(avgData)

 'data.frame':	180 obs. of  68 variables:

 $ subject                                       : int  1 2 3 4 5 6 7 8 9 10 ...

 $ activity                                      : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...

 $ timeBodyAccelerometer-mean()-X                : num  0.277 0.276 0.276 0.279 0.278 ...

 $ timeBodyAccelerometer-mean()-Y                : num  -0.0174 -0.0186 -0.0172 -0.0148 -0.0173 ...

etc.

## Listed below are transformations that were performed in order to create the final data frame.
1.	The project file was downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and then unzipped. 
2.	The subject, activity, and features (i.e. measurment) data we loaded into two sets of data frames (training set and test set), and then merged. The result of this step was three data frames – subjects, activities, and features.

3.	Each variable was assigned a name as follows:
   - subjects (one column): “subject”
   - activities (one column): “activity”
   - features (multiple columns): names defined in the features.txt file

4.	Combine all three data frames into one (by columns).

5.	Drop all features that were not measuring mean or standard deviation and put the result into another data frame.

6.	Replace the activity values (numbers) with descriptive names using labels in the activity_labels.txt file.

7.	Replace all abbreviations in the features names with descriptive words (e.g. “Gyro” -> “Gyroscope”).

8.	Group all the features (measurments) by subject and activity and write the resulted data frame into a text file.
 
