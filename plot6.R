# Project 2 on air pollution

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#Compare emissions from motor vehicle sources in Baltimore City with emissions
#from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?
