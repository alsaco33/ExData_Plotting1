library(tidyr)
library(dplyr)
Sys.setlocale("LC_TIME", "C")
data <- read.table('household_power_consumption.txt', header = TRUE, sep = ";", dec = ".")
data$Date <- as.Date(data$Date, '%d/%m/%Y')
reduced <- data[data$Date >= as.Date('2007/02/01', '%Y/%m/%d') & data$Date <= as.Date('2007/02/02', '%Y/%m/%d'),]
reduced <- transform(reduced, Global_active_power = as.numeric(Global_active_power),
                     Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage), 
                     Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric(Sub_metering_1), 
                     Sub_metering_2 = as.numeric(Sub_metering_2), Sub_metering_3 = as.numeric(Sub_metering_3),
                     date_time = as.POSIXct(paste(reduced$Date, reduced$Time), format='%Y-%m-%d %H:%M:%S'))
png('plot4.png')
par(mfrow = c(2,2))
plot(reduced$date_time, reduced$Global_active_power/500, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')

plot(reduced$date_time, reduced$Voltage/3.4, type = 'l', xlab = 'datetime', ylab = 'Voltage')
#axis(side = 2, at = seq(234,246,by=4), labels = seq(234,246,by=4))



plot(reduced$date_time, reduced$Sub_metering_3, type = 'l', col = 'blue', xlab = '', ylab = '', ylim = c(0,40), yaxt="n")
par(new = TRUE)
plot(reduced$date_time, reduced$Sub_metering_2/5, type = 'l', col = 'red', xlab = '', ylab = '', ylim = c(0,40), yaxt="n")
par(new = TRUE)
plot(reduced$date_time, reduced$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering', ylim = c(0,40), yaxt="n")
axis(side = 2, at = seq(0,30,by=10), labels = seq(0,30,by=10))
legend('topright', legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("red", "orange","blue"), lty = 1, cex = 0.6, xjust = 0.5)


plot(reduced$date_time, reduced$Global_reactive_power/400, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l')

dev.off()