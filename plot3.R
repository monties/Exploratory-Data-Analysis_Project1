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
png("plot3.png")
with(HPC, {
    plot(datetime, Sub_metering_1, type = "l", col = "black",
         xlab = "", ylab = "Energy sub metering")
    lines(datetime, Sub_metering_2, type = "l", col = "red")
    lines(datetime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()
Sys.setlocale("LC_TIME",lct)
