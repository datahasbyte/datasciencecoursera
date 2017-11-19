## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dir()

library(dplyr)
png(file="./plot2.png")

# Q2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
baltimore <- NEI %>% subset(fips ==  '24510') %>% group_by(year) %>% summarize(sum=sum(Emissions))
with(baltimore, plot(year, sum, type='l', main = "PM2.5 Emissions in Baltimore 1999 to 2008"))

dev.off()