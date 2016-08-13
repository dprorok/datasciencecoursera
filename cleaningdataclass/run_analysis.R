#Remember to source("project.R")

getData <- function(fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                    destfile = "./dataset.zip") {
     download.file(fileURL, destfile, method = "curl")
     dateDownloaded <- Sys.Date()
}

prepareDatasets <- function() {

     library(plyr)

     # Prepare a list of activity labels to use as activity factor levels.
     activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
     activity_factor_levels <- activity_labels[,2]


     # Read in y_train and y_test. Code the activity data with useful factor names from 
     # activity_factor_labels. Give columns a useful name.
     # This meets Requirement 3: Uses descriptive activity names to name the activities in the data set
     y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", colClasses="factor")
     y_train$V1 <- mapvalues(y_train$V1, from = levels(y_train$V1), to = activity_factor_levels)
     names(y_train) <- "activity"

     y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", colClasses="factor")
     y_test$V1 <- mapvalues(y_test$V1, from = levels(y_test$V1), to = activity_factor_levels)
     names(y_test) <- "activity"


     # Read in the feature labels.
     features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)


     # Read in the training and test datasets, X_train.txt and X_test.txt, respectively.
     # Give them meaningful column names from features.
     # This meets Requirement 4: Appropriately labels the data set with descriptive variable names.
     x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors=FALSE)
     names(x_train) <- features[,2]

     x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors=FALSE)
     names(x_test) <- features[,2]


     # Read in training subject IDs. Add column to identify dataset (train).
     # Give the columns meaningful names.
     # Repeat for the test dataset.
     # This further meets Requirement 4: Appropriately labels the data set with descriptive variable names.
     subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses="factor")
     subject_train <- cbind(subject_train, rep("train",length(subject_train$V1)))
     names(subject_train) <- c("subject", "dataset")

     subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses="factor")
     subject_test <- cbind(subject_test, rep("test",length(subject_test$V1)))
     names(subject_test) <- c("subject", "dataset")


     # Combine columns from the training and test datasets
     training_dataset <- cbind(subject_train, y_train, x_train)
     test_dataset <- cbind(subject_test, y_test, x_test)
     
     complete_dataset <- rbind(training_dataset, test_dataset)
}


extractMeanMeasurements <- function(data) {
     grep("mean", names(data))
}


run_analysis <- function() {
     # Complete Requirement 1: Merges the training and the test sets to create one data set.
     # Complete Requirement 3: Uses descriptive activity names to name the activities in the data set
     # Complete Requirement 4: Appropriately labels the data set with descriptive variable names.
     data <- prepareDatasets()

     # data is a large data.frame with 10299 observations (7352 from training and 2947 from testing)
     # and 564 variables. These variables include:
     #    * subject (from subject_*.txt)
     #    * dataset (factor of either "train" or "test", to indicate which dataset the data originated from)
     #    * activity (a factor with meaninful names extracted from activity_labels.txt)
     #    * the other 561 measurement variables from x_test.txt and x_train.txt and labeled
     #         with meaningful names from features.txt
     
     # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
     # 5. From the data set in step 4, creates a second, independent tidy data set with the 
     #       average of each variable for each activity and each subject.
}

# be sure to create a readme
#
# explain why this is tidy
# reference Hadley's paper
# articulate the tidy data criteria
# no NAs: sum(is.na.data.frame(data)) == 0 returns TRUE
# 1. Each variable forms a column
# 2. Each observation forms a row
# 3. Each table/file stores data about one kind of observation (in this case, sensor data
# from a Samsung blah blah phone used by different people/subjects)
#
# explain in the readme the pupose of all files (readme, R file, codebook, tidy data)
# explain how to read in the tidy dataset
#
#    data <- read.table(file_path, header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
#    View(data)
#
# explain that we are taking the most inclusive approach by including both data where 
# mean() and std() are at the end of the variable name and variables where mean is somewhere in
# the middle. This approach was chosen because the requirement was ambiguous and while it is
# trivial to quickly remove columns from a tidy dataset if more data than was desired is included,
# it is more involved fo the end user of the data to reconstruct data that was missing, but
# desired. As such, all conceivable variables were included with the expectation that superfuous
# ones can be removed by the user if desired.
#
# include a codebook with every variable defined