library(readr)
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.


SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

str(NEI)

NEI$Emissions



#sum all the emissions of each year by all sources(iirespective of sources)


Total <- aggregate(Emissions ~ year,data = NEI, sum)
#Total

png("plot1.png")

plot(Total$year, Total$Emissions/10^6, type = "l", ylab = "Total PM2.5 emissions (10^6)", xlab = "Year",
     main="Total PM2.5 Emissions From All US Sources")

dev.off()
