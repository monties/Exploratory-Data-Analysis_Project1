# to get and read the sub dataset
install.packages("sqldf")
library(sqldf)
HPC <- read.csv.sql("household_power_consumption.txt", sep = ";",
                     sql = "select * FROM file
                     WHERE Date IN ('1/2/2007', '2/2/2007')")
HPC$Date <- as.Date(HPC$Date, "%d/%m/%Y")
HPC$Time <- strptime(HPC$Time, "%H:%M:%S")
# to plot
png("plot1.png")
hist(HPC$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "Red")
dev.off()
