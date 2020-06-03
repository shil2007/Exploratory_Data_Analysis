# Plot 3

# Use sqldf to subset the data when reading it
library(sqldf)
f <- file("./data/household_power_consumption.txt")

# Date is in format d/m/yyyy while it's passing though sqldf
# sqldf deals with NAs (in this file expressed as "?") converting them to 0/blank
measurements <- 
  sqldf("select * from  f where Date = '1/2/2007' or Date = '2/2/2007'", 
        dbname = tempfile(), 
        file.format = list(header = TRUE, row.names = FALSE, sep = ";"))

close(f)

library(lubridate)
measurements$DateTime <- dmy_hms(paste(measurements$Date, measurements$Time))

# Plot must be saved as PNG files of 480x480 pixels
png(filename = "./ExData_Plotting1/plot3.png", 
    width = 480, 
    height = 480, 
    units = "px")

# Please note that my environment is in spanish, so the day names are 
# "jueves" (thursday), "viernes" (friday) and "sabado" (saturday) in x labels
with(measurements, {
  plot(DateTime,
       Sub_metering_1, 
       type = "l",
       ylab = "Energy sub metering",
       xlab = "")
  lines(DateTime,
        Sub_metering_2, 
        type = "l",
        col = "red")
  lines(DateTime,
        Sub_metering_3, 
        type = "l",
        col = "blue")
  legend("topright", 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"),
         lty = c(1, 1, 1))
})

dev.off()