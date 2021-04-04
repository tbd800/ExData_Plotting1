## Read the data

consumption <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")

## Create column in table with date and time merged together
timedata <- strptime(paste(consumption$Date, consumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
consumption <- cbind(consumption, timedata)


## change class of all columns to correct class
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")
consumption$Time <- format(consumption$Time, format="%H:%M:%S")
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)
consumption$Global_reactive_power <- as.numeric(consumption$Global_reactive_power)
consumption$Voltage <- as.numeric(consumption$Voltage)
consumption$Global_intensity <- as.numeric(consumption$Global_intensity)
consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)

## subset data from 2007-02-01 and 2007-02-02
subsetdata <- subset(consumption, Date == "2007-02-01" | Date =="2007-02-02")


## plot the 4 graphs
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subsetdata, plot(timedata, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subsetdata, plot(timedata, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subsetdata, plot(timedata, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subsetdata$timedata, subsetdata$Sub_metering_2,type="l", col= "red")
lines(subsetdata$timedata, subsetdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subsetdata, plot(timedata, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()



