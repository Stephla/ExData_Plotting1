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

# Make a histogram of Global_active_power (plot1.png)
hist(dfs$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Save it to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(device = png, filename = "plot1.png", width = 480, height = 480)
dev.off()
