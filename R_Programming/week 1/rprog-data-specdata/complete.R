complete <- function(directory, id=1:332){
	files_full <-list.files(directory, full.names=TRUE)
	tmp <- vector(mode="list", length=length(files_full))
	for (i in seq_along(files_full)) {
		tmp[[i]] <- read.csv(files_full[[i]])
		}
	output <- do.call(rbind, tmp)
	complete_id <- complete.cases(output[which(output[, "ID"] %in% id),])
	##output2 <- data.frame(id, )
	##names(output2) < c("id", "nobs")	
	##output2
	complete_id
}
