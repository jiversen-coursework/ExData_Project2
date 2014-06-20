# Project 2 on air pollution
# Plot1
# JRI 6/18/14

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips
#== "24510") from 1999 to 2008? Use the base plotting system to make a plot
#answering this question.

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#find total grouped by year, limited to baltimore
idx <- (NEI$fips==24510)
yearlyTotalEmissions <- tapply(NEI$Emissions[idx], NEI$year[idx], sum)

#make a bar plot

png(file="plot2.png",width=480,height=480)
barplot(yearlyTotalEmissions, xlab="Year", ylab="Total Emissions [PM2.5]",main="Total Emissions in Baltimore City")
dev.off()
