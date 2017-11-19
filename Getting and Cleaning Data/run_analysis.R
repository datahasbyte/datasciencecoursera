## This script reads multiple files containing test and training data
## reads all files and combines like data frames
## finally, we tidy the data finding the mean of every column and export

library(reshape2)
library(dplyr)

setwd("E:\\Dropbox\\coursera\\Getting and Cleaning Data\\UCI HAR Dataset")

X_train <- read.table(".\\train\\X_train.txt")
y_train <- read.table(".\\train\\y_train.txt")
X_test <- read.table(".\\test\\X_test.txt")
y_test <- read.table(".\\test\\y_test.txt")
subject_test <- read.table(".\\test\\subject_test.txt")
subject_train <- read.table(".\\train\\subject_train.txt")
features <- read.table(".\\features.txt")[,2]
activities <- read.table(".\\activity_labels.txt")[,2] # activity names 

# Linux
# setwd("~/Dropbox/coursera/Getting and Cleaning Data/UCI HAR Dataset")
# 
# X_train <- read.table("./train/X_train.txt")
# y_train <- read.table("./train/y_train.txt")
# X_test <- read.table("./test/X_test.txt")
# y_test <- read.table("./test/y_test.txt")
# subject_test <- read.table("./test/y_test.txt")
# features <- read.table("./features.txt")[,2]
# activities <- read.table("./activity_labels.txt")[,2] # activity names 

# name setting
names(X_test) <- features
names(X_train) <- features
names(subject_df) <- "SubjectId"

X_df <- rbind(X_test, X_train) # merge X frames
y_df <- rbind(y_test, y_train) # merge y frames
subject_df <- rbind(subject_test, subject_train) # merge subject frames

# filter columns with mean or std in name
X_df <- X_df[,grepl(".*(.*mean|.*std).*", features)]

# set names of activities based on activity value
y_df[,1]
y_df[,2] <- activities[y_df[,1]]
names(y_df) <- c('ActivityId', 'Activity')

# merge data and subjects
combined_df <- cbind(X_df, subject_df, y_df)

# created tidy (long) data and save to file
melted_df <- melt(combined_df, (id.vars=c("SubjectId", "Activity")))
dcast(melted_df, SubjectId + Activity ~  variable, mean) %>% write.table(file = ".\\tidy_data.txt", row.names = FALSE)

names(combined_df)
