###################################################################################
# This is a script for Getting and Cleaning Data Coursera Course.
# by SangJoon Park
# 
# Instruction
# To execute this script, user needs to have a original dataset 
# which can receive from the url;
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# And the downloaded file needs to be extracted with "UCI HAR Dataset" folder name.
#
# This script will execute the below tasks.
# 0. Preperation : Download the dataset file if required. Install reshape2 package if required.
# 1. Merges the training and the test sets to create one data set.
# 2. Uses descriptive activity names to name the activities in the data set
# 3. Appropriately labels the data set with descriptive variable names. 
# 4. Extracts only the measurements on the mean and standard deviation for each measurement.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
###################################################################################

# 0. Preperation
# File download
working_dir <- "UCI HAR Dataset"
if (file.exists(working_dir)){
    setwd(working_dir)
} else {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile="getdata-projectfiles-UCI HAR Dataset.zip", method="curl")
    unzip("getdata-projectfiles-UCI HAR Dataset.zip")
    setwd(working_dir)
}

# Check reshape2 package
if (!require("reshape2")) {
    install.packages("reshape2")
    require("reshape2")
}

# 1. Merges the training and the test sets to create one data set.
# Loading Test Dataset
test_x       <- read.table("test/X_test.txt")
test_y       <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

# Loading Training Dataset
train_x       <- read.table("train/X_train.txt")
train_y       <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

# Merging Dataset both test and train
test_data  <- cbind(test_subject, test_y, test_x)
train_data <- cbind(train_subject, train_y, train_x)
data_set   <- rbind(test_data, train_data)

# 2. Uses descriptive activity names to name the activities in the data set
features <- read.table("features.txt", stringsAsFactors=FALSE, header=FALSE)
names(data_set)[1] <- "Subject"
names(data_set)[2] <- "Activity"
col_nums <- length(names(data_set))  # 563
names(data_set)[3:col_nums] <- features[, 2]

# 3. Appropriately labels the data set with descriptive variable names.
activity_labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE, header=FALSE)
for (activity in activity_labels[, 1]){
    data_set$Activity[data_set$Activity == activity] <- activity_labels[activity, 2]}

# 4. Extracts only the measurements on the mean and standard deviation for each measurement. 
select_columns <- names(data_set) %in% c("Subject", "Activity") | grepl("mean()|std()", names(data_set));
selected_data_set <- data_set[, select_columns]

# First outcome : Data Set for Mean and Standard Devation
write.table(selected_data_set, file="data_set_mean_std.txt")


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# Melting data frames by Subject and Activity
library(reshape2)
melted_data_set <- melt(selected_data_set, id=c("Subject","Activity"))

# Casting data frames
tidy_data_set <- dcast(melted_data_set, Subject + Activity ~ variable, mean)

# Second outcome : Tidy Data Set
write.table(tidy_data_set, file="tidy_data_set_mean_subject_activity.txt")

setwd("..")  # return to parent folder
