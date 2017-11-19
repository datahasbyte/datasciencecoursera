pollutantmean <- function(directory, pollutant, id=1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
	files_full <- list.files(directory, full.names= TRUE)
	tmp <- vector(mode="list", length=length(files_full))
	for (i in seq_along(files_full)) {
		tmp[[i]] <- read.csv(files_full[[i]])
		}
	output <- do.call(rbind, tmp)
	round(mean(output[which(output[, "ID"] %in% id), pollutant], na.rm=TRUE), digits=3)
}

  
