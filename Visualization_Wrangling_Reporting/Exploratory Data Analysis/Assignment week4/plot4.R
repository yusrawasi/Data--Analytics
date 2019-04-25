#Across the United States, how have emissions from coal combustion-related sources changed 
#from 1999-2008?

library(ggplot2)
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

str(NEI)
dim(NEI)

str(SCC)
head(SCC)

SCC$Short.Name

#grepping the (indices of rows) sources containing coal   ????
coal_SCC <- SCC[grep("coal|Coal",SCC$Short.Name),]$SCC


#in Pm25 data, those rows containing coal
coal <- NEI[NEI$SCC %in% coal_SCC,]

coal <- aggregate(coal, list(coal$year), mean)
coal

png("plot4.png")
g2 <- ggplot(coal, aes(x=year, y=Emissions)) + geom_point(aes(colour = factor(year)), size = 4)+geom_line()
g2

dev.off()
