rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that state and outcome are valid
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
        
        ## Setting new column names
        colnames(sub) <- c("hospital", "state", "rate")
        
        ## Setting rate column as numeric
        sub[,3] <- as.numeric(sub[,3])
        
        ## Order first by Rate and second by Name
        index <- with(sub, order(rate, hospital, na.last=NA))
        
        ## Check what num is
        if (is.numeric(num)) {
                rank <- sub[index[num], 1]
        } else if (num == "worst") {
                rank <- tail(sub[index, 1],1)
        } else if (num == "best") {
                rank <- sub[index[1], 1]
        }
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        return(rank)
        
}