NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Find coal combustion-related sources
combustionCoal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustionCoalSource <- SCC[combustionCoal,]

# Find emissions from coal combustion-related sources based on unique column SCC in both the table
emissions <- NEI[(NEI$SCC %in% combustionCoalSource$SCC), ]

# group by year
emissionsbyyear <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

# new column with emissions in thousands (for the y axis)
emissionsbyyear$EmissionsInThousands <- emissionsbyyear$Emissions/1000

# plot
 library(ggplot2)
 png("plot4.png")
 ggplot(emissionsbyyear, aes(x=factor(year), y=EmissionsInThousands)) + geom_bar(stat="identity") +  xlab("year") + ylab(expression("PM"[2.5]*" emissions")) + ggtitle("Emissions from coal combustion-related sources")
 dev.off()
