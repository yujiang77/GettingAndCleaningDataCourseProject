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

## read train and test set in Chr mode
##Colcount <- dim(read_table(file.path(dtPath,"train","X_train.txt"), col_names = FALSE))[[2]]
##dtSetTrain <- read_table(file.path(dtPath,"train","X_train.txt"), col_names = FALSE, col_types = paste(rep("c",Colcount),collapse = ""))
##Colcount <- dim(read_table(file.path(dtPath,"test","X_test.txt"), col_names = FALSE))[[2]]
##dtSetTest <- read_table(file.path(dtPath,"test","X_test.txt"), col_names = FALSE, col_types = paste(rep("c",Colcount),collapse = ""))
dt_set_train <- read_table(file.path(dtPath,"train","X_train.txt"), col_names = FALSE)
dt_set_test <- read_table(file.path(dtPath,"test","X_test.txt"), col_names = FALSE)

## read subject
dt_subject_train <- read_csv(file.path(dtPath,"train","subject_train.txt"),col_names = "subject")
dt_subject_test <- read_csv(file.path(dtPath,"test","subject_test.txt"),col_names = "subject")

## read train and test label
dt_label_train <- read_csv(file.path(dtPath,"train","y_train.txt"),col_names = "activity")
dt_label_test <- read_csv(file.path(dtPath,"test","y_test.txt"),col_names = "activity")

## Merges the training and the test sets to create one data set.
dt_set_train <- bind_cols(dt_set_train,dt_subject_train,dt_label_train)
dt_set_test <- bind_cols(dt_set_test,dt_subject_test,dt_label_test)

dt_set_all <- bind_rows(dt_set_train,dt_set_test)

## read features
features <- read_table(file.path(dtPath,"features.txt"), col_names = FALSE)
#features <- separate(data = features,1,into = c("number","features"),sep = " ")

## rename the column with feature names
colnames(dt_set_all) <- c(pull(features[,1]) ,"subject","label")


## Extracts only the measurements on the mean and standard deviation for each measurement.
dt_selected <- select(dt_set_all,matches("mean\\(\\)|std\\(\\)|subject|label"))
colnames(dt_selected) <- gsub("^[0-9]*\\s","",colnames(dt_selected)) # remove the number in colnames

## read activity labels
dt_activity_label <- read_table(file.path(dtPath,"activity_labels.txt"),col_names = FALSE)
colnames(dt_activity_label) <- c("label","activity")


## Appropriately labels the data set with descriptive variable names.
dt_selected <- inner_join(dt_selected, dt_activity_label)

names(dt_selected)<-gsub("^t", "time", names(dt_selected))
names(dt_selected)<-gsub("^f", "frequency", names(dt_selected))
names(dt_selected)<-gsub("Acc", "Accelerometer", names(dt_selected))
names(dt_selected)<-gsub("Gyro", "Gyroscope", names(dt_selected))
names(dt_selected)<-gsub("Mag", "Magnitude", names(dt_selected))
names(dt_selected)<-gsub("BodyBody", "Body", names(dt_selected))
