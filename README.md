## Samsung Data Analysis

### Getting and Cleaning Data Course @ Data Science - Peer Assesment Submission

### This repository contains a R-Script file 'run_analysis.R'.
### Below is step by step execution of this script

* Read Activity Labels from 'activity_labels.txt'
* Read Features list from 'features.txt'
* Read train Data from 'X_train.txt'
	* Modify Column names of train data with features list in step 2 above
	* Exclude all the columns except for the values of mean and standard deviation for each measurement
	* Read activity data from 'y_train.txt'
	* Apply activity labels to activity data obtained in step above
	* Read subject data from 'subject_train.txt'
	* Append activity and subject data with train data
* Read test Data from 'X_test.txt'
	* Modify Column names of test data with features list in step 2 above
	* Exclude all the columns except for the values of mean and standard deviation for each measurement
	* Read activity data from 'y_test.txt'
	* Apply activity labels to activity data obtained in step above
	* Read subject data from 'subject_test.txt'
	* Append activity and subject data with test data
* Merge test and train data
* Get average of each variable for each activity and each subject
* Create tidy data
* Saving tidy data to 'tidyData.txt'
