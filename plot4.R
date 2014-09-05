# Load libraries
library(dplyr)

# Read the data file
fulldata <- read.table('./data/household_power_consumption.txt', header = TRUE,
                       sep = ";", na.strings = "?")

# Subset on dates of interest using dplyr filter()
subset <- filter(fulldata, Date == '1/2/2007' | Date == '2/2/2007')

# Convert date/time character strings to actual dates/times
subset$Time <- strptime(paste(subset$Date, subset$Time, sep = ' '),
                        '%d/%m/%Y %H:%M:%S')
subset$Date <- as.Date(subset$Date, '%d/%m/%Y')

# Plot 4
par(mfrow = c(2,2))
with(subset, {
     
     # Plot the upper left figure
     plot(Time, Global_active_power,
          ylab = 'Global Active Power (kilowatts)',
          xlab = '', type = 'l')
     
     # Plot the upper right figure
     plot(Time, Voltage,
          ylab = 'Voltage',
          xlab = 'datetime', type = 'l')
     
     # Plot the lower left figure
     plot(Time, Sub_metering_1,
          ylab = 'Energy sub metering',
          xlab = '', type = 'l')
     points(Time, Sub_metering_2, type = 'l', col = 'red')
     points(Time, Sub_metering_3, type = 'l', col = 'blue')
     legend('topright', lty = 1, col = c('black', 'red', 'blue'), box.lwd = 0,
            box.col = NA, bg = NA,
            legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
     
     # Plot the lower right figure
     plot(Time, Global_reactive_power,
          ylab = 'Global_reactive_power',
          xlab = 'datetime', type = 'l')
})

# Save the output to a png file
dev.copy(png, file = './figures/plot4.png')
dev.off()
