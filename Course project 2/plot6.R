# 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor
# vehicle emissions?

###################################################################################
# Submitting engine alloweds to upload only one R file, so I had to inline 
# downloading and extracting code instead of reusing it
###################################################################################

load <- function() {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  fileName <- "NEI_data.zip"
  
  if(!file.exists(fileName)){
    download.file(fileUrl,fileName, mode = "wb", method="curl")
  }
  
  unzip(fileName)
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  SCC$SCC <- as.factor(SCC$SCC)
  NEI$Emissions <- as.numeric(NEI$Emissions)
  NEI$year <- as.numeric(NEI$year)
  NEI$type <- as.factor(NEI$type)
  NEI$SCC <- as.factor(NEI$SCC)
  
  list(NEI = NEI, SCC = SCC)
}

datasets <- load()
NEI <- datasets$NEI
SCC <- datasets$SCC

png(file = "plot6.png")
marylandAndLa <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]
vehicles <- SCC[grep("vehicles", SCC$SCC.Level.Two, ignore.case=TRUE),]
merged <- merge(marylandAndLa, vehicles, by.x="SCC", by.y="SCC")
merged$fips <- as.factor(merged$fips)

groupedByYear <- aggregate(x=merged$Emissions, by=list(merged$fips, merged$year), FUN=sum)
colnames(groupedByYear) <- c("fips", "Year", "Emissions")
groupedByYear$city[groupedByYear$fips == "06037"] <- "Los Angeles County"
groupedByYear$city[groupedByYear$fips == "24510"] <- "Baltimore City"
qplot(Year, Emissions, data=groupedByYear, geom=c("point", "line"), color = city) + ggtitle("Emissions from motor vehicle sources in\nBaltimore City and Los Angeles County")
dev.off()