## sqldf package utilised to load in just the dates required for the analysis
require(sqldf)

## read in data with 1/2/2007 or 2/2/2007 filter
powerData <- read.csv.sql("Assign1/Data/household_power_consumption.txt", sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = TRUE, sep = ";")

sqldf() ## close sql connection

## reclass date and time
powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")
powerData$Time <- strptime(paste(powerData$Date,powerData$Time), "%Y-%m-%d %H:%M:%S") ## combine date and time

png(filename = "Assign1/plot4.png", width = 480, height = 480) ## create a PNG with width/height 480x480
par(mfrow = c(2,2)) ## setup plot array 2 x 2

## 1ST PLOT

with(powerData, plot(Time, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = NA, type = "l")) ## generate line plot of time vs. g.a.p.

## 2ND PLOT

with(powerData, plot(Time, Voltage, ylab = "Voltage", type = "l", xlab = "datetime")) ## generate line plot of time vs. voltage

## 3RD PLOT

yRange <- range(c(with(powerData, Sub_metering_1,Sub_metering_2, Sub_metering_3))) ## set range for Y axis so that it can accomodate all three variables

with(powerData, plot(Time, Sub_metering_1, type = "l", ylim=yRange, col="black", ylab = "Energy sub metering", xlab = NA)) ## plot Sub_metering_1
with(powerData, lines(Time, Sub_metering_2, type = "l", ylim=yRange, col="red"))## plot Sub_metering_2
with(powerData, lines(Time, Sub_metering_3, type = "l", ylim=yRange, col="blue")) ## plot Sub_metering_3
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = "solid", bty = "n") ## create legend

## 4TH PLOT

with(powerData, plot(Time, Global_reactive_power, type = "l", xlab = "datetime")) ## generate line plot of time vs. g.r.p.


dev.off() ## close PNG device connection