# Getting and Cleaning Data Course
# JHU in Coursera
# Date created: 2015-06-16
# R version: 3.1.2 
# Author: mullerml
# **R Script**

# Please refer to the accompanying "README.md" file

#_______________________________________________________________________________#
# This script:
#_______________________________________________________________________________#
# 1. Merges the training and test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Labels the data set with descriptive variable names
# 5. From the data set in set 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject 

#_______________________________________________________________________________#
# 0. Load packages and data sets ----
#_______________________________________________________________________________#
# Set working directory
setwd("../Google Drive/Coursera/gcdata/project files")

# Load packages:
library("dplyr")
library("tidyr")

# Load train data:
# subject ID, activity labels and measurements
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt") 

# Load test data:
# subject ID, activity labels and measurements
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt") 

# Load activity names:
# Links the activity labels with the activity name
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Load variable features of each feature vector:
var_names <- read.table("./UCI HAR Dataset/features.txt")

#_______________________________________________________________________________#
# 1. Merge the training and test sets
#_______________________________________________________________________________#
# Combine the data by rows
# Change variable names of "subject" and "labels";
# the variables of "set" will be renamed later
subject <- bind_rows(train_subject, test_subject) #%>%
#     rename(subject_id = V1)

labels <- bind_rows(train_labels, test_labels) #%>%
#     rename(activity = V1)

set <- bind_rows(train_set, test_set)

# Combine the train and test sets by columns
data <- bind_cols(subject, labels, set)

# Transform column names to unique values
names(data) <- paste0("V", 1:563)

# Remove all objects from workspace except the ones needed later
rm(list= ls()[!(ls() %in% c("data", "var_names", "activity_names"))])

#_______________________________________________________________________________#
# 2. Extract only the variables on the mean and 
# standard deviation for each measurement ----
#_______________________________________________________________________________#
# Vector of the indices of elements of "var_names" that contain "mean()" or 
# "std()" of each measurement
var_subset <- grep("mean\\()|std\\()" , var_names$V2)

# Modify the previous vector
# to account for variables "subject_id" and "activity"
# by including them at the beginning and adding "two" to each index
var_subset_modif <- c(1, 2, (var_subset + 2))

# Select only the desired variables (columns) of "data"
# usind the previously defined vector of indices
subset <- select(data, var_subset_modif)

# Clean workspace
rm(data, var_subset_modif)

#_______________________________________________________________________________#
# 3. Use descriptive names for the activities in the data subset ----
#_______________________________________________________________________________#
# Use "activity" labels to link it to "activity_names"
# Reorder the columns of the data set, 
# leave the activity label out, and
# rename the subject_id and activity variables
subset <- inner_join(activity_names, subset, by = c("V1" = "V2")) %>%
    select(subject_id = V1.y, activity_name = V2, V3:V545) 
    
#_______________________________________________________________________________#
# 4. Label the data set with descriptive variable names ----
#_______________________________________________________________________________#
# Rename the variables using "var_names"
# and the indexes selected in step 2

names(subset)[3:68] <- as.character(var_names$V2[var_subset])

# Change names
names(subset) <- gsub(pattern = "mean\\()", replacement = "mean", x = names(subset))
names(subset) <- gsub("std\\()", "std", names(subset))
names(subset) <- gsub("^t", "time", names(subset))
names(subset) <- gsub("^f", "frequency", names(subset))
names(subset) <- gsub("Acc", "Accelerometer", names(subset))
names(subset) <- gsub("Gyro", "Gyroscope", names(subset))
names(subset) <- gsub("Mag", "Magnitude", names(subset))
names(subset) <- gsub("-", "_", names(subset))
names(subset) <- gsub("BodyBody", "Body", names(subset))

# Check there are no duplicated column names
# table(duplicated(names(subset)))

#_______________________________________________________________________________#
# 5. Create a second, independent tidy data set with the average ----
# of each variable for each activity and each subject
#_______________________________________________________________________________#
# Create a new data frame tbl
# Group by subject_id and activity name
# Calculate the mean by activity and subject
# Collapse measurements into one column
tidydata <- subset %>% 
    tbl_df %>% 
    group_by(subject_id, activity_name) %>% 
    summarise_each(funs(mean)) %>%
    gather(measurement, mean, -subject_id, -activity_name)

# Save tidy data set as .txt file 
write.table(tidydata, file ="../tidy_smartphone_mean_data.txt", row.name=FALSE)

# Remove all objects from workspace except "tidydata" 
rm(list=(ls()[ls()!="tidydata"]))

#_______________________________________________________________________________#
# End of script ----
#_______________________________________________________________________________#


