##Following is implemented in this script
## 1. Read the test and the train data
## 2. Merge the test and the train data
## 3. Extract the measurments only with mean and standard deviation for each measurement
## 4. Name the activities using descriptive activity names
## 5. Label the data set with descriptive activity names
## 6. Get average of each variable for each activity and each subject
## 7. Create a tidy data set from the data obtained in step 6
##Following Assumptions are made to run the script successfully
## 1. UCI HAR Dataset is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## 2. This zipped dataset is extracted in the working directory
## 3. This script is saved and run from working directory
## 4. 'reshape2' package is loaded in the environment

print("Reading the 'activity_labels.txt' data")
temp <- read.table("activity_labels.txt", sep = "")
activityLabels <- as.character(temp$V2)

print("")

print("Reading the 'features.txt' data")
temp <- read.table("features.txt", sep = "")
print("    Subsetting features list to include only mean and standard deviation values of each measurement")
subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", temp$V2)
attributeNames <- temp$V2

print("")

print("Reading train data.....")
print("    Reading the 'X_train.txt' data")
Xtrain <- read.table("train/X_train.txt", sep = "")
print("    Renaming the column names of train data with data shared in 'features.txt'")
names(Xtrain) <- attributeNames
print("    Subsetting columns to include only mean and standard deviation values of each measurement")
Xtrain <- Xtrain[,subset_data_cols]
print("    Reading Activity data for train from 'y_train.txt' with heading 'Activity'")
Ytrain <- read.table("train/y_train.txt", sep = "")
names(Ytrain) <- "Activity"
print("    Convert the Activity data from integer to factor")
Ytrain$Activity <- as.factor(Ytrain$Activity)
print("    Redefine the levels of factor variable for 'Activity' with data shared in 'activity_labels.txt'")
levels(Ytrain$Activity) <- activityLabels
print("    Reading subject data from 'subject_train.txt' with heading 'Subject'")
trainSubjects <- read.table("train/subject_train.txt", sep = "")
names(trainSubjects) <- "Subject"
print("    Convert the Subject data from integer to factor")
trainSubjects$Subject <- as.factor(trainSubjects$Subject)
print("    Append Activity and Subject data to train data")
train <- cbind(Xtrain, Ytrain, trainSubjects)

print("")

print("Reading test data.....")
print("    Reading the 'X_test.txt' data")
Xtest <- read.table("test/X_test.txt", sep = "")
print("    Renaming the column names of test data with data shared in 'features.txt'")
names(Xtest) <- attributeNames
print("    Subsetting columns to include only mean and standard deviation values of each measurement")
Xtest <- Xtest[,subset_data_cols]
print("    Reading Activity data for test from 'y_test.txt' with heading 'Activity'")
Ytest <- read.table("test/y_test.txt", sep = "")
names(Ytest) <- "Activity"
print("    Convert the Activity data from integer to factor")
Ytest$Activity <- as.factor(Ytest$Activity)
print("    Redefine the levels of factor variable for 'Activity' with data shared in 'activity_labels.txt'")
levels(Ytest$Activity) <- activityLabels
print("    Reading subject data from 'subject_test.txt' with heading 'Subject'")
testSubjects <- read.table("test/subject_test.txt", sep = "")
names(testSubjects) <- "Subject"
print("    Convert the Subject data from integer to factor")
testSubjects$Subject <- as.factor(testSubjects$Subject)
print("    Append Activity and Subject data to test data")
test <- cbind(Xtest, Ytest, testSubjects)

print("")

print("Merging test and train data")
mergedData <- rbind(test, train)

print("")

print("Getting average of each variable for each activity and each subject")
library(reshape2)
id_vars = c("Activity", "Subject")
measure_vars = setdiff(colnames(mergedData), id_vars)
melted_data <- melt(mergedData, id=id_vars, measure.vars=measure_vars)

print("")

print("Creating tidy data")
tidyData <- dcast(melted_data, Activity + Subject ~ variable, mean)

print("")

print("Saving tidy data to 'tidyData.txt'")
write.table(tidyData, "tidyData.txt")

print("")

print("Script successfully completed")