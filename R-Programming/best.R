## Author: John Letteboer
## Date: May 14, 2015
## --------------------------------------------
##  Programming Assignment 3: Hospital Quality 
## --------------------------------------------
## Finding the best hospital in a state
## This function take two arguments: the 2-character abbreviated name of a state and an outcome name.
## The function reads the outcome-of-care-measures.csv file and returns a character vector with the 
## name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome in 
## that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
## be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a 
## particular outcome should be excluded from the set of hospitals when deciding the rankings.

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