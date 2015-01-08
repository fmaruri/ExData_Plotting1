##DATA LOADING
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
##READ DATA
power <- read.table(file, header=T, sep=";")
##REFORMAT DATES
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
f <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
f <- transform(f, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
##TRANSFORM CHARACTER VALUES TO NUMERIC VALUES
f$Global_active_power <- as.numeric(as.character(f$Global_active_power))
f$Global_reactive_power <- as.numeric(as.character(f$Global_reactive_power))
f$Voltage <- as.numeric(as.character(f$Voltage))
f$Sub_metering_1 <- as.numeric(as.character(f$Sub_metering_1))
f$Sub_metering_2 <- as.numeric(as.character(f$Sub_metering_2))
f$Sub_metering_3 <- as.numeric(as.character(f$Sub_metering_3))

##CREATE PLOT 4
plot4 <- function() {
        par(mfrow=c(2,2))
        
        ##PLOT A
        plot(f$timestamp,f$Global_active_power, type="l", xlab="", ylab="Global Active Power")
       
	##PLOT B
        plot(f$timestamp,f$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        ##PLOT C
        plot(f$timestamp,f$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(f$timestamp,f$Sub_metering_2,col="red")
        lines(f$timestamp,f$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1), bty="n", cex=.5) 
        
        ##PLOT D
        plot(f$timestamp,f$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        ##OUTPUT
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
     }
plot4()