# 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

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

png(file = "plot1.png")
groupedByYear <- aggregate(x=NEI$Emissions, by=list(NEI$year), FUN=sum)
colnames(groupedByYear) <- c("Year", "Emissions")
with(groupedByYear, plot(x=Year, y=Emissions, main="Total emissions in the United States"))
lines(groupedByYear$Year, groupedByYear$Emissions)
dev.off()