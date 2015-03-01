complete <- function(directory, id = 1:332) {

        # Create a vector of filenames in directory
        files_full <- list.files(directory, full.names=TRUE)
        
        # Create a base data frame
        results <- data.frame()

        # Walk through the selected files, sum the number of complete cases, and append to results
        for (i in id) {
                dat <- read.csv(files_full[i])
                results <- rbind(results, c(i, sum(complete.cases(dat$sulfate, dat$nitrate))))
        }

        # Give the columns some names
        colnames(results) <- c("id", "nobs")

        results
}