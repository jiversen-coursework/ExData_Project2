# Project 2 on air pollution
# Plot1
# JRI 6/18/14

#Have total emissions from PM2.5 decreased in the United States from 1999 to
#2008? Using the base plotting system, make a plot showing the total PM2.5
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Answer: Yes, total emissions have decreased

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#find total grouped by year
yearlyTotalEmissions <- tapply(NEI$Emissions, NEI$year, sum)

#make a bar plot

png(file="plot1.png",width=480,height=480)
barplot(yearlyTotalEmissions, xlab="Year", ylab="Total Emissions [PM2.5]",main="Total Emissions Decreased from 1999 to 2008")
dev.off()

# -- optional --
# boxplot--not useful cause of some enormous outliers
#boxplot(Emissions~year, data=NEI, notch=TRUE)
