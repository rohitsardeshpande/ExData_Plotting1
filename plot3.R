library(data.table)

plot3 <- function() {
  
  f <- fread("household_power_consumption.txt", na.strings = "?")   ## Read the full file
  f$Date <- as.Date(f$Date, "%d/%m/%Y")                             ## Convert date into R class
  fSubSet <- subset(f, f$Date >= "2007-02-01")                      ## Get data from required date range only
  fSubSet <- subset(fSubSet, fSubSet$Date < "2007-02-03")
  
  ## Merge date and time into a single object
  d <- as.POSIXct(paste(fSubSet$Date, fSubSet$Time), format="%Y-%m-%d %H:%M:%S")
  
  ## Draw a simple line plot
  par(cex = 0.7)      ## Reduce font size
  
  ## Draw main plot
  plot(d, fSubSet$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(d, fSubSet$Sub_metering_2, col = "red")   ## Add second variable
  lines(d, fSubSet$Sub_metering_3, col = "blue")  ## Add third variable
  
  ## Sort out legends
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1),
         col = c("black", "red", "blue"), xjust = 1)
  
  ## Stores .png file in active directory
  dev.copy(png, "plot3.png")
  
  ## Switch off PNG device
  dev.off()
}