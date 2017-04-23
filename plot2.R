# Read the data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

BaltimoraEmissions <- NEI[NEI$fips=="24510",]
BaltimoraEmissionsForYear <- aggregate(Emissions ~ year, BaltimoraEmissions, sum)

png('plot2.png')
barplot(BaltimoraEmissionsForYear$Emissions,names.arg = BaltimoraEmissionsForYear$year,col="blue",xlab = "Years",ylab = 'Emissions (PM 2.5)',main = 'Baltimore City: Emissions (PM 2.5) per year' )
dev.off()
