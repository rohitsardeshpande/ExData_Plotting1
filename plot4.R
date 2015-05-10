library(data.table)

plot4 <- function() {
  
  f <- fread("household_power_consumption.txt", na.strings = "?")   ## Read the full file
  f$Date <- as.Date(f$Date, "%d/%m/%Y")                             ## Convert date into R class
  fSubSet <- subset(f, f$Date >= "2007-02-01")                      ## Get data from required date range only
  fSubSet <- subset(fSubSet, fSubSet$Date < "2007-02-03")
  
  ## Merge date and time into a single object
  d <- as.POSIXct(paste(fSubSet$Date, fSubSet$Time), format="%Y-%m-%d %H:%M:%S")
  
  par(mfrow = c(2,2))     ## Configure 2x2 matrix of plots
  
  ## Plot global active power against date-time
  par(cex = 0.7)          ## Reduce text size
  plot(d, fSubSet$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  
  ## Plot voltage against date-time
  par(cex = 0.7)          ## Reduce text size
  plot(d, fSubSet$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  
  ## Plot sub-metering values against date-time
  par(cex = 0.7)          ## Reduce text size
  plot(d, fSubSet$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
  lines(d, fSubSet$Sub_metering_2, col = "red")   ## Add second variable
  lines(d, fSubSet$Sub_metering_3, col = "blue")  ## Add third variable
  ## Sort out legends
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                 text.width = strwidth("1,000"), bty = "n", 
                 lty = c(1, 1, 1), col = c("black", "red", "blue"),
                 xjust = 1, yjust = 1, cex = 0.7)
  
  ## Plot global reactive power against date-time
  par(cex = 0.7)        ## Reduce text size
  plot(d, fSubSet$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
  
  ## Stores .png file in active directory
  dev.copy(png, "plot4.png")
  
  ## Switch off PNG device
  dev.off()
  
}