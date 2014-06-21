# Project 2 on air pollution
# Plot4
# JRI 6/20/14

#Across the United States, how have emissions from coal combustion-related
#sources changed from 1999–2008?

#Answer: They remained steady through 2005 then decreased in 2008

library(plyr)

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#find entries on SCC that use coal
# ASSUMPTION: I define coal related as those with the final word of EI.Sector is "Coal"
# list of last words of EI.Sector
tmp<-llply(as.character(SCC$EI.Sector),function(x){a<-strsplit(x," - ")[[1]]; a[length(a)]})
isCoal <- (tmp=="Coal")
coalSCC <- as.character(SCC$SCC[isCoal]) #vector of the SCC codes for coal plants

#find emissions data for the coal sources
coalNEI <- NEI[NEI$SCC %in% coalSCC,]

#tabulate
yearlyTotalEmissions <- tapply(coalNEI$Emissions, coalNEI$year, sum)

#make a bar plot
png(file="plot4.png",width=480,height=480)
barplot(yearlyTotalEmissions, xlab="Year", ylab="Total Emissions [PM2.5]",main="Emissions from coal-burning sources")
dev.off()
