library(data.table)

plot1 <- function() {
  
  f <- fread("household_power_consumption.txt", na.strings = "?")   ## Read the full file
  f$Date <- as.Date(f$Date, "%d/%m/%Y")                             ## Convert date into R class
  fSubSet <- subset(f, f$Date >= "2007-02-01")                      ## Get data from required date range only
  fSubSet <- subset(fSubSet, fSubSet$Date < "2007-02-03")
  
  ## Plot histogram to get required graph. Coerce into numeric as fread has read data as character
  par(cex = 0.7)    ## Reduce font size
  hist(as.numeric(fSubSet$Global_active_power), main = "Global Active Power",
       col = "orange", xlab = "Global Active Power (kilowatts)")
  
  ## Stores .png file in active directory
  dev.copy(png, "plot1.png")
  
  ## Switch off PNG device
  dev.off()
  
}