## Getting and Claening Data course project
##
##
## 1. Merges the training and the test sets to create one data set.
##
# read files, assumes zip file has been unzipped into 
#  "~/R/GetClean/project"
setwd("~/R/GetClean/project")
features <- read.table("./UCI HAR Dataset/features.txt")
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
#
# combine train and test data
subject <- rbind(subject.train, subject.test)
x <- rbind(x.train, x.test)
y <- rbind(y.train, y.test)
#
# assign column names
names(subject) <- "subject"
names(y) <- "activity"
names(x) <- as.character(features[,2])
#
# (deferring the final combine until after step 2)
#
## 2. Extracts only the measurements on the mean and 
##    standard deviation for each measurement. 
x.part <- x[,grepl("mean\\(\\)|std\\(\\)", names(x))]
#
# combine subject, activity, and mean()/std() data into
#  a single data frame
merged.df <- cbind(subject, y, x.part)
#
## 3.Uses descriptive activity names to name the activities 
##   in the data set
merged.df$activityLabel <- activity.labels[merged.df$activity,2]
#
## 4.Appropriately labels the data set with descriptive 
##   variable names. 
# Per features_info.txt, t = "time", f = "frequency"
names(merged.df) <- sub("^t", "time", names(merged.df))
names(merged.df) <- sub("^f", "frequency", names(merged.df))
names(merged.df) <- sub("-mean\\(\\)-", "Mean", names(merged.df))
names(merged.df) <- sub("-std\\(\\)-", "Std", names(merged.df))
names(merged.df) <- sub("-mean\\(\\)", "Mean", names(merged.df))
names(merged.df) <- sub("-std\\(\\)", "Std", names(merged.df))
merged.df$activity <- merged.df$activityLabel
merged.df$activityLabel <- NULL
#
## 5.From the data set in step 4, creates a second, independent 
##   tidy data set with the average of each variable for each 
##   activity and each subject.
mean.df <- group_by(merged.df, subject, activity) %>%
        summarise_each(c("mean"))
#
## Create text file for submission
write.table(mean.df, "tidy_data.txt", row.names = FALSE)
#
## text file can be read into a data frame by running:
# df <- read.table("tidy_data.txt", header = TRUE)

