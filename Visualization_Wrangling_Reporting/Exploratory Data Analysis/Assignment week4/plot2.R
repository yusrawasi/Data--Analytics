#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot
#answering this question.



SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

str(NEI)
dim(NEI)


#subsetting the data with fips ==24510

NEI <- NEI[which(NEI$fips == "24510"),]

  
#sum all the emissions of each year by all sources(iirespective of sources)
  
  
Total <- aggregate(Emissions ~ year,data = NEI, sum)
Total
  
  
#plotting

png("plot2.png")

  plot(Total$year, Total$Emissions, type = "l", ylab = "Total PM2.5 emissions", xlab = "Year",
       main="Total PM2.5 Emissions in the Baltimore City, Maryland ")
dev.off()