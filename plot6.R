# Project 2 on air pollution
# Plot6
# JRI 6/20/14

#Compare emissions from motor vehicle sources in Baltimore City with emissions
#from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

# Answer: Baltimore has seen greater decline in emissions; LA in contrast got
#   worse, and only slightly better in 2008. Would like to know: how many
#   vehicles being driven
# if you look by type, too "facet_grid(. ~ city + type)",
#   most of the 2002/2005 spike, and all of the 2008 decline
#   is from off-road vehicles--why?

library(ggplot2)

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#ASSUMPTION: motor vehicles is union of onroad and non-road types
vehicleTypes = c("NON-ROAD","ON-ROAD")

#get vehicle sources in Baltimore
baltimoreNEI = NEI[NEI$fips=="24510" & NEI$type %in% vehicleTypes,]
baltimoreNEI$city <- "Baltimore City"

#get vehicle sources in LA
losangelesNEI = NEI[NEI$fips=="06037" & NEI$type %in% vehicleTypes,]
losangelesNEI$city <- "Los Angeles County"

#concatenate the tables
data <- rbind(baltimoreNEI, losangelesNEI)

# optional: make a summary table
yearlyTotalEmissions <- tapply(data$Emissions, list(data$year, data$type, data$city) , sum)

#plot
qplot(as.factor(year),data=data,geom="bar",weight=Emissions,fill=year) +
  facet_grid(. ~ city) +
  theme(panel.grid.major.x = element_blank()) +
  theme(panel.grid.minor.x = element_blank()) +
  theme(legend.position="none") +
  labs(title="Comparison of vehicle emissions in Baltimore & LA", x="Year", y="Total Emissions [PM2.5]")

dev.print(device=png, width=480, height=480, file="plot6.png")
