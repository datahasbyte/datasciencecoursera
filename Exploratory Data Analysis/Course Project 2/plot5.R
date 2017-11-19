## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dir()

library(dplyr)
library(ggplot2)

png(file="./plot5.png")

vehicles <- SCC[grepl('Vehicle', SCC$EI.Sector),]
baltimore_fips <- NEI %>% subset(fips == "24510")
baltimore_vehicles <- merge(baltimore_fips, vehicles)
baltimore_vehicles_summary <- baltimore_vehicles %>% group_by(year, type) %>% summarize(sum=sum(Emissions))
p <- ggplot(data=baltimore_vehicles_summary, aes(x=year, y=sum))
p + geom_line() + labs(title = "Baltimore Motor Vehicle Emissions 1999 to 2008")

dev.off()