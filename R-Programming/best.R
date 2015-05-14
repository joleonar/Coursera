best <- function(state, outcome) {
        ## Turning off warnings
        options(warn=-1)
        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that state is valid
        if (state %in% data[, 7] == FALSE) {
                stop("invalid state")
        }
        
        ## Check that outcome is valid
        if (outcome == "heart attack") {
                sub <- subset(data, State == state, select = c(Hospital.Name, State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
        } else if (outcome == "heart failure") {
                sub <- subset(data, State == state, select = c(Hospital.Name, State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
        } else if (outcome == "pneumonia") {
                sub <- subset(data, State == state, select = c(Hospital.Name, State, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
        } else {
                stop("invalid outcome")
        }
        
        ## Set comlumn to numeric so we can calculate
        sub[,3] <- as.numeric(sub[,3])
        
        ## Defining the minimum value and sort it alphabetically
        min <- sort(sub[which(sub[, 3] == min(sub[, 3], na.rm = TRUE)), 1])

        ## Return the first hospital name in that state with lowest 30-day death rate
        return(head(min))
}