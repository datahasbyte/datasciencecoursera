library(dplyr)
# suppressWarnings()
rankall <- function(outcome_name, num = "best"){
  ## read outcome data
  outcome <- read.csv("outcome-of-care-measures.csv", stringsAsFactors = FALSE)
  function_string = paste("best(\"", "\", \"", outcome_name, "\")", sep = "")
  
  # check that state and outcome are valid
  # if(!(state_abb %in% outcome[,7])){
  #   return(cat(paste(function_string, ": invalid state"),sep=""))
  # }
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
  
  df_count <- outcome_tbl %>% filter(.[[col_num]] != "Not Available") %>% select(Hospital.Name, State, col_num)
  num_final <- case_when(
    num == "best" ~ as.character(1),
    num == "worst" ~ as.character(nrow(df_count)),
    TRUE ~ as.character(num)
  )
  num_final <- as.integer(num_final)
  
  outcome_tbl <- tbl_df(outcome)
  outcome_na <- outcome_tbl %>% filter(.[[col_num]] == "Not Available")
  outcome_na <- outcome_na %>% select(State, col_num, Hospital.Name) %>% arrange(Hospital.Name)
  outcome_na$rank <- NA
  outcome_tbl <- outcome_tbl %>% filter(.[[col_num]] != "Not Available")
  outcome_tbl[col_num] <- lapply(outcome_tbl[col_num], as.numeric)
  
  outcome_split <- split(outcome_tbl, outcome_tbl$State)
  outcome_split <- outcome_split %>% 
    select(State, col_num, Hospital.Name) %>%
    # filter(State == state_abb) %>%
    filter(.[[2]] != "Not Available") %>%
    arrange(.[[2]], Hospital.Name)
  
  outcome_split$rank <- rank(outcome_split[[2]], ties.method = "first")
  
  return_val <- as.character(outcome_split[num_final, c(Hospital.Name, State)])
  print(return_val)
  
}
