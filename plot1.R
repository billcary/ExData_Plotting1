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

# Plot 1
with(subset, hist(subset$Global_active_power,
                  xlab = 'Global Active Power (kilowatts)',
                  ylab = 'Frequency', main = 'Global Active Power',
                  col = 'red'))


# Save the output to a png file
dev.copy(png, file = './figures/plot1.png')
dev.off()
