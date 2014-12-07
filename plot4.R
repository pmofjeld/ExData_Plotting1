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

png("plot4.png")
par(mfrow=c(2,2))
## first plot
plot(data$Time, data$Global_active_power,
     main="",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="n")
lines(data$Time, data$Global_active_power)

## second plot
plot(data$Time, data$Voltage,
     main="",
     xlab="datetime",
     ylab="Voltage",
     type="n")
lines(data$Time, data$Voltage)

## third plot
plot(data$Time, data$Sub_metering_1,
     main="",
     xlab="",
     ylab="Energy sub metering",
     type="n")
lines(data$Time, data$Sub_metering_1,
      col="black")
lines(data$Time, data$Sub_metering_2,
      col="red")
lines(data$Time, data$Sub_metering_3,
      col="blue")
legend("topright",
       lty=c(1,1,1),
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## fourth plot
plot(data$Time, data$Global_reactive_power,
     main="",
     xlab="datetime",
     ylab="Global_reactive_power",
     type="n")
lines(data$Time, data$Global_reactive_power)
dev.off()