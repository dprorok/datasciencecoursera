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
     2. Loads all of the necessary data into R.
     3. Remove special characters from feature names since they won't
        survive a reimport via read.table.
     4. Combine subject, activity, and measurement columns for test
        and train datasets.
     5. Merge test and train datasets. **(Requirement 1)**
     6. Name the columns. **(Requirement 4)**
     7. Map activities to meaningful names. **(Requirement 3)**
     8. Sort the dataset by subject and activity.
     9. Create a new subsetted dataset that only contains measurement
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
        desired.) **(Requirement 2)**
     10. Creates a new tidy dataset that includes the averages of the
         subsetted variables. **(Requirement 5)**
     11. Tidy dataset is written to the file `tidy.txt` in the working
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
