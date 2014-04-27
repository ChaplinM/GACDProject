# First change to the working directory
# setwd("C:/Users/your-user/Documents/GitHub/GACDProject") # for example

# 0. You may need to load data.table package 
#   - if so, uncomment the next two lines:
# install.packages("data.table")
# library(data.table)


# 1. Load the training and test data sets

## 1a. Training data sets (used to develop a model in machine learning)
## dir(path="UCI HAR Dataset/train", pattern="*.txt")  # verify
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

## 1b. Test datasets (used to test the model predictions in machine learning)
## dir(path="UCI HAR Dataset/test", pattern="*.txt")  # verify
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")


# 2. Merge the training and test datasets
subject_all <- rbind(subject_train, subject_test)
X_all <- rbind(X_train, X_test)
y_all <- rbind(y_train, y_test)


# 3. Load the lookups for the features (to become column names) and 
#    the activity labels
lookup_features <- read.table("UCI HAR Dataset/features.txt")
lookup_activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt") 


# 4. Rename the columns in features data table
setnames(X_all, old=1:561, new=as.character(lookup_features$V2))


# 5. Define a lookup function for activity name
lookup_act <- function(x) {
  as.character(lookup_activity_labels[x,2])
}


# 6. Add a tidy version of the activity names to Y data tables
y_all <- cbind(y_all, activity=lookup_act(y_all$V1))


# 7. Find the columns that have mean() or std() in names
# see discussion thread: https://class.coursera.org/getdata-002/forum/thread?thread_id=398
toMatch <- c("mean\\(\\)", "std\\(\\)")
matches <- unique (grep(paste(toMatch,collapse="|"), 
                        lookup_features$V2, value=TRUE))
matches


# 8. subset the features data table to include only the mean() and std() columns
X_mean_std <- X_all[, matches]


# 9. augment the features data table with the activities and the subjects
data_mean_std <- cbind(activity=y_all$activity, 

                       subject=subject_all$V1, X_mean_std)
# 10. Write the data set to a tab-delimited text file
write.table(data_mean_std, "data_mean_std.txt")


### ---------- End of Part 1 ---------- ###


# 1. augment the full features data table with the activities and the subjects
data_all <- cbind(activity=y_all$activity, 
                       subject=subject_all$V1, X_all)

# 2. Use aggregate() function to get subtotals over activity, subject (cols 1:2)
mean_bygroup <- aggregate(data_all[,3:563],data_all[,1:2],mean)


# 3. Write the aggregated results to a tab-delimited text file
write.table(mean_bygroup, "mean_bygroup.txt")
