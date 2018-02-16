## This script is to create one R script called run_analysis.R that does the following.

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average- 
##    of each variable for each activity and each subject.
library(tidyverse)

## the path of data
dtPath <- file.path(getwd(), "UCI HAR Dataset")

## read train and test set
dtSetTrain <- read_csv(file.path(dtPath,"train","X_train.txt"), col_names = FALSE)
dtSetTest <- read_csv(file.path(dtPath,"test","X_train.txt"), col_names = FALSE)

## read train and test label
dtLaybelTrain <- read_csv(file.path(dtPath,"train","y_train.txt"))
dtLaybelTest <- read_csv(file.path(dtPath,"test","y_train.txt"))