pollutantmean <- function(directory, pollutant='nitrate', id = 1:332){
    results <- list()
    # for(i in id){
    #     input <- read.csv(paste(directory,"/",i,sep=""))
    #     returns <- lappy(input$pollutant, mean, na.rm=TRUE)
    #     results.append(returns)
    # }
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
    
    filevector <- numeric()
    for(file in seq_along(fileslist)){
        df <- read.csv(paste(directory,"/",fileslist[file],sep=""))
        filevector[file] <- df[pollutant]
    }
    filevec <- unlist(filevector)
    mean(filevec, na.rm=TRUE)
}

#t <- tdf[tdf[,'ID'] == 1,]