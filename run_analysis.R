run_analysis.R <- function() {
  ###########################################################################################
  ### Getting and Cleaning Data Course Project                                            ###
  ###########################################################################################
  
  #1#	Merge the training and the test sets to create one data set
  
  # 1.1 Download and unzip the project zip file
  if(!file.exists("./data")){dir.create("./data")}
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,destfile="./data/Project4.zip")
  unzip(zipfile="./data/Project4.zip",exdir="./data")
  # Unzipped files are placed in "UCI HAR Dataset" directory:
  # dir("data")
  # [1] "Project4.zip"    "UCI HAR Dataset"
  
  # 1.2 Read activity, subject, and feature data from individual files 
  path <- "./data/UCI HAR Dataset"
  
  activityTest  <- read.table(file.path(path,"test","y_test.txt"))
  activityTrain <- read.table(file.path(path,"train","y_train.txt"))
  
  subjectTrain <- read.table(file.path(path,"train","subject_train.txt"))
  subjectTest <- read.table(file.path(path,"test","subject_test.txt"))
  
  featureTest <- read.table(file.path(path,"test","X_test.txt"))
  featureTrain <- read.table(file.path(path,"train","X_train.txt"))
  
  # 1.3 Merge test and training data
  activities <- rbind(activityTest,activityTrain)
  subjects <- rbind(subjectTest,subjectTrain)
  features <- rbind(featureTest,featureTrain)
  
  # 1.4 Assign names to variables
  names(activities) <- c("activity")
  names(subjects)   <- c("subject")
  
  # get feature names from file features.txt
  featureNames <- read.table(file.path(path,"features.txt"))
  names(features) <- featureNames$V2   # V2 is a factor containing feature names
  
  # Combine all three data frames into one
  temp    <- cbind(subjects,activities)
  allData <- cbind(temp,features)
  
  
  ###########################################################################################
  #2# Extracts only the measurements on the mean and standard deviation for each measurement 
  ###########################################################################################
  
  # Select only features with names containing "mean()" or "std()"
  criteria <- "mean\\(\\)|std\\(\\)"  # regular expression selecting mean() or std()
  neededFeatures <- featureNames$V2[grep(criteria,featureNames$V2)]
  
  # Extract only features we want into another data frame, along with activities and subjects
  neededColumns <- c("activity","subject",as.character(neededFeatures)) 
  neededData <- subset(allData,select = neededColumns)
  
  ###########################################################################################
  #3#	Uses descriptive activity names to name the activities in the data set
  ###########################################################################################
  
  #3.1 Read activity names from file
  activityLabels <- read.table(file.path(path, "activity_labels.txt"), header = FALSE)
  
  # str(activityLabels)
  # 'data.frame':	6 obs. of  2 variables:
  # $ V1: int  1 2 3 4 5 6
  # $ V2: Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1
  
  # head(activityLabels)
  #   V1                 V2
  # 1  1            WALKING
  # 2  2   WALKING_UPSTAIRS
  # 3  3 WALKING_DOWNSTAIRS
  # 4  4            SITTING
  # 5  5           STANDING
  # 6  6             LAYING
  
  #3.2 Factorize the activity variable
  neededData$activity <- activityLabels$V2[neededData$activity]
  # neededData$activity[1:5]
  # [1] STANDING STANDING STANDING STANDING STANDING
  # Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
  
  ###########################################################################################
  #4#	Appropriately labels the data set with descriptive variable names. 
  ###########################################################################################
  # The feature names are going to be changed as follows:
  #	prefix "t" is replaced by time
  #	prefix "f" is replaced by frequency
  #	"Acc" is replaced by "Accelerometer"
  #	"Gyro" is replaced by "Gyroscope"
  #	"Mag" is replaced by "Magnitude"
  #	"BodyBody" is replaced by "Body"
  
  names(neededData)<-gsub("^t", "time", names(neededData))
  names(neededData)<-gsub("^f", "frequency", names(neededData))
  names(neededData)<-gsub("Acc", "Accelerometer", names(neededData))
  names(neededData)<-gsub("Gyro", "Gyroscope", names(neededData))
  names(neededData)<-gsub("Mag", "Magnitude", names(neededData))
  names(neededData)<-gsub("BodyBody", "Body", names(neededData))
  
  ###########################################################################################
  #5#	From the data set in step 4, creates a second, independent tidy data set 
  #   with the average of each variable for each activity and each subject.
  ###########################################################################################
  # aggregate on (subject + activity) and apply mean()
    avgData <- aggregate(. ~ subject + activity, neededData, mean)
  
  # order by (subject + activity)
  avgData <- avgData[order(avgData$subject,avgData$activity),]
  
  # write to a file
  write.table(avgData, file = "tidyaveragedata.txt",row.name=FALSE)
  
}