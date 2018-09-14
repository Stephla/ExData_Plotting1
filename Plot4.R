# Read dataset household_power_consumption.txt
df <- read.table("household_power_consumption.txt", 
                 header=TRUE, 
                 sep=";", 
                 na.strings = "?", 
                 colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Convert "Date" to Date class
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# subset specific dates
dfs <- subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# for plot2.png, date and time need to be combined 
date_time <- paste(dfs$Date, dfs$Time)

# add column to table
dfs <- cbind(date_time, dfs)

# format column
dfs$date_time <- as.POSIXct(date_time)

# delete missing case
dfs <- dfs[complete.cases(dfs),]

# delete separate date and time columns (redundant)
dfs <- dfs[ ,!(names(dfs) %in% c("Date","Time"))]

#--------------------------------------------------------

# picture 4 different plots (plot4.png)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(dfs, plot(Global_active_power ~ date_time, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(dfs, plot(Voltage ~ date_time, type = "l", ylab = "Voltage (volt)", xlab = ""))
with(dfs, plot(Sub_metering_1 ~ date_time, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(dfs, lines(Sub_metering_2 ~ date_time, col = 'red'))
with(dfs, lines(Sub_metering_3 ~ date_time, col = 'blue'))
legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  "))
with(dfs, plot(Global_reactive_power ~ date_time, type = "l", ylab = "Global Rective Power (kilowatts)", xlab = ""))

# Save it to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(device = png, filename = "plot4.png", width = 480, height = 480)
dev.off()
