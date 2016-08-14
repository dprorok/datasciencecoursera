library(dplyr)

# Download and unzip the dataset if not done so already
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "./dataset.zip"

if (!file.exists(destfile)){
     download.file(fileURL, destfile, method="curl")
     dateDownloaded <- Sys.Date()
}  
if (!file.exists("UCI HAR Dataset")) { 
     unzip(destfile) 
}


# Read in files
activities.test <- read.table("./UCI HAR Dataset/test/y_test.txt", colClasses="factor")
activities.train <- read.table("./UCI HAR Dataset/train/y_train.txt", colClasses="factor")
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
measurements.test <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors=FALSE)
measurements.train <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors=FALSE)
subjects.test <- read.table("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors=FALSE)
subjects.train <- read.table("./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors=FALSE)


# Read in the feature labels. Strip out special characters.
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
features[,2] <- gsub('-mean', 'Mean', features[,2])
features[,2] <- gsub('-std', 'Std', features[,2])
features[,2] <- gsub('[-()]', '', features[,2])
features[,2] <- gsub(',', '.', features[,2])


# Combine columns from the training and test datasets
dataset.test <- cbind(subjects.test, activities.test, measurements.test)
dataset.train <- cbind(subjects.train, activities.train, measurements.train)


# Combine train and test datasets and then sort by subject and activity
# This completes Requirement 1: Merges the training and the test sets to create one data set.
# Code the activity data with useful factor names from activity.labels[,2].
# Give the columns meaningful names. This further completes Requirement 4: Appropriately 
# labels the data set with descriptive variable names.
complete.dataset <- rbind(dataset.test, dataset.train)
names(complete.dataset) <- c("subject", "activity", features[,2])
complete.dataset$activity <- mapvalues(complete.dataset$activity, 
                                       from = levels(complete.dataset$activity), to = activity.labels[,2])
complete.dataset <- complete.dataset[ order(complete.dataset$subject, complete.dataset$activity), ]


# The below completes Requirement 2: Extracts only the measurements on the mean and 
#    standard deviation for each measurement.
# Choosing the broadest interpretation of "mean" to include calculations that are 
# themselves means (typically ending in "Mean") as well as calculations based on 
# means, such as "MeanFreq" and the angle measurements between two mean vectors. The intent
# was unclear so I opted for the broadest interpretation, figuring that it's easier to
# later subset out superfluous columns (such as removing the vector angle columns) than 
# it is to reclean the data to put incorrectly deleted data back in.
cols.mean <- grep("Mean", names(complete.dataset))
cols.std <- grep("Std", names(complete.dataset))

# col 1 = subject; col 2 = activity
cols.to.extract <- sort(c(1, 2, cols.mean, cols.std))
extracted.data <- complete.dataset[,cols.to.extract] 

# Calculate the means of each of the mean an std columns in extracted.data,
# grouped by subject and activity.
# This completes Requirement 5: From the data set in step 4, creates a second, independent 
#      tidy data set with the average of each variable for each activity and each subject.
tidy.data <- aggregate(extracted.data[,names(extracted.data) != c('subject','activity')],
                       by=list(activity = extracted.data$activity, subject = extracted.data$subject),
                       mean);
tidy.data <- tidy.data[,c(2,1,3:ncol(tidy.data))]

write.table(tidy.data, "tidy.txt", row.names = FALSE, quote = FALSE)

# Read back in with: data <- read.table("tidy.txt", header = TRUE)