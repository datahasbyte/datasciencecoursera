## Question 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, "E:\\Downloads\\hid.csv")
csv_file <- read.csv("E:\\Downloads\\hid.csv")
csvdf <- tbl_df(csv_file)

agricultureLogical <- csv_file$AGS == 6
agricultureLogical
which(agricultureLogical)


## Question 2
jpegUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
install.packages("jpeg")
library(jpeg)
download.file(jpegUrl, "E:\\Downloads\\jeff.jpg", mode="wb")
jpegFile <- readJPEG("E:\\Downloads\\jeff.jpg", native=TRUE)
quantile(jpegFile, probs=c(0.30, 0.80))
if(exists("rasterImage")){
  plot(1:2, type='n')
  rasterImage(jpegFile,1,1,2,2)
}

## Question 3
GDPUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
CountryUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
GDP <- read.csv(GDPUrl, skip = 4, header = TRUE)
head(GDP)
names(GDP)
GDP_Names <- c("CountryCode", "Ranking", "?", "Economy", "US.dollars.", "2", "3", "4", "5")
names(GDP) <- GDP_Names
GDP <- GDP[, c("CountryCode", "Ranking", "Economy", "US.dollars.")]
GDP <- tbl_df(GDP)
GDP <- GDP[1:190,]
tail(GDP)
Country <- read.csv(CountryUrl)
Country <- tbl_df(Country)
head(Country)

mergeDf <- merge(GDP, Country, by.x="CountryCode", by.y = "CountryCode")
filter(mergeDf, CountryCode == "USA")
head(mergeDf)
mergeDf <- tbl_df(mergeDf)
dim(mergeDf)
selectedFromMerge <- select(mergeDf, CountryCode, Long.Name, Ranking)
filter(selectedFromMerge, CountryCode == "USA")
selectedFromMerge$Ranking <- as.character(selectedFromMerge$Ranking)
selectedFromMerge$Ranking <- as.integer(selectedFromMerge$Ranking)
selectedFromMerge <- selectedFromMerge %>% arrange(desc(Ranking))
selectedFromMerge[13,]


## Question 4
grouped_df <- group_by(mergeDf, Income.Group)
grouped_df
grouped_df$Ranking <- as.character(grouped_df$Ranking)
grouped_df$Ranking <- as.integer(grouped_df$Ranking)
grouped_df2 <- summarize(grouped_df, avg_income = mean(Ranking))
grouped_df2

## Question 5
quantiles <- quantile(grouped_df$Ranking, probs=seq(0, 1, 0.2))
quantiles
grouped_df3 <- grouped_df3 %>% mutate()

grouped_df$IncomeGroups = cut(grouped_df$Ranking, breaks=quantile(grouped_df$Ranking, probs=seq(0, 1, 0.2)))
table(grouped_df$IncomeGroups,grouped_df$Income.Group)
quantiles
