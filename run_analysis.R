setwd()

# Load packages
library(data.table)
library(dplyr)
library(tidyverse)

# Download a file from the web
if(!file.exists("week4_project.zip")){
  fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./week4_project.zip", method ="curl")
}

unzip(zipfile = "week4_project.zip")

# read data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <-read.table("UCI HAR Dataset/features.txt", col.names = c("number", "feature"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("code"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("code"))

# merge train data set
train <- cbind(subject_train, x_train, y_train)
str(train)

# merge test data set
test <- cbind(subject_test, x_test, y_test)

# 1. merge train and test data sets
merged <- rbind(train, test)
str(merged)

# 2. extract the measurements on the mean and std for each measurements
extracted <- merged %>% 
              select(subject, code, contains("mean"), contains("std"))

# 3. use descriptive activity names to name the activities in the data set
extracted <- merge(extracted, activities, by = "code") # merge exetracted data set and acitivities by code
extracted$code <- NULL # remove code from extracted, leaving only the name of acitivities in the data set
  
# 4. put appropriate lables in the data set with descriptive variable names
colnames(extracted) <- gsub("^t", "Time", colnames(extracted))
colnames(extracted) <- gsub("^f", "Frequency", colnames(extracted))
colnames(extracted) <- gsub("Gyro", "Gyroscope", colnames(extracted))
colnames(extracted) <- gsub("Jerk", "JerkSignal", colnames(extracted))
colnames(extracted) <- gsub("Mag", "Magnitude", colnames(extracted))
colnames(extracted) <- gsub("Acc", "Acceleration", colnames(extracted))
colnames(extracted) <- gsub("std", "StandardDeviation", colnames(extracted))
colnames(extracted) <- gsub("BodyBody", "Body", colnames(extracted))
colnames(extracted) <- gsub("Freq", "Frequency", colnames(extracted))
colnames(extracted) <- gsub("gravity", "Gravity", colnames(extracted))
colnames(extracted) <- gsub("angle", "Angle", colnames(extracted))
colnames(extracted) <- gsub("mean", "Mean", colnames(extracted))
colnames(extracted) <- gsub("tBody", "TimeBody", colnames(extracted))
colnames(extracted) <- gsub(".", "_", colnames(extracted), fixed = T) # replace period(.) to underscore
colnames(extracted) <- gsub("__", "", colnames(extracted), fixed = T) # remove unnecessary underscores
colnames(extracted) <- gsub("Gravity_", "Gravity", colnames(extracted), fixed = T) # remove unnecessary underscores
colnames(extracted) <- gsub("GravityMean_", "GravityMean", colnames(extracted), fixed = T) # remove unnecessary underscores

# 5. make a second, independent tidy data set with the avearge of each variable for each activity and subejct
tidydata <- extracted %>%
            group_by(subject, activity) %>%
            summarise_all(mean)

# export data set
write.table(tidydata, file = "Tidydadta.txt", row.name=FALSE)
  
  
