## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dir()

library(dplyr)
library(ggplot2)

png(file="./plot6.png")

#Q6 
la_fips <- NEI %>% subset(fips == "06037")
la_vehicles <- merge(la_fips, vehicles)
la_vehicles_summary <- la_vehicles %>% group_by(year, type) %>% summarize(sum=sum(Emissions))
la_vehicles_summary <-la_vehicles_summary[la_vehicles_summary$type != 'POINT',]
la_vehicles_summary$city <- 'Los Angeles'
baltimore_vehicles_summary$city <- 'Baltimore'
city_vehicles_summary <- rbind(la_vehicles_summary, baltimore_vehicles_summary)
ggplot(data=city_vehicles_summary, aes(x=year, y=sum, color=city)) + geom_line(aes(size=sum)) + labs(title = "Motor Vehicle Emissions Baltimore v Los Angeles 1999 to 2008")

dev.off()