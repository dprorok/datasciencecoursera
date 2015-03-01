best <- function(state, outcome) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", 
                         colClasses = "character")

        ## Check that state and outcome are valid
        if (!is.element(state, data$State)) {
                stop("invalid state")
        }
        if (!is.element(outcome, c("heart attack", "heart failure", "pneumonia"))) {
                stop("invalid outcome")
        }

        ## Return hospital name in that state with the lowest 30-day death
        ## rate
        state_data <- data[data$State == state, ]
        
        if (outcome == "heart attack") {
                state_data <- state_data[order(suppressWarnings(as.numeric(state_data[, 11])), state_data[, 2]), ]
        } else if (outcome == "heart failure") {
                state_data <- state_data[order(suppressWarnings(as.numeric(state_data[, 17])), state_data[, 2]), ]
        } else {
                state_data <- state_data[order(suppressWarnings(as.numeric(state_data[, 23])), state_data[, 2]), ]
        }
        
        state_data[1, 2]
}