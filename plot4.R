NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset coal combustion-related SCC classificators
coalSCC <- SCC[grepl("coal", SCC$EI.Sector, ignore.case = T), ]
## Subset NEI where SCC in NEI matches SCC in coalSCC
coalNEI <- NEI[NEI$SCC %in% coalSCC$SCC, ]

## Aggregate total emissions for each year by type
coalPerYear <- aggregate(Emissions ~ year, coalNEI, sum)

library(ggplot2)
## Plot as lines, group and color by type
png(filename = "plot4.png", width = 480, height = 480)
ggplot(coalPerYear, aes(x=year, y=Emissions)) +
        geom_point() + geom_line() +
        xlab("Year") + ylab("Emissions") + ggtitle("Coal Emissions in the U.S.")
dev.off()
