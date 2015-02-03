source("datasourceReader.R")

dataset <- loadDataset()

png(file = "plot4.png")
par(mfrow=c(2,2))
with(dataset, {
  plot(x=Time, y=Global_active_power, na.strings = "?", type="l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(x=Time, y=Voltage, na.strings = "?", type="l", xlab="datetime", ylab="Voltage")
  with(dataset, plot(x=Time, y=Sub_metering_1, na.strings = "?", type="l", ylab="Energy sub metering"))
  with(dataset, lines(x=Time, y=Sub_metering_2, na.strings = "?", type="l", col="Red"))
  with(dataset, lines(x=Time, y=Sub_metering_3, na.strings = "?", type="l", col="Blue"))
  legend("topright", lty=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  plot(x=Time, y=Global_reactive_power, na.strings = "?", type="l", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()