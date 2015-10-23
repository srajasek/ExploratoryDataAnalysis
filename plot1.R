NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## Total emissions for each year
totalPerYear <- aggregate(Emissions ~ year, NEI, sum)

png(filename = "plot1.png", width = 480, height = 480)
plot(totalPerYear, type = "l", col = "darkblue",
     xlab = "Year", ylab = "Total Emissions",
     main = "Total emissions (1999 - 2008)")
dev.off()
