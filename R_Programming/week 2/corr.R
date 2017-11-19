corr <- function(directory, threshold=0){
    files <- vector()
    complete_files <- complete(directory)
    print(complete_files)
    id_list <- numeric()
    for(i in complete_files$id){
        id_list <- rbind(id_list, i)
    }
    for(item in id_list){
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
    cor_vector <- numeric()
    for(file in seq_along(fileslist)){
        temp_df <- read.csv(paste(directory,"/",fileslist[file],sep=""))
        value_count[file] <- 0
        for(i in seq_along(temp_df$ID)){
            if(!is.na(temp_df$sulfate[i]) && !is.na(temp_df$nitrate[i])){
                value_count[file] <- value_count[file] + 1
            }
        }
        bind_df <- cbind(id=id_list[file], nobs=value_count[file])
        return_df <- rbind(return_df, bind_df)
        if(value_count[file] > threshold){
            cor_value <- cor(temp_df$sulfate, temp_df$nitrate, use='complete.obs')
            cor_vector <- rbind(cor_vector, cor_value)
            df <- rbind(df, temp_df)
        }
    }
    cor_vector
}