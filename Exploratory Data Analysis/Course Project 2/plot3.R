## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dir()

library(dplyr)
library(ggplot2)

png(file="./plot3.png")


baltimore_type <- NEI %>% subset(fips ==  '24510') %>% group_by(year, type) %>% summarize(sum=sum(Emissions))
p <- ggplot(data = baltimore_type, aes(x = year, y=sum))
p + geom_line() + facet_grid(type ~ .) +labs(title="PM2.5 Emissions in Baltimore 1999 to 2008")

dev.off()