# Project 2 on air pollution
#Plot3
#JRI 6/19/20

#Of the four types of sources indicated by the type (point, nonpoint, onroad,
#nonroad) variable, which of these four sources have seen decreases in emissions
#from 1999–2008 for Baltimore City? Which have seen increases in emissions from
#1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#Answer: All but point sources have shown decreases from 1999 to 2008
# point sources increased from 1999 to 2005 (why?) but returned to slightly
# higher than 1999 levels by 2008

library(reshape2)
library(ggplot2)

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#find total grouped by year, limited to baltimore
idx <- (NEI$fips=="24510")
baltimoreNEI <- NEI[idx,]

#tabulate total emissions by year and type
totalByYearByType <- tapply(baltimoreNEI$Emissions, list(baltimoreNEI$type,baltimoreNEI$year),sum)
#reshape into long format for ggplot
totalByYearByType <-melt(totalByYearByType,value.name="Emissions")
colnames(totalByYearByType)[1:2]=c("type","year")

# BETTER: ddply--learned from forum post
totalByYearByType<-ddply(baltimoreNEI,.(type,year),summarize,Emissions=sum(Emissions))

#plot
#basic--cleaner looking than ggplot; much simpler, too
#barplot(t(totalByYearByType),beside=T,legend.text=T)

#ggplot2
p <- ggplot(data=totalByYearByType,aes(x=as.factor(year), y=Emissions, fill=year)) +
  geom_bar(stat="identity", position="dodge") +
  facet_grid(. ~ type) +
  theme(panel.grid.major.x = element_blank()) +
  theme(panel.grid.minor.x = element_blank()) +
  theme(legend.position="none") +
  labs(title="Change in Baltimore Emissions by Source Type", x="Year", y="Total Emissions [PM2.5]")
p

dev.print(device=png, width=480, height=480, file="plot3.png")

# -- optional --
# Just learning to flex my ggplot--here is a simpler equivalent approache....
# uses raw data, so don't need to tabulate and melt first
qplot(as.factor(year),data=baltimoreNEI,geom="bar",weight=Emissions,fill=year) +
  facet_grid(. ~ type) +
  theme(panel.grid.major.x = element_blank()) +
  theme(panel.grid.minor.x = element_blank()) +
  theme(legend.position="none") +
  labs(title="Change in Baltimore Emissions by Source Type", x="Year", y="Total Emissions [PM2.5]")a
