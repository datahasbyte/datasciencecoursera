fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
surveydata <- read.csv(fileUrl)
surveydata <- strsplit(names(surveydata), "wgtp")
surveydata[123]

# Q2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdp <- read.csv(fileUrl, skip = 5, header=FALSE, stringsAsFactors = FALSE)
names(gdp)
names_list <- c("Country", "Ranking", "Blank", "Economy", "USD")
names(gdp) <- names_list
gdp <- gdp[1:5]
gdp <- gdp[1:190,]

gdp$USD <- gsub(",","",gdp$USD)

gdp$USD <- as.numeric(gdp$USD)
mean(gdp$USD, na.rm = TRUE)

# Q3

grep("*United",gdp$Country)
grep("United$",gdp$Country)
grep("^United",gdp$Country)
grep("*United",gdp$Country)

# Q4
edUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
eddata <- read.csv(edUrl)
names(eddata)
eddata$CountryCode
gdp$Country
new <- merge(gdp, eddata, by.x="Country", by.y="CountryCode")
head(new)
names(new)

june <- new[grep("June", new$Special.Notes),]
june
nrow(june)

regex <- /^.*?\bcat\b.*?\bmat\b.*?$/m
w1 < "end"
w2 <- "June"
june2 <- new[gsub(".* w1.* w2.*", "\\1", new$Special.Notes),]
june2
class(june2)
nrow(june2)
str(june2)
june2 <- june2[is.na(june2$Latest.trade.data),]
nrow(june2)
sum(!is.na(june2))
june2

# Q5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
head(sampleTimes)
years <- year(sampleTimes)
years
years_match <- grepl(2012, years)
years_match
sum(years_match)
