library(lubridate)

colNames <- as.character(read.table("household_power_consumption.txt", 
                                    sep=";", nrows=1, 
                                    stringsAsFactors = FALSE))

colClasses <- c("character", "character", "numeric", "numeric", "numeric", 
                "numeric", "numeric", "numeric", "numeric")

#My computer is eight years old and I'm impatient, so I'm loading in
#only the data I need and not one ounce more.
data <- read.table("household_power_consumption.txt", sep=";",
                   na.strings = "?", nrows=2880, skip=66637, 
                   col.names = colNames,
                   colClasses=colClasses)

data$Date <- dmy(data$Date)
data$Time <- strptime(data$Time, "%H:%M:%S", tz="CET")
data$Time <- update(data$Time, day=day(data$Date), 
                    month=month(data$Date), year=year(data$Date))

png(filename = "plot2.png", width = 480, height = 480)
with(data, plot(Time, Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()