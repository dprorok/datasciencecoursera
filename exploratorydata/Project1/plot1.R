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

png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col="red", main="Global Active Power", 
     xlab="GlobalActivePower (kilowatts")
dev.off()