## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
dir()

library(dplyr)
library(ggplot2)

png(file="./plot4.png")

names(SCC)
names(NEI)
intersect(names(SCC),names(NEI))
coal <- SCC[grepl('Coal', SCC$EI.Sector),]
merged_df <- merge(coal, NEI)
coal_counts <- merged_df %>% group_by(year) %>% summarize(sum=sum(Emissions))
p <- ggplot(data=coal_counts, aes(x=year, y=sum))
p + geom_line() + labs(title = "Coal Combustion-related Emissions 1999 to 2008")

dev.off()