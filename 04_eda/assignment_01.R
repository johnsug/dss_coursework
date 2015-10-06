# # Download and process data -- only need to do run this block of code once ##########################################
# temp <- tempfile()
# download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
# d <- read.table(unz(temp, "household_power_consumption.txt"), header=T, sep=";", stringsAsFactors=F)
# unlink(temp)
# 
# # subset data (only want dates between 2007-02-01 and 2007-02-02)
# library(lubridate)
# d$dmy <- dmy(d$Date)
# d$day <- day(d$dmy)
# d$month <- month(d$dmy)
# d$year <- year(d$dmy)
# d <- subset(d, year=='2007' & month=='2' & day %in% c('1','2'))
# d <- d[c(1:9)]  ## drop lubridated dates
# 
# # find date/time
# d$DateTime <- paste(d$Date, d$Time)
# d$DateTime <- strptime(d$DateTime, format="%d/%m/%Y %H:%M:%S")
# 
# # re-order dataframe
# d <- cbind(d$DateTime, d[,3:9])
# names(d)[1] <- "DateTime"
# 
# # save tidy-ier dataset ("d")
# write.csv(d, "household_power_consumption.csv", row.names=F)

## Load data and libraries ############################################################################################
library(magrittr)
d <- read.csv("household_power_consumption.csv")

## Prep data ##########################################################################################################
d$Global_active_power %<>% as.numeric()
d$Global_reactive_power %<>% as.numeric()
d$Voltage %<>% as.numeric()
d$Global_intensity %<>% as.numeric()
d$Sub_metering_1 %<>% as.numeric()
d$Sub_metering_2 %<>% as.numeric()

## Plot #1: ##################
hist(x=d$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file="plot1.png")
dev.off()

## Plot #2: ##################
plot(ts(d$Global_active_power, freq=1440, start=5), xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
axis(1, at=c(5,6,7), labels=c("Thu", "Fri", "Sat"))
dev.copy(png, file="plot2.png")
dev.off()

## Plot #3: ##################
plot(ts(d$Sub_metering_1, freq=1440, start=5), ylab="Energy sub metering", xaxt="n")
lines(ts(d$Sub_metering_2, freq=1440, start=5), col="red")
lines(ts(d$Sub_metering_3, freq=1440, start=5), col="blue")
legend("topright", pch="_", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, at=c(5,6,7), labels=c("Thu", "Fri", "Sat"))
dev.copy(png, file="plot3.png")
dev.off()

## Plot #4: ################## 

## begin 2x2 plot
par(mfrow=c(2,2))

# plot #1
plot(ts(d$Global_active_power, freq=1440, start=5), xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
axis(1, at=c(5,6,7), labels=c("Thu", "Fri", "Sat"))

# plot #2
plot(ts(d$Voltage, freq=1440, start=5), xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, at=c(5,6,7), labels=c("Thu", "Fri", "Sat"))

# plot #3
plot(ts(d$Sub_metering_1, freq=1440, start=5), xlab="", ylab="Energy sub metering", xaxt="n")
lines(ts(d$Sub_metering_2, freq=1440, start=5), col="red")
lines(ts(d$Sub_metering_3, freq=1440, start=5), col="blue")
legend("topright", pch="_", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex=.8)
axis(1, at=c(5,6,7), labels=c("Thu", "Fri", "Sat"))

# plot #4
plot(ts(d$Global_reactive_power, freq=1440, start=5), xlab="datetime", ylab="Global_reactive_power", xaxt="n")
axis(1, at=c(5,6,7), labels=c("Thu", "Fri", "Sat"))

## turn off 2x2
par(mfrow=c(1,1))

# save plot
dev.copy(png, file="plot4.png")
dev.off()
