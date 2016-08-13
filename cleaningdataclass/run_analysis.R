#ToDo: Create a code book

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


# Prepare a list of activity labels to use as activity factor levels.
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
activity.factor.levels <- activity.labels[,2]


# Read in the labels from y_train and y_test. Code the activity data with useful factor names from 
# activity_factor_labels. Give columns a useful name.
# This completes Requirement 3: Uses descriptive activity names to name the activities in the data set
train.labels <- read.table("./UCI HAR Dataset/train/y_train.txt", colClasses="factor")
train.labels$V1 <- mapvalues(train.labels$V1, from = levels(train.labels$V1), to = activity.factor.levels)
names(train.labels) <- "activity"

test.labels <- read.table("./UCI HAR Dataset/test/y_test.txt", colClasses="factor")
test.labels$V1 <- mapvalues(test.labels$V1, from = levels(test.labels$V1), to = activity.factor.levels)
names(test.labels) <- "activity"

# Read in the feature labels. Strip out special characters.
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
features$V2 <- gsub('-mean', 'Mean', features$V2)
features$V2 <- gsub('-std', 'Std', features$V2)
features$V2 <- gsub('[-()]', '', features$V2)
features$V2 <- gsub(',', '.', features$V2)

# Read in the training and test datasets
test.measurements <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors=FALSE)
train.measurements <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors=FALSE)

# Give measurements meaningful column names from features.
# This completes Requirement 4: Appropriately labels the data set with descriptive variable names.
names(test.measurements) <- features[,2]
names(train.measurements) <- features[,2]

# Read in subject IDs.
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses="factor")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses="factor")

# Add column to identify dataset (test or train)
test.subject <- cbind(test.subject, rep("test",length(test.subject$V1)))
train.subject <- cbind(train.subject, rep("train",length(train.subject$V1)))

# Give the columns meaningful names.
# This further completes Requirement 4: Appropriately labels the data set with descriptive variable names.
names(test.subject) <- c("subject", "dataset")
names(train.subject) <- c("subject", "dataset")

# Combine columns from the training and test datasets
train.dataset <- cbind(train.subject, train.labels, train.measurements)
test.dataset <- cbind(test.subject, test.labels, test.measurements)

# Combine train and test datasets and then sort by subject and activity
# This completes Requirement 1: Merges the training and the test sets to create one data set.
complete.dataset <- rbind(train.dataset, test.dataset)
complete.dataset$subject <- as.integer(complete.dataset$subject)
complete.dataset <- complete.dataset[ order(complete.dataset$subject, complete.dataset$activity), ]
complete.dataset$subject <- as.factor(complete.dataset$subject)

# The below completes Requirement 2: Extracts only the measurements on the mean and 
#    standard deviation for each measurement.
# Choosing the broadest interpretation of "mean" to include calculations that are means
# (typically ending in "mean()") as well as calculations based on means, such as
# those ending in "meanFreq()" or including means such as "gravityMean." The intent
# was unclear so I opted for the broadest interpretation, figuring that it's easier to
# later subset out superfluous columns than it is to reclean the data to put incorrectly
# deleted data back in.
cols.mean <- grep("[Mm][Ee][Aa][Nn]", names(complete.dataset))
cols.std <- grep("[Ss][Tt][Dd]", names(complete.dataset))

# col 1 = subject; col 2 = dataset; col 3 = activity
# we don't need to know original dataset, so it is dropped below
cols.to.extract <- c(1, 3, cols.mean, cols.std)
cols.to.extract <- sort(cols.to.extract)
extracted.data <- complete.dataset[,cols.to.extract] 

# Calculate the means of each of the mean an std columns in extracted.data,
# grouped by subject and activity.
# This completes Requirement 5: From the data set in step 4, creates a second, independent 
#      tidy data set with the average of each variable for each activity and each subject.
tidy.data <- aggregate(extracted.data[,names(extracted.data) != c('subject','activity')],
                       by=list(activity = extracted.data$activity, subject = extracted.data$subject),
                       mean);

write.table(tidy.data, "tidy.txt", row.names = FALSE, quote = FALSE)

# Read back in with: data <- read.table("tidy.txt", header = TRUE)