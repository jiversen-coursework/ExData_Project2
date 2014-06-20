# Project 2 on air pollution

#Of the four types of sources indicated by the type (point, nonpoint, onroad,
#nonroad) variable, which of these four sources have seen decreases in emissions
#from 1999–2008 for Baltimore City? Which have seen increases in emissions from
#1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(reshape2)

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#find total grouped by year, limited to baltimore
idx <- (NEI$fips==24510)
totalByYearByType <- tapply(NEI$Emissions[idx], list(NEI$type[idx],NEI$year[idx]),sum)
totalLong <-melt(totalByYearByType,value.name="Emissions")
colnames(totalLong)[1:2]=c("type","year")
#totalLong$year <- as.factor(totalLong$year)

#plot
#basic
barplot(totalByYearByType,beside=T,legend.text=T)

#ggplot2
library(ggplot2)

p <- ggplot(data=totalLong,aes(x=year, y=Emissions, fill=year)) +
  geom_bar(stat="identity", position="dodge") + facet_grid(. ~ type) +
  scale_x_continuous(breaks=c(1999,2002,2005, 2008),labels=unique(totalLong$year))
  theme(panel.grid.major.x = element_blank())
p

dev.print(device=png, width=480, height=480, file="plot3.png")
