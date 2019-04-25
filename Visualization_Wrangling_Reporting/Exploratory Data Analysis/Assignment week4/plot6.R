#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}
#fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?


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
vehiclesBaltimoreNEI <- aggregate(motorVehicleSourceBaltimore$Emissions, 
                                         list(motorVehicleSourceBaltimore$year), sum)

vehiclesBaltimoreNEI


vehiclesLANEI <- NEI[NEI$SCC %in% motorVehicleSource$SCC & 
                                     NEI$fips == "06037", ]



#emissions due to motor vehicles in Baltimore each year
vehiclesLANEI <- aggregate(vehiclesLANEI$Emissions, 
                                  list(vehiclesLANEI$year), sum)
vehiclesLANEI

vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)


png("plot6.png")

library(ggplot2)

ggp <- ggplot(bothNEI, aes(x=factor(Group.1), y=x, fill=city)) +
  geom_bar(aes(fill=x),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore VS  LA from 1998 to 2008"))

print(ggp)

dev.off()