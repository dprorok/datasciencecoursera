# Code Book
This code book summarizes the details for the data in the tidy dataset.

##Identifiers
* `activity` - A factor indicating which of six possible activities are in progress when measurements are taken. The factor levels are:
     1. WALKING
     2. WALKING_UPSTAIRS
     3. WALKING_DOWNSTAIRS
     4. SITTING
     5. STANDING
     6. LAYING
* `subject` - ID number of the person performing the activity.
     * ID numbers range from 1-30, inclusive.

##Measurements
The measurement values in this dataset are **means by activity and subject** of the original data provided in the Human Activity Recognition Using Smartphones Dataset at `http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones`
The activity and test datasets have been combined into one dataset containing the original 30 participants. Mean and Standard deviation measurements have then been averaged for each of the 180 combinations of 30 participants and 6 activities.

The following is a general description of the original measurement data is provided verbatim from the website above. (Italics indicates quoted material):

*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments had been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.* 

*The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.*

*The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.*

*Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).*

*Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).*

*Features are normalized and bounded within [-1,1]*

Special characters have been removed from the original dataset variable names due to limitations in R's ability to preserve them during the import process. The list below are the new variable names along with a description of the measurement. Note again that this dataset provides **means** of each of these values for each of the 180 combinations of subject and activity. The original dataset provided actual individual measurments.

