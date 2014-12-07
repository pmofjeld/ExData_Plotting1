startRow=66637
endRow=69516
## because we are using the skip argument of read.table,
## we cannot rely on the header argument's functionality.
## hence the vector of variable names.
colNames=c("Date",
           "Time",
           "Global_active_power",
           "Global_reactive_power",
           "Voltage",
           "Global_intensity",
           "Sub_metering_1",
           "Sub_metering_2",
           "Sub_metering_3")
data <- read.table(file="household_power_consumption.txt",
           col.names=colNames,
           skip=startRow,
           nrow=endRow-startRow+1,
           sep=";",
           quote="",
           na.strings="?",
           comment.char="",
           colClasses=c(rep("character",2),rep("numeric",7))
)

## converts the Time variable to the POSIXlt class
data$Time <- strptime(paste(data$Date,data$Time),
                      format="%d/%m/%Y %H:%M:%S")

## converts the Date variable to the Date class
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

png("plot1.png")
hist(data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()