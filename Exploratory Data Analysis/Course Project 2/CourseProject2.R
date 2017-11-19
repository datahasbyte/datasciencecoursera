#setwd('/home/ajc/Dropbox/coursera/Exploratory Data Analysis/Course Project 2/')
setwd('E:/Dropbox/coursera/Exploratory Data Analysis/Course Project 2/')

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dir()

library(dplyr)

# Q1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
year_sum <- NEI %>% group_by(year) %>% summarize(sum=sum(Emissions))
with(year_sum, plot(year, sum))

# Q2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
baltimore <- NEI %>% subset(fips ==  '24510') %>% group_by(year) %>% summarize(sum=sum(Emissions))
with(baltimore, plot(year, sum))

# Q3 
library(ggplot2)
baltimore_type <- NEI %>% subset(fips ==  '24510') %>% group_by(year, type) %>% summarize(sum=sum(Emissions))
p <- ggplot(data = baltimore_type, aes(x = year, y=sum))
p + geom_line() + facet_grid(type ~ .)

# Q4
names(SCC)
names(NEI)
intersect(names(SCC),names(NEI))
coal <- SCC[grepl('Coal', SCC$EI.Sector),]
merged_df <- merge(coal, NEI)
coal_counts <- merged_df %>% group_by(year) %>% summarize(sum=sum(Emissions))
p <- ggplot(data=coal_counts, aes(x=year, y=sum))
p + geom_line()

# Q5
vehicles <- SCC[grepl('Vehicle', SCC$EI.Sector),]
baltimore_fips <- NEI %>% subset(fips == "24510")
intersect(vehicles, baltimore_fips)
baltimore_vehicles <- merge(baltimore_fips, vehicles)
baltimore_vehicles_summary <- baltimore_vehicles %>% group_by(year, type) %>% summarize(sum=sum(Emissions))
p <- ggplot(data=baltimore_vehicles_summary, aes(x=year, y=sum))
p + geom_line()


#Q6 
la_fips <- NEI %>% subset(fips == "06037")
la_vehicles <- merge(la_fips, vehicles)
la_vehicles_summary <- la_vehicles %>% group_by(year, type) %>% summarize(sum=sum(Emissions))
la_vehicles_summary <-la_vehicles_summary[la_vehicles_summary$type != 'POINT',]
la_vehicles_summary$city <- 'Los Angeles'
baltimore_vehicles_summary$city <- 'Baltimore'
city_vehicles_summary <- rbind(la_vehicles_summary, baltimore_vehicles_summary)
ggplot(data=city_vehicles_summary, aes(x=year, y=sum, color=city)) + geom_line(aes(size=sum))
