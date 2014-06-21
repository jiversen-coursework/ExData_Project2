# Project 2 on air pollution
# Plot5
# JRI 6/20/14

#How have emissions from motor vehicle sources changed from 1999–2008 in
#Baltimore City?

#Answer: They have declined considerably

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#get sources in Baltimore
baltimoreNEI = NEI[NEI$fips=="24510",]

#ASSUMPTION: motor vehicles defined as ON-ROAD measurement type
vehicleNEI = baltimoreNEI[baltimoreNEI$type == "ON-ROAD",]

#tabulate
yearlyTotalEmissions <- tapply(vehicleNEI$Emissions, vehicleNEI$year, sum)

#make a bar plot
png(file="plot5.png",width=480,height=480)
barplot(yearlyTotalEmissions, xlab="Year", ylab="Total Emissions [PM2.5]",main="Emissions from motor vehicles in Baltimore")
dev.off()

# -- optional --
#ggplot2 version: slower, and I find it less attractive, but it avoids the tabulation step
#library(ggplot2)
#qplot(as.factor(year),data=vehicleNEI,geom="bar",weight=Emissions)
