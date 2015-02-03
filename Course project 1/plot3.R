source("datasourceReader.R")

dataset <- loadDataset()

png(file = "plot3.png")
with(dataset, plot(x=Time, y=Sub_metering_1, na.strings = "?", type="l", ylab="Energy sub metering"))
with(dataset, lines(x=Time, y=Sub_metering_2, na.strings = "?", type="l", col="Red"))
with(dataset, lines(x=Time, y=Sub_metering_3, na.strings = "?", type="l", col="Blue"))
legend("topright", lty=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()