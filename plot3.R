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

# Plot 3
with(subset, plot(Time, Sub_metering_1,
                  ylab = 'Energy sub metering',
                  xlab = '', type = 'l'))
with(subset, points(Time, Sub_metering_2, type = 'l', col = 'red'))
with(subset, points(Time, Sub_metering_3, type = 'l', col = 'blue'))
legend('topright', lty = 1, col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))


# Save the output to a png file
dev.copy(png, file = './figures/plot3.png')
dev.off()
