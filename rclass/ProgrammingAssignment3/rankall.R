rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")
        
        ## Check that outcome is valid
        if (!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))) {
                stop("invalid outcome")
        }
        
        ## For each state, find the hospital of the given rank
        state <- unique(data$State)
        state <- state[order(state)]

        hospital <- rep(NA, length(state))

        for (i in seq_along(state)) {
                state_data <- data[data$State == state[i], ]
                if (outcome == "heart attack") {
                        state_data <- state_data[order(suppressWarnings(as.numeric(state_data[, 11])), state_data[, 2]), ]
                        state_data <- state_data[!is.na(suppressWarnings(as.numeric(state_data[, 11]))), ]
                } else if (outcome == "heart failure") {
                        state_data <- state_data[order(suppressWarnings(as.numeric(state_data[, 17])), state_data[, 2]), ]
                        state_data <- state_data[!is.na(suppressWarnings(as.numeric(state_data[, 17]))), ]
                } else {
                        state_data <- state_data[order(suppressWarnings(as.numeric(state_data[, 23])), state_data[, 2]), ]
                        state_data <- state_data[!is.na(suppressWarnings(as.numeric(state_data[, 23]))), ]
                }
                
                if (num == "best") {
                        hospital[i] <- state_data[1, 2]
                } else if (num == "worst") {
                        hospital[i] <- state_data[nrow(state_data), 2]
                } else if (as.numeric(num) > nrow(state_data)) {
                        hospital[i] <- NA
                } else {
                        hospital[i] <- state_data[as.numeric(num), 2]
                }

        }

        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        data.frame(hospital, state)
}