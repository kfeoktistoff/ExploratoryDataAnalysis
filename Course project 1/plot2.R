source("datasourceReader.R")

dataset <- loadDataset()

png(file = "plot2.png")
with(dataset, plot(x=Time, y=Global_active_power, na.strings = "?", type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()