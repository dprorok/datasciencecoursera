# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

library(RColorBrewer)
library(ggplot2)

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
if(!exists("SCC")) {
     SCC <- load.SCCtableFile()
}

# Find IDs of motor vehicle sources
motor.vehicle.indices <- grep("Vehicle", SCC$SCC.Level.Two)
SCC.codes <- SCC[motor.vehicle.indices, "SCC"]

# Sanity check of which categories have been subsetted
#unique(SCC[motor.vehicle.indices, "SCC.Level.Two"])

# Subset to just include Baltimore City
NEI.Baltimore <- subset(NEI, fips=="24510")

# Subset just the motor vehicle sources
NEI.Baltimore.vehicles <- NEI.Baltimore[is.element(NEI.Baltimore$SCC, SCC.codes), ]

# Sum the motor vehicle emissions in Baltimore by year
Balt.vehicle.emissions <- tapply(NEI.Baltimore.vehicles$Emissions,
                                 NEI.Baltimore.vehicles$year,
                                 FUN=sum)

# Build a data.frame
year <- as.integer(unlist(dimnames(Balt.vehicle.emissions)))
total <- as.numeric(Balt.vehicle.emissions)
emissions <- data.frame(cbind(year, total))

# Plot the results
cols <- brewer.pal(4, "Set1")
png(filename = "plot5.png", width = 480, height = 480)
g <- ggplot(emissions, aes(year, total))
print(g + geom_point(color = cols[1], size = 3) + 
           geom_smooth(method = "lm", 
                       linetype = "dashed", 
                       se = FALSE, 
                       aes(color = cols[1])) + 
           ggtitle("Baltimore City Total Motor Vehicle PM2.5 Emissions by Year") + 
           xlab("Year") +
           ylab("Motor Vehicle PM2.5 (in tons)") +
           theme(legend.position = "none"))
dev.off()