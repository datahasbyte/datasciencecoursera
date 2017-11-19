url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
file <- read.csv(url, stringsAsFactors = FALSE)
head(file)

library(dplyr)
file2 <- tbl_df(file)
selected <- select(file2, SERIALNO, VAL)
selected

a <- filter(selected, VAL > 1000000)

summarize()


xlsx_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
library(xlsx)
install.packages("xlsx")
xlsx <- read.xlsx(xlsx_url, 1, package = "xlsx")
read.xlsx2(xlsx_url, 1)

install.packages("XLConnect")
con <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(con, "xlsxFile.xlsx", mode="wb")
xlsx <- read.xlsx("xlsxFile.xlsx", 1)
xlsx <- read.xlsx("xlsxFile.xlsx", 1)
head(xlsx)
df <- tbl_df(xlsx)
header <- xlsx[17,7:15]
list(header)
ddf <- xlsx[18:23, 7:15]
df <- tbl_df(ddf)


# Question 3
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="E:\\Downloads\\data.xlsx", mode="wb")
dateDownloaded <- today()
library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("E:\\Downloads\\data.xlsx", 1, colIndex = colIndex, rowIndex = rowIndex, header=TRUE)
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4
install.packages("XML")
library(XML)
library(RCurl)
xmlUrl <- getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
restData <- xmlTreeParse(xmlUrl, useInternal=TRUE)
rootNode <- xmlRoot(restData)
xmlName(rootNode)
zips <- xpathSApply(rootNode, "//zipcode", xmlValue)
library(dplyr)
zips_df <- as_tibble(zips)
subset(zips_df, value=='21231')
subset(zips_df, value=='21231') %>% summarize(n()) %>% print

# Question 5
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
DT <- fread(fileUrl)

start_time <- Sys.time()
# rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
# DT[,mean(pwgtp15),by=SEX]
# mean(DT$pwgtp15,by=DT$SEX)
# sapply(split(DT$pwgtp15,DT$SEX),mean)
# mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
tapply(DT$pwgtp15,DT$SEX,mean)
end_time <- Sys.time()
end_time - start_time