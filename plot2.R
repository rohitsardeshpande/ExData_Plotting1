library(data.table)

plot2 <- function() {
  
  f <- fread("household_power_consumption.txt", na.strings = "?")   ## Read the full file
  f$Date <- as.Date(f$Date, "%d/%m/%Y")                             ## Convert date into R class
  fSubSet <- subset(f, f$Date >= "2007-02-01")                      ## Get data from required date range only
  fSubSet <- subset(fSubSet, fSubSet$Date < "2007-02-03")
  
  ## Merge date and time into a single object
  d <- as.POSIXct(paste(fSubSet$Date, fSubSet$Time), format="%Y-%m-%d %H:%M:%S")
  
  ## Draw a simple line plot
  par(cex = 0.7)    ## Reduce font size
  plot(d, fSubSet$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  
  ## Stores .png file in active directory
  dev.copy(png, "plot2.png")
  
  ## Switch off PNG device
  dev.off()
}