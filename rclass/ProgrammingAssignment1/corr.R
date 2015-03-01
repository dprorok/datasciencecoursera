corr <- function(directory, threshold = 0) {

        # Create a vector of filenames in directory
        files_full <- list.files(directory, full.names=TRUE)
        
        # Create a vector of just the files we're interested in
        complete_nobs_by_id <- complete(directory)
        ids_above_threshold <- which(complete_nobs_by_id$nobs > threshold)
        files_selected <- files_full[ids_above_threshold]

        # Create a vector to store results
        results <- vector(mode = "numeric", length = length(files_selected))
        
        # Walk through the selected files, sum the number of complete cases, and append to results
        for (i in seq_along(files_selected)) {
                data <- read.csv(files_selected[i])
                results[i] <- cor(data$sulfate, data$nitrate, use="complete.obs")
        }

        results

}