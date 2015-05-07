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
png("plot2.png")
with(HPC, plot(datetime, Global_active_power, type = "l",
               xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
Sys.setlocale("LC_TIME",lct)
