Getting and Cleaning Data Course

JHU in Coursera

Date created: 2015-06-16

R version: 3.1.2 

Author: mullerml

**Readme**


#### General information

The purpose of this project is to collect, transform and clean a data set and prepare tidy data that can be used for later analysis. Data used is publicly available and was collected from Samsung Galaxy S smartphones (Anguita *et al.* 2012).

The "getting and cleaning data" Github repository contains three files:

1. README.md

2. CodeBook.md

3. run_analysis.R

The current file (**README.md**) contains information on how all files work and how they are connected.

**CodeBook.md** describes the variables, the data, and any transformations or work that was performed to clean up the data.

The R script **run_analysis.R** contains code whose output is a tidy data set that can be used for further analysis. 

The script does the following:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set.

4. Labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The generated data set (.txt) meets the principles of tidy data: having each variable in one column, and each different observation in a different row (Wickham 2014). The specific description of the original data, and the tidy data file contents is described in **CodeBook.md**.

#### References

- Wickham, H. Tidy data. *Journal of Statistical Software* 59(10):1-23, 2014.

- D. Anguita, A. Ghio, L. Oneto, X. Parra and J. L. Reyes-Ortiz. 
A Public Domain Dataset for Human Activity Recognition on Smartphones
using a Multiclass Hardware-Friendly Support Vector Machine. 
*International Workshop of Ambient Assisted Living*, 2012. 