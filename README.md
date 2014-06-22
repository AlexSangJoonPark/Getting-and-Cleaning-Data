Getting-and-Cleaning-Data
=========================

This is a script for Getting and Cleaning Data Coursera Course.
by SangJoon Park

Instruction

To execute this script, user needs to have a original dataset 
which can receive from the url;
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
And the downloaded file needs to be extracted with "UCI HAR Dataset" folder name.



This script will execute the below tasks.
0. Preperation : Download the dataset file if required. Install reshape2 package if required.
1. Merges the training and the test sets to create one data set.
2. Uses descriptive activity names to name the activities in the data set
3. Appropriately labels the data set with descriptive variable names. 
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Outcomes
Two files will be created after execution the script of run_analysis.R
1. data_set_mean_std.txt
2. tidy_data_set_mean_subject_activity.txt
