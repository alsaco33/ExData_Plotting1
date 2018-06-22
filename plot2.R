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
png('plot2.png')
plot(reduced$date_time, reduced$Global_active_power/500, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()
