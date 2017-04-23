NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Get Baltimore emissions from motor vehicle sources
BaltimoraEmissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
BaltimoraEmissionsForYear <- aggregate(Emissions ~ year, BaltimoraEmissions, sum)

#plot
png('plot5.png')
ggplot(BaltimoraEmissionsForYear, aes(x=factor(year), y=Emissions)) + geom_bar(stat="identity") +  xlab("year") + ylab(expression("PM"[2.5]*" emissions")) + ggtitle("Emissions from motor vehicle sources in Baltimore City")
dev.off()
