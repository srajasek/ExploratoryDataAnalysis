NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset Baltimore & LA data
compareNEI <- subset(NEI, fips == "24510" | fips == "06037")
## Subset coal combustion-related SCC classificators
vehiclesSCC <- SCC[grepl("vehicles", SCC$EI.Sector, ignore.case = T), ]
## Subset Baltimore-LA NEI data where SCC in it matches SCC in vehiclesSCC
compareVehiclesNEI <- compareNEI[compareNEI$SCC %in% vehiclesSCC$SCC, ]

## Aggregate total emissions for each year by type
compareVehiclesPerYear <- aggregate(Emissions ~ year+fips, compareVehiclesNEI, sum)

## Replace fips values with city names
compareVehiclesPerYear[which(compareVehiclesPerYear$fips=="24510"),"fips"] <- "Baltimore";
compareVehiclesPerYear[which(compareVehiclesPerYear$fips=="06037"),"fips"] <- "Los Angeles";

library(ggplot2)
## Plot as lines, group and color by type
png(filename = "plot6.png", width = 480, height = 480)
ggplot(compareVehiclesPerYear, aes(x=year, y=Emissions, group = fips, color = fips)) +
        geom_point() + geom_line() +
        xlab("Year") + ylab("Emissions") + ggtitle("Vehicle Emissions in Baltimore and in LA")
dev.off()