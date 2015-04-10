##SET UP DATA
##Read in data
data <- read.table("household_power_consumption.txt", header = T, sep=";")
## Make Date tab recognized as a Date in R
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
## create Data frame of just the information for 2007-02-01 or 2007-02-02
revisedData <- data[(data$Date =="2007-02-01") | (data$Date=="2007-02-02"),]
## save Global active power data as a decimal numer
revisedData$Global_active_power <-as.numeric(as.character(revisedData$Global_active_power))
## save Global reactive power data as a decimal numer
revisedData$Global_reactive_power <- as.numeric(as.character(revisedData$Global_reactive_power))
## save Voltage as a decimal numer
revisedData$Voltage <- as.numeric(as.character(revisedData$Voltage))
## save sub_metering 1 data as a decimal numer
revisedData$Sub_metering_1 <-as.numeric(as.character(revisedData$Sub_metering_1))
## save sub_metering 2 data as a decimal numer
revisedData$Sub_metering_2 <- as.numeric(as.character(revisedData$Sub_metering_2))
## save sub_metering 3 as a decimal numer
revisedData$Sub_metering_3 <- as.numeric(as.character(revisedData$Sub_metering_3))
##Adjust time information
revisedData <- transform(revisedData, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")


##create two ros and two columns
par(mfrow=c(2,2))
##MAKE PLOTS
## First Plot
plot(revisedData$timestamp, revisedData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
## Second plot
plot(revisedData$timestamp,revisedData$Voltage, type="l", xlab="datetime", ylab="Voltage")
##Third plot
plot(revisedData$timestamp,revisedData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(revisedData$timestamp,revisedData$Sub_metering_2,col="red")
lines(revisedData$timestamp,revisedData$Sub_metering_3,col="blue")
## Fourth Plot
plot(revisedData$timestamp,revisedData$Global_reactive_power, type="l", xlab="datetime", ylab="Voltage")


## export to png
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()