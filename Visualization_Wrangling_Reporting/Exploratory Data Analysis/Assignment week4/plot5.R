#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


library(ggplot2)
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

str(NEI)
dim(NEI)

str(SCC)
head(SCC)

SCC$EI.Sector
SCC$Data.Category
SCC$Short.Name
SCC$Option.Group

##  motor vehicle sources from 'SCC'
motorVehicleSource <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, 
                                      value = TRUE))
motorVehicleSource <- SCC[SCC$EI.Sector %in% motorVehicleSource, ]["SCC"]

## emissions due to motor vehicle sources in  Baltimore
motorVehicleSourceBaltimore <- NEI[NEI$SCC %in% motorVehicleSource$SCC & 
                                              NEI$fips == "24510", ]



#emissions due to motor vehicles in Baltimore each year
motorVehicleSourceBaltimore <- aggregate(motorVehicleSourceBaltimore$Emissions, 
                                               list(motorVehicleSourceBaltimore$year), sum)

motorVehicleSourceBaltimore



#plotting
png("plot5.png")

ggplot(data=motorVehicleSourceBaltimore, aes(x=Group.1, y=x)) + geom_line() + geom_point( size=4, shape=21, fill="white") + xlab("Year") + ylab("Emissions (tons)") + ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore")

dev.off()
