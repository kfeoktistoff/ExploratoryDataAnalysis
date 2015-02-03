source("datasourceReader.R")

dataset <- loadDataset()

png(file = "plot1.png")
hist(dataset$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()