pollutantmean <- function(directory, pollutant, id = 1:332) {

        # Create a vector of filenames in directory
        files_full <- list.files(directory, full.names=TRUE)

        # Create a vector of just the files we're interested in
        files_selected <- files_full[id]

        # Populate a big 'ol matrix with all the data from all the files of interest
        tmp <- vector(mode = "list", length = length(files_selected))
        tmp <- lapply(files_selected, read.csv)
        data <- do.call(rbind, tmp)
        
        # Calculate the mean of the pollutant we're interested in, ignoring missing data
        mean(data[, pollutant], na.rm = TRUE)
}