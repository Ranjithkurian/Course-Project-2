NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County,
# California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# Get Baltimore emissions from motor vehicle sources
BaltimoraEmissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
BaltimoraEmissionsForYear <- aggregate(Emissions ~ year, BaltimoraEmissions, sum)

# Get Los Angeles emissions from motor vehicle sources
LosAngelesEmissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
LosAngelesEmissionsForYear <- aggregate(Emissions ~ year, LosAngelesEmissions, sum)

BaltimoraEmissionsForYear$Country <- "Baltimore City, MD"
LosAngelesEmissionsForYear$Country <- "Los Angeles County, CA"
BaltimoraLAemissions <- rbind(BaltimoraEmissionsForYear, LosAngelesEmissionsForYear)

library(ggplot2)
png("plot6.png")
ggplot(BaltimoraLAemissions, aes(x=factor(year), y=Emissions, fill=Country)) + geom_bar(stat="identity") + facet_grid(Country  ~ ., scales="free") + ylab("emissions (tons)") + xlab("year") + ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))
dev.off()
