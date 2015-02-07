## sqldf package utilised to load in just the dates required for the analysis
require(sqldf)

## read in data with 1/2/2007 or 2/2/2007 filter
powerData <- read.csv.sql("Assign1/Data/household_power_consumption.txt", sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = TRUE, sep = ";")

sqldf() ## close sql connection

## reclass date and time
powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")
powerData$Time <- strptime(paste(powerData$Date,powerData$Time), "%Y-%m-%d %H:%M:%S") ## combine date and time

png(filename = "Assign1/plot1.png", width = 480, height = 480) ## create a PNG with width/height 480x480
with(powerData, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")) ## create histogram with appropriate labels and red columns

dev.off() ## close PNG device connection