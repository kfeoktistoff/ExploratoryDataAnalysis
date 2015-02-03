# 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

png(file = "plot5.png")
fips <- NEI[NEI$fips == "24510",]
vehicles <- SCC[grep("vehicles", SCC$SCC.Level.Two, ignore.case=TRUE),]
merged <- merge(fips, vehicles, by.x="SCC", by.y="SCC")

groupedByYear <- aggregate(x=merged$Emissions, by=list(merged$year), FUN=sum)
colnames(groupedByYear) <- c("Year", "Emissions")
with(groupedByYear, plot(x=Year, y=Emissions, main="Emissions from motor vehicle sources in Baltimore City"))
lines(groupedByYear$Year, groupedByYear$Emissions)
dev.off()