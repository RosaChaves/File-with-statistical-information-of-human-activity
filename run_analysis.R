library(reshape2)

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

## Download and unzip the data
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  downSelect.file(fileURL, filename, method="auto")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Select activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuresToSelect <- grep(".*mean.*|.*std.*", features[,2])
featuresToSelect.names <- features[featuresToSelect,2]
featuresToSelect.names = gsub('-mean', 'Mean', featuresToSelect.names)
featuresToSelect.names = gsub('-std', 'Std', featuresToSelect.names)
featuresToSelect.names <- gsub('[-()]', '', featuresToSelect.names)


# Select the datasets
training <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresToSelect]
trainingActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
training <- cbind(trainingSubjects, trainingActivities, training)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresToSelect]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# join datasets and add labels
allData <- rbind(training, test)
colnames(allData) <- c("subject", "activity", featuresToSelect.names)

# transform activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.joined <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.joined, subject + activity ~ variable, mean)

#write resulting tidy File
write.table(allData.mean, "tidyFile.txt", row.names = FALSE, quote = FALSE)