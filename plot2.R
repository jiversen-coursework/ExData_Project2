# Project 2 on air pollution

#read data
NEI<-readRDS('NEI_data/summarySCC_PM25.rds')
SCC<-readRDS('NEI_data/Source_Classification_Code.rds')

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips
#== "24510") from 1999 to 2008? Use the base plotting system to make a plot
#answering this question.
