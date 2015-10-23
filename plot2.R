NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Get Baltimore data
baltimoreNEI <- subset(NEI, fips == "24510")

## Total emissions for each year
baltimorePerYear <- aggregate(Emissions ~ year, baltimoreNEI, sum)

## Plot the line to see if emissions have decreased
png(filename = "plot2.png", width = 480, height = 480)
plot(baltimorePerYear, type = "l", col = "red",
     xlab = "Year", ylab = "Total Emissions",
     main = "Total emissions (1999 - 2008)")
dev.off()