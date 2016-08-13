# Getting and Cleaning Data - Course Project

This is the course project for the Johns Hopkins University
Getting and Cleaning Data course offered through Coursera.

The project includes four files:

* `README.md` is the readme file you are currently reading.
This file includes a description of the files in the assignment
as well as some discussion of the data cleaning process and
the assumptions made along the way.

* `run_analysis.R` is the R script that does the data downloading
and cleaning to produce a tidy dataset. It does this by completing
the following steps:
     1. Download and unzip the dataset if it does not already
        exist in the current working directory
     2. Load the activity factor labels
     3. Load the training and test labels and assign them the factors
        from the activity factor labels.
     4. Load the feature labels.
     5. Load the training and test data and label their columns with
        the feature labels.
     6. Load the training and test subject IDs.
     7. Create a column in the subject IDs to keep track of which data
        are from the training set and which are from the test set. (Note:
        this turns out to be a superfluous step for this assignment
        but it is added as a useful identified in case I need this
        information later for another project.)
     8. Give subject ID columns useful column names (`subject` and `dataset`)
     9. Combine the subjects with the activity labels and the measurement
        data for the training and test datasets.
     10. Combine the training and test datasets into one dataset and
         order its contents by the subject ID and action.
     11. Create a new subsetted dataset that only contains measurement
         variables with `std` or `mean` in their names.  (Note: The most 
         inclusive approach was taken by including both data where
         `mean()` and `std()` are at the end of the variable name and 
         variables where `mean` is somewhere in the middle. This approach 
         was chosen because the requirement was ambiguous and while it is 
         trivial to quickly remove columns from a tidy dataset if more 
         data than were desired are included, it is more involved for the 
         end user of the data to reconstruct data that are missing, but 
         desired. As such, all conceivable variables were included with the 
         expectation that superfluous ones can be removed by the user if 
         desired.)
     12. Creates a new tidy dataset that includes the averages of the
         subsetted variables.
     13. Tidy dataset is written to the file `tidy.txt` in the working
         directory.


* `tidy.txt` is the result of running the `run_analysis.R` script. 
  It is tidy because it meets the three criteria for tidy data as
  referenced in Hadley Wickam's Tidy Data paper 
  `(http://vita.had.co.nz/papers/tidy-data.pdf)` Namely, this tidy 
  dataset has the following three criteria:
     1. Each variable forms a column
     2. Each observation forms a row
     3. Each table/file stores data about one kind of observation 
        (in this case, the average values of sensor data from several 
        Samsung Galaxy S smartphones.)

* `Codebook.md` describes the characteristics of the data in `tidy.txt`

In order to read in the tidy dataset into R, ensure it is in your
working directory and use the following commands:

`data <- read.table("tidy.txt", header = TRUE)`

`View(data)`