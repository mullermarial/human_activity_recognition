Getting and Cleaning Data Course

JHU in Coursera

Created: 2015-06-16

R version: 3.1.2 

Author: mullerml

**Codebook** 


*Please refer to the accompanying "README.md" file*


#### Contents

This codebook contains the following information:
 
1. Data description

2. Description of transformations or work that was performed to clean up the data

3. Tidy data set variables description


#### Data description (modified from Anguita *et al.* 2012) 

Thirty volunteers performed six activities wearing a smartphone on the waist. 
3-axial linear acceleration and 3-axial angular velocity was captured at a constant rate. Sensor signals were sampled in windows of 2.56 sec and 50% overlap (128 readings/window)

The features for this database come from the accelerometer and gyroscope 3-axial raw signals (timeAccelerometer-XYZ and timeGyroscope-XYZ). These time domain signals (prefix "time") were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcceleration-XYZ and timeGravityAcceleration-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerometerJerk-XYZ and timeBodyGyroscopeJerk-XYZ). Also the magnitudes of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerometerMagnitude, timeGravityAccelerometerMagnitude, timeBodyAccelerometerJerkMagnitude, timeBodyGyroscopeMagnitude, timeBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequencyBodyAccelerometer-XYZ, frequencyBodyAccelerometerJerk-XYZ, frequencyBodyGyroscope-XYZ, frequencyBodyAccelerometerJerkMagnitude, frequencyBodyGyroscopeMagnitude, frequencyBodyGyroscopeJerkMagnitude (note the prefix "frequency" to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
"-XYZ" is used to denote 3-axial signals in the X, Y and Z directions.

Features are normalized and bounded within [-1,1].

**Data source**:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip (retrieved 2015-06-16)

**Original source**:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**Reference**:
D. Anguita, A. Ghio, L. Oneto, X. Parra and J. L. Reyes-Ortiz. 
A Public Domain Dataset for Human Activity Recognition on Smartphones
using a Multiclass Hardware-Friendly Support Vector Machine. 
*International Workshop of Ambient Assisted Living*, 2012. 

#### Cleaning up the data

The R script **run_analysis.R** contains code whose output is a tidy data set that can be used for further analysis. This code can be run as long as the data folder "UCI HAR Dataset" (available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) is in the working directory. 

This script:

1. Loads and merges the training and test sets to create one data set, since each is provided as separate files that contain subject IDs, activity labels and measurements.

2. Extracts only the measurements on the mean value and standard deviation by selecting variables identified by "mean()" and "std()" (66 variables). Other variables that obtained information from averaging the signals in a signal window sample were not used.

3. Uses descriptive activity names to rename the activities in the data set, by using strings instead of numeric IDs.

4. Relabels the data set with descriptive variable names to facilitate interpretation.

5. From the data set in step 4, creates a second, independent tidy data set (see description in the following section) with the average of each variable for each activity and each subject. The generated data set (tidy_smartphone_mean_data.txt) has each variable in one column, and each different observation in a different row. 



#### Tidy data set

The "tidy_smartphone_mean_data.txt" dataset has 11880 observations and 4 variables.

[1] "subject_id"
[2] "activity_name"
[3] "measurement"
[4] "mean"

Variable **"subject_id"** contains the unique identification number of 30 participating subjects. Range is 1-30. 

Variable **"activity_name"** indicates the type of physical activity performed by each subject. It has six levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS. 

Variable **"measurement"** indicates the specific measurement recorded. It has 66 levels: names are as described above in the data description section. Additionally, "mean" indicates mean value, and "std" standard deviation.

Variable **"mean"** shows the average measurement for each subject and activity.





