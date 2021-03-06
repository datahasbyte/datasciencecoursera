## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dir()

library(dplyr)

# Q1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
png(file="./plot1.png")

year_sum <- NEI %>% group_by(year) %>% summarize(sum=sum(Emissions))
with(year_sum, plot(year, sum, type = 'l', main = "PM2.5 Emissions in U.S. 1999 to 2008"))

dev.off()