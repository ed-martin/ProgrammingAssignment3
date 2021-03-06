getwd()

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome) 
outcome[, 11] <- as.numeric(outcome[, 11])



best <- function(state, outcome) {

outcomes = c("heart attack", "heart failure", "pneumonia")
if( outcome %in% outcomes == FALSE ) stop("invalid outcome")

## Read outcome data
data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

## Filter and simplify the column names
	data <- data[c(2, 7, 11, 17, 23)]
	names(data)[1] <- "name"
	names(data)[2] <- "state"
	names(data)[3] <- "heart attack"
	names(data)[4] <- "heart failure"
	names(data)[5] <- "pneumonia"

    ## Validate the state string
    states <- data[, 2]
    states <- unique(states)
    if( state %in% states == FALSE ) stop("invalid state")

    ## Grab only rows with our state value	
    data <- data[data$state==state & data[outcome] != 'Not Available', ]
    vals <- data[, outcome]
    rowNum <- which.min(vals)
	## Return hospital name in that state with lowest 30-day death rate
    data[rowNum, ]$name
} 
***Save best.R***

source("best.R") 
best("TX", "heart attack")

best("TX", "heart failure")

best("MD", "heart attack")

best("MD", "pneumonia")
best("BB", "heart attack") 
best("NY", "hert attack")
