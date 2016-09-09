# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

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

# Sum the total emissions by year
total.emissions <- tapply(NEI$Emissions, NEI$year, FUN=sum)
total.emissions.millions <- total.emissions / 1000000

year <- as.integer(unlist(dimnames(total.emissions.millions)))
total.emissions.millions <- as.numeric(total.emissions.millions)
emissions <- data.frame(cbind(year, total.emissions.millions))

fit <- lm(total.emissions.millions ~ year, data = emissions)

# Plot the results
cols <- brewer.pal(3, "Set1")
png(filename = "plot1.png", width = 480, height = 480)
xticks <- seq(1998, 2009, 1)
yticks <- seq(3, 8, .5)
plot(emissions$year, emissions$total.emissions.millions,
     type = "p",
     pch = 19,
     col = cols[1],
     xlab = "Year",
     ylab = "PM2.5 (in millions of tons)",
     main = "United States Total PM2.5 Emissions From All Sources by Year",
     xlim = c(1998, 2009),
     ylim = c(3, 8),
     axes = FALSE)
axis(1, at = xticks, labels = xticks)
axis(2, at = yticks, labels = yticks)
abline(fit, lwd = "3", lty = "dashed", col = cols[1])
dev.off()
