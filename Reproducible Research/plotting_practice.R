# Optional Plotting Practice
library(ggplot2)

setwd("E:\\Dropbox\\coursera\\Reproducible Research")
data <- read.csv("payments.csv")
inpatient <- read.csv("Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2011.csv")
head(inpatient)
names(inpatient)
head(inpatient$Provider.State)
ny <- subset(data, Provider.State == "NY")
head(ny)
dim(ny)
sum(is.na(ny$Average.Total.Payments))
class(ny$Average.Covered.Charges)


pdf(file=".\\plot1.pdf")
p <- ggplot(ny, aes(Average.Covered.Charges, Average.Total.Payments))
p + geom_point()
dev.off()

pdf(file=".\\plot2.pdf")
q <- ggplot(data, aes(Average.Covered.Charges, Average.Total.Payments))
q + 
  geom_point(aes(colour=factor(DRG.Definition))) +
  facet_grid(. ~ Provider.State) +
  theme(legend.position="bottom", legend.text=element_text(size=5), legend.background = element_rect(fill=alpha(colour = "black", 0.2))) +
  theme(axis.text.x=element_blank()) +
  labs(title="Do charges and payments move together?", subtitle="and do the payments vary by DRG Definition?", x="Mean Covered Charges", y="Mean Total Payments")+
  guides(fill=guide_legend(nrow=2, byrow=TRUE))
dev.off()
