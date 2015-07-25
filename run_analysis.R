## Purpose of the run_analysis.R script is to meet the assignment needs of coursera getdata-030

# install data,table and reshape2 if required
if (!require("data.table")) {
  install.packages("data.table")
}
library("data.table")

if (!require("reshape2")) {
  install.packages("reshape2")
}
library("reshape2")

# load test and train data
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# assign proper column names for all the datasets 
# extract feature names for the data from the second column of features.txt
features <- read.table("./UCI HAR Dataset/features.txt") [,2]

# assign the feature names to the data
names(test_x) <- features
names(train_x) <- features

# Similarly relpace activity id with its name
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
test_y[,1] <- activities[test_y[,1]]
names(test_y) <- "Activity"
train_y[,1] <- activities[train_y[,1]]
names(train_y) <- "Activity"

# assign subject label
names(test_subject) = "Subject"
names(train_subject) = "Subject"

# restrict datasets to mean and std
requiredFeatures <- grep(".*mean\\(\\)|.*std\\(\\)", features)
test_x <- test_x[,requiredFeatures]
train_x <- train_x[,requiredFeatures]

# Bind subject, activity and data
testData <- cbind(as.data.table(test_subject), test_y, test_x)
trainData <- cbind(as.data.table(train_subject), train_y, train_x)
#merge test and train data
mergedData <- rbind(testData, trainData)

#Tidy dataset
ids       = c("Subject", "Activity")
variables = colnames(mergedData)[3:length(colnames(mergedData))]
meltData = melt(mergedData, id = ids, measure.vars = variables)

# Apply mean using dcast function
tidyData   = dcast(meltData, Subject + Activity ~ variable, mean)

write.table(tidyData, file = "./tidydata.txt", row.names = FALSE)
