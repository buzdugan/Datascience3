This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.

This is the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project was downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data:

1) Read subject_train.txt, X_train.txt and y_train.txt from the "./UCI HAR Dataset/train" folder and store them in subjTrain, tTrain and activTrain data frames respectively.

2) Read subject_test.txt, X_test.txt and y_test.txt from the "./UCI HAR Dataset/test" folder and store them in subjTest, tTest and activTest data frames respectively.

3) Read features.txt from the "./UCI HAR Dataset" folder and store it in features data frame.
Renames the column names of the features data frame in "featNo" and "featName"

4) Create a vector vectMeas with the names of the features from the features data frame

5) Merges the 3 data frames (subjTrain, tTrain and activTrain) into dfTrain
 Merges the 3 data frames (subjTest, tTest and activTest) into dfTest

6) Merges the dfTrain and dfTest into dfAll data frame with all the data


7) In extractedMeas data frame keeps just the features with mean and standard deviation

8) Creates a data frame feat.sel with the subject, activity number and the measurements for the selected features


9) Read "activity_labels.txt" into dfActiv data frame and rename the column names to "activityNo","activityName"

10) Merge the data frames feat.sel and dfActiv and into desc.feat and labels the activities by number


11) Create a vector with the names of the selected activities

12) Create a feat.melt data frame by keeping the subject and activityName and adding as variables the name of one feature and the value of the measurement

13) Generate a second independent tidy data set AvData with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination.


