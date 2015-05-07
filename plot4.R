# to get and read the sub dataset
library(sqldf)
HPC <- read.csv.sql("household_power_consumption.txt", sep = ";",
                    sql = "select * FROM file 
                    WHERE Date IN ('1/2/2007', '2/2/2007')")
HPC$Date <- as.Date(HPC$Date, "%d/%m/%Y")
HPC$Time <- strptime(HPC$Time, "%H:%M:%S")
# for current locale is in Asia, therefore set locale before graph
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
datetime <- paste(as.character.Date(HPC$Date),
                  as.character.POSIXt(HPC$Time, "%H:%M:%S"))
HPC$datetime <- strptime(datetime, "%Y-%m-%d %H:%M:%S")
# to plot
png("plot4.png")
par(mfcol = c(2, 2))
with(HPC, {
    plot(datetime, Global_active_power, type = "l",
         xlab = "", ylab = "Global Active Power")
    plot(datetime, Sub_metering_1, type = "l",
         xlab = "", ylab = "Energy sub mertering")
    lines(datetime, Sub_metering_2, type = "l", col = "red")
    lines(datetime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"),
           bty = "n", legend = names(HPC[,7:9]))
    plot(datetime, Voltage, type = "l")
    plot(datetime, Global_reactive_power, type = "l")
})
dev.off()
Sys.setlocale("LC_TIME",lct)
