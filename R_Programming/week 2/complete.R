complete <- function(directory, id=1:332){
    files <- vector()
    for(item in id){
        if (nchar(item)<2){
            files <- c(files,paste(paste("00",item, sep=""),".csv",sep=""))
        } 
        else if(nchar(item)<3){
            files <- c(files,paste(paste("0",item, sep=""),".csv",sep=""))
        } 
        else{
            files <- c(files,paste(item,".csv",sep=""))
        }
    }
    
    fileslist <- unlist(files)
    start <- end <- 0
    
    df <- data.frame()
    return_df <- data.frame(id=numeric(), nobs=numeric())
    value_count <- numeric()
    for(file in seq_along(fileslist)){
        temp_df <- read.csv(paste(directory,"/",fileslist[file],sep=""))
        value_count[file] <- 0
        for(i in seq_along(temp_df$ID)){
            if(!is.na(temp_df$sulfate[i]) && !is.na(temp_df$nitrate[i])){
                value_count[file] <- value_count[file] + 1
            }
        }
        bind_df <- cbind(id=id[file], nobs=value_count[file])
        return_df <- rbind(return_df, bind_df)
        df <- rbind(df, temp_df)
    }
    unclass(value_count)
    return_df
}