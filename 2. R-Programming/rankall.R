rankall <- function(outcome, num = "best") {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Setting rate column as numeric
        for (i in c(11,17,23)) {
                data[,i] <- as.numeric(data[,i])
        }
        
        ## Check if outcome is valid
        if (outcome == "heart attack") {
                sub <- split(data[, c("Hospital.Name", "State", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack")], data$State)
        } else if (outcome == "heart failure") {
                sub <- split(data[, c("Hospital.Name", "State", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure")], data$State)
        } else if (outcome == "pneumonia") {
                sub <- split(data[, c("Hospital.Name", "State", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")], data$State)
        } else {
                stop("invalid outcome")
        }
        
        ## For each state, find the hospital of the given rank
        ranking <- function(data_of_state, num) {
                ord_data_of_state <- order(data_of_state[3], data_of_state[1], na.last=NA)
                ## Check what num is
                if (is.numeric(num)) {
                        data_of_state$Hospital.Name[ord_data_of_state[num]]
                } else if (num == "worst") {
                        data_of_state$Hospital.Name[ord_data_of_state[length(ord_data_of_state)]]
                } else if (num == "best") {
                        data_of_state$Hospital.Name[ord_data_of_state[1]]
                }         
        }
        
        ## Return a data frame with the hospital names and the (abbreviated) state name
        pre_result <- lapply(sub, ranking, num)
        data.frame(hospital = unlist(pre_result), state = names(pre_result), row.names = names(pre_result))
}