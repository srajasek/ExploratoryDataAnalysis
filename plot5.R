NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset Baltimore data
baltimoreNEI <- subset(NEI, fips == "24510")
## Subset coal combustion-related SCC classificators
vehiclesSCC <- SCC[grepl("vehicles", SCC$EI.Sector, ignore.case = T), ]
## Subset Baltimore NEI data where SCC in it matches SCC in vehiclesSCC
baltimoreVehiclesNEI <- baltimoreNEI[baltimoreNEI$SCC %in% vehiclesSCC$SCC, ]

## Aggregate total emissions for each year by type
baltimoreVehiclesPerYear <- aggregate(Emissions ~ year, baltimoreVehiclesNEI, sum)

library(ggplot2)
## Plot as lines, group and color by type
png(filename = "plot5.png", width = 480, height = 480)
ggplot(baltimoreVehiclesPerYear, aes(x=year, y=Emissions)) +
        geom_point() + geom_line() +
        xlab("Year") + ylab("Emissions") + ggtitle("Vehicle Emissions in Baltimore")
dev.off()