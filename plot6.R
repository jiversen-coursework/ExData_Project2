# Project 2 on air pollution
# Plot6
# JRI 6/20/14

#Compare emissions from motor vehicle sources in Baltimore City with emissions
#from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

# Answer: Baltimore has seen greater decline in emissions; LA in contrast got
#   worse, and only slightly better in 2008. Would like to know: how many
#   vehicles being driven.
# if you include on and off-road and look by type, too "facet_grid(. ~ city + type)",
#   most of the LA 2002/2005 spike, and all of the 2008 decline
#   is from off-road vehicles--why?

library(ggplot2)

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#ASSUMPTION: motor vehicles defined as ON-ROAD measurement type

#get vehicle sources in Baltimore
baltimoreNEI = NEI[NEI$fips=="24510" & NEI$type == "ON-ROAD",]
baltimoreNEI$city <- "Baltimore City"

#get vehicle sources in LA
losangelesNEI = NEI[NEI$fips=="06037" & NEI$type == "ON-ROAD",]
losangelesNEI$city <- "Los Angeles County"

#concatenate the tables
data <- rbind(baltimoreNEI, losangelesNEI)

# optional: make a summary table
yearlyTotalEmissions <- tapply(data$Emissions, list(data$year, data$type, data$city) , sum)

#plot--not the greatest, since the scales are so different. scales="free" seems not to work here
qplot(as.factor(year),data=data,geom="bar",weight=Emissions,fill=year) +
  facet_grid(. ~ city, scales="free") +
  theme(panel.grid.major.x = element_blank()) +
  theme(panel.grid.minor.x = element_blank()) +
  theme(legend.position="none") +
  labs(title="Comparison of vehicle emissions in Baltimore & LA", x="Year", y="Total Emissions [PM2.5]")

dev.print(device=png, width=480, height=480, file="plot6.png")
