# 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a
# plot answer this question.

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

png(file = "plot3.png")
marylandData <- NEI[NEI$fips == "24510",]
groupedByYear <- aggregate(x=marylandData$Emissions, by=list(marylandData$type, marylandData$year), FUN=sum)
colnames(groupedByYear) <- c("Type", "Year", "Emissions")
groupedByYear$type <- as.factor(groupedByYear$Type)
qplot(Year, Emissions, data=groupedByYear, geom=c("point", "line"), color = Type) + ggtitle("Emissions in Baltimore City by type")
dev.off()