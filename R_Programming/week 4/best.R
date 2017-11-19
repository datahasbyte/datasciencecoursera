setwd("E:\\Dropbox\\coursera\\R_Programming\\week 4\\rprog%2Fdata%2FProgAssignment3-data")
outcome <- read.csv("outcome-of-care-measures.csv")
head(outcome)
outcome[, 11] <- as.numeric(outcome[,11])
hist(outcome[,11])
names(outcome)
!("OH" %in% outcome[, 7])

library(dplyr)
suppressWarnings()
best <- function(state_abb, outcome_name){
  ## read outcome data
  outcome <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE)
  function_string = paste("best(\"", state_abb, "\", \"", outcome_name, "\")", sep = "")
  
  # check that state and outcome are valid
  if(!(state_abb %in% outcome[,7])){
    return(cat(paste(function_string, ": invalid state"),sep=""))
  }
  outcome_list = c("heart attack", "heart failure", "pneumonia")
  if(!(outcome_name %in% outcome_list)){
    return(cat(paste(function_string, ": invalid outcome"), sep=""))
  }
  
  # return hospital name in that state with lowest 30-day death rate
  col_num <- case_when(
    outcome_name == "heart attack" ~ 11,
    outcome_name == "heart failure" ~ 17,
    outcome_name == "pneumonia" ~ 23
  )
  col_num <- as.integer(col_num)
  
  outcome_tbl <- tbl_df(outcome)
  outcome_tbl <- outcome_tbl %>% filter(.[[col_num]] != "Not Available")
  outcome_tbl[col_num] <- lapply(outcome_tbl[col_num], as.numeric)
  
  outcome_tbl <- outcome_tbl %>% 
    select(State, col_num, Hospital.Name) %>%
    filter(State == state_abb) %>%
    filter(.[[2]] != "Not Available") %>%
    arrange(.[[2]], Hospital.Name)

    #View(outcome_tbl)
  
  return_val <- as.character(outcome_tbl$Hospital.Name[1])
  print(return_val)
  
}
