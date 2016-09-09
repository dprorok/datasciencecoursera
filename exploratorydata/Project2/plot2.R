# Have total emissions from PM2.5 decreased in the  Baltimore City, Maryland 
# (fips == 24510) from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

# Note: The below code has serious signs of "gold-plating", particularly
# when one considers these are supposed to just be exploratory graphs. I took
# liberties to play around with all the nifty functions we were introduced to
# including the ability to monkey with plot paramters and the RColorBrewer
# package.

library(RColorBrewer)

#Global variables: mostly consists of filenames and locations
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dataDirectory <- "ProjectData"
destFile <- "NEI_data.zip"
SCCtableFile <- "Source_Classification_Code.rds"
NEIfile <- "summarySCC_PM25.rds"

# Download and unzip the dataset if not done so already
get.data <- function() {
     if(!file.exists(dataDirectory)) {
          dir.create(file.path(getwd(), dataDirectory))
     }
     
     if (!file.exists(file.path(getwd(), dataDirectory, destFile))){
          download.file(fileURL, 
                        file.path(getwd(), dataDirectory, destFile), 
                        method="curl")
          dateDownloaded <- Sys.Date()
     }
     
     if (!file.exists(file.path(getwd(), dataDirectory, SCCtableFile)) ||
         !file.exists(file.path(getwd(), dataDirectory, NEIfile))) { 
          unzip(file.path(getwd(), dataDirectory, destFile), 
                exdir = file.path(getwd(), dataDirectory))
     }        
}

load.NEIfile <- function() {
     NEI <- readRDS(file.path(getwd(), dataDirectory, NEIfile))
     return(NEI)
}

load.SCCtableFile <- function() {
     SCC <- readRDS(file.path(getwd(), dataDirectory, SCCtableFile))
     return(SCC)
}

# Download, unzip, and load in the data
get.data()
if(!exists("NEI")) {
     NEI <- load.NEIfile()
}

# Subset to just include Baltimore City
NEI.Baltimore <- subset(NEI, fips=="24510")

# Sum the total emissions by year
total.emissions <- tapply(NEI.Baltimore$Emissions, NEI.Baltimore$year, FUN=sum)

year <- as.integer(unlist(dimnames(total.emissions)))
total.emissions <- as.numeric(total.emissions)
emissions <- data.frame(cbind(year, total.emissions))

fit <- lm(total.emissions ~ year, data = emissions)

# Plot the results
cols <- brewer.pal(3, "Set1")
png(filename = "plot2.png", width = 480, height = 480)
xticks <- seq(1998, 2009, 1)
yticks <- seq(1800, 3400, 200)
plot(emissions$year, emissions$total.emissions,
     type = "p",
     pch = 19,
     col = cols[1],
     xlab = "Year",
     ylab = "PM2.5 (in tons)",
     main = "Baltimore City Total PM2.5 Emissions From All Sources by Year",
     xlim = c(1998, 2009),
     ylim = c(1800, 3400),
     axes = FALSE)
axis(1, at = xticks, labels = xticks)
axis(2, at = yticks, labels = yticks)
abline(fit, lwd = "3", lty = "dashed", col = cols[1])
dev.off()