* `tBodyAccMeanX` - Time domain body acceleration mean, X-axis
* `tBodyAccMeanY` - Time domain body acceleration mean, Y-axis
* `tBodyAccMeanZ` - Time domain body acceleration mean, Z-axis
* `tBodyAccStdX` - Time domain body acceleration standard deviation, X-axis
* `tBodyAccStdY` - Time domain body acceleration standard deviation, Y-axis
* `tBodyAccStdZ` - Time domain body acceleration standard deviation, Z-axis
* `tGravityAccMeanX` - Time domain gravity acceleration mean, X-axis
* `tGravityAccMeanY` - Time domain gravity acceleration mean, Y-axis
* `tGravityAccMeanZ` - Time domain gravity acceleration mean, Z-axis
* `tGravityAccStdX` - Time domain gravity acceleration standard deviation, X-axis
* `tGravityAccStdY` - Time domain gravity acceleration standard deviation, Y-axis
* `tGravityAccStdZ` - Time domain gravity acceleration standard deviation, Z-axis
* `tBodyAccJerkMeanX` - Time domain body acceleration jerk mean, X-axis
* `tBodyAccJerkMeanY` - Time domain body acceleration jerk mean, Y-axis
* `tBodyAccJerkMeanZ` - Time domain body acceleration jerk mean, Z-axis
* `tBodyAccJerkStdX` - Time domain body acceleration jerk standard deviation, X-axis
* `tBodyAccJerkStdY` - Time domain body acceleration jerk standard deviation, Y-axis
* `tBodyAccJerkStdZ` - Time domain body acceleration jerk standard deviation, Z-axis
* `tBodyGyroMeanX` - Time domain body gyroscope mean, X-axis
* `tBodyGyroMeanY` - Time domain body gyroscope mean, Y-axis
* `tBodyGyroMeanZ` - Time domain body gyroscope mean, Z-axis
* `tBodyGyroStdX` - Time domain body gyroscope standard deviation, X-axis
* `tBodyGyroStdY` - Time domain body gyroscope standard deviation, Y-axis
* `tBodyGyroStdZ` - Time domain body gyroscope standard deviation, Z-axis
* `tBodyGyroJerkMeanX` - Time domain body gyroscope jerk mean, X-axis
* `tBodyGyroJerkMeanY` - Time domain body gyroscope jerk mean, Y-axis
* `tBodyGyroJerkMeanZ` - Time domain body gyroscope jerk mean, Z-axis
* `tBodyGyroJerkStdX` - Time domain body gyroscope jerk standard deviation, X-axis
* `tBodyGyroJerkStdY` - Time domain body gyroscope jerk standard deviation, Y-axis
* `tBodyGyroJerkStdZ` - Time domain body gyroscope jerk standard deviation, Z-axis
* `tBodyAccMagMean` - Time domain body acceleration magnitude mean
* `tBodyAccMagStd` - Time domain body acceleration magnitude standard deviation
* `tGravityAccMagMean` - Time domain gravity acceleration magnitude mean
* `tGravityAccMagStd` - Time domain gravity acceleration magnitude standard deviation
* `tBodyAccJerkMagMean` - Time domain body acceleration jerk magnitude mean
* `tBodyAccJerkMagStd` - Time domain body acceleration jerk magnitude standard deviation
* `tBodyGyroMagMean` - Time domain body gyroscope magnitude mean
* `tBodyGyroMagStd` - Time domain body gyroscope magnitude standard deviation
* `tBodyGyroJerkMagMean` - Time domain body gyroscope jerk magnitude mean
* `tBodyGyroJerkMagStd` - Time domain body gyroscope jerk magnitude standard deviation
* `fBodyAccMeanX` - Frequency domain body acceleration mean, X-axis
* `fBodyAccMeanY` - Frequency domain body acceleration mean, Y-axis
* `fBodyAccMeanZ` - Frequency domain body acceleration mean, Z-axis
* `fBodyAccStdX` - Frequency domain body acceleration standard deviation, X-axis
* `fBodyAccStdY` - Frequency domain body acceleration standard deviation, Y-axis
* `fBodyAccStdZ` - Frequency domain body acceleration standard deviation, Z-axis
* `fBodyAccMeanFreqX` - Frequency domain body acceleration mean frequency, X-axis
* `fBodyAccMeanFreqY` - Frequency domain body acceleration mean frequency, Y-axis
* `fBodyAccMeanFreqZ` - Frequency domain body acceleration mean frequency, Z-axis
* `fBodyAccJerkMeanX` - Frequency domain body acceleration jerk mean, X-axis
* `fBodyAccJerkMeanY` - Frequency domain body acceleration jerk mean, Y-axis
* `fBodyAccJerkMeanZ` - Frequency domain body acceleration jerk mean, Z-axis
* `fBodyAccJerkStdX` - Frequency domain body acceleration jerk standard deviation, X-axis
* `fBodyAccJerkStdY` - Frequency domain body acceleration jerk standard deviation, Y-axis
* `fBodyAccJerkStdZ` - Frequency domain body acceleration jerk standard deviation, Z-axis
* `fBodyAccJerkMeanFreqX` - Frequency domain body acceleration jerk mean frequency, X-axis
* `fBodyAccJerkMeanFreqY` - Frequency domain body acceleration jerk mean frequency, Y-axis
* `fBodyAccJerkMeanFreqZ` - Frequency domain body acceleration jerk mean frequency, Z-axis
* `fBodyGyroMeanX` - Frequency domain body gyroscope mean, X-axis
* `fBodyGyroMeanY` - Frequency domain body gyroscope mean, Y-axis
* `fBodyGyroMeanZ` - Frequency domain body gyroscope mean, Z-axis
* `fBodyGyroStdX` - Frequency domain body gyroscope standard deviation, X-axis
* `fBodyGyroStdY` - Frequency domain body gyroscope standard deviation, Y-axis
* `fBodyGyroStdZ` - Frequency domain body gyroscope standard deviation, Z-axis
* `fBodyGyroMeanFreqX` - Freqency domain body gyroscope mean frequency, X-axis
* `fBodyGyroMeanFreqY` - Freqency domain body gyroscope mean frequency, Y-axis
* `fBodyGyroMeanFreqZ` - Freqency domain body gyroscope mean frequency, Z-axis
* `fBodyAccMagMean` - Frequency domain body acceleration magnitude mean
* `fBodyAccMagStd` - Frequency domain body acceleration magnitude standard deviation
* `fBodyAccMagMeanFreq` - Frequency domain body acceleration magnitude mean frequency
* `fBodyBodyAccJerkMagMean` - Frequency domain body acceleration jerk magnitude mean
* `fBodyBodyAccJerkMagStd` - Frequency domain body acceleration jerk magnitude standard deviation
* `fBodyBodyAccJerkMagMeanFreq` - Frequency domain body acceleration jerk magnitude mean frequency
* `fBodyBodyGyroMagMean` - Frequency domain body gyroscope magnitude mean
* `fBodyBodyGyroMagStd` - Frequency domain body gyroscope magnitude standard deviation
* `fBodyBodyGyroMagMeanFreq` - Frequency domain body gyroscope magnitude mean frequency
* `fBodyBodyGyroJerkMagMean` - Frequency domain body gyroscope jerk magnitude mean
* `fBodyBodyGyroJerkMagStd` - Frequency domain body gyroscope jerk magnitude standard deviation
* `fBodyBodyGyroJerkMagMeanFreq` - Frequency domain body gyroscope jerk magnitude mean frequency
* `angletBodyAccMean.gravity` - Time domain angle between body acceleration mean and gravity mean vectors
* `angletBodyAccJerkMean.gravityMean` - Time domain angle between body acceleration jerk mean and gravity mean vectors
* `angletBodyGyroMean.gravityMean` - Time domain angle between body gyroscope mean and gravity mean vectors
* `angletBodyGyroJerkMean.gravityMean` - Time domain angle between body gyroscope jerk mean and gravity mean vectors
* `angleX.gravityMean` - Angle between X-axis and gravity mean vector
* `angleY.gravityMean` - Angle between Y-axis and gravity mean vector
* `angleZ.gravityMean` - Angle between Z-axis and gravity mean vector
