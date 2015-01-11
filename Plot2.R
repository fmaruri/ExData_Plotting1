##DATA LOADING
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
##READ DATA
p<- read.table(file, header=T, sep=";")
##SUBSET DATA AND REFORMAT DATES
p$Date <- as.Date(p$Date, format="%d/%m/%Y")
f <- p[(p$Date=="2007-02-01") | (p$Date=="2007-02-02"),]
f <- transform(f, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
##TRANSFORM CHARACTER VALUES TO NUMERIC VALUES
f$Global_active_power <- as.numeric(as.character(f$Global_active_power))
f$Global_reactive_power <- as.numeric(as.character(f$Global_reactive_power))
f$Voltage <- as.numeric(as.character(f$Voltage))
f$Sub_metering_1 <- as.numeric(as.character(f$Sub_metering_1))
f$Sub_metering_2 <- as.numeric(as.character(f$Sub_metering_2))
f$Sub_metering_3 <- as.numeric(as.character(f$Sub_metering_3))

##CREATE PLOT 2
plot2 <- function() {
        plot(f$timestamp,f$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.copy(png, file="Plot2.png", width=480, height=480)
        dev.off()}

plot2()