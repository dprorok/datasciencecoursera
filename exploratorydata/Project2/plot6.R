# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California 
# (fips ==“06037”). Which city has seen greater changes over time in motor 
# vehicle emissions?

library(RColorBrewer)
library(ggplot2)
library(tidyr)

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

# Subset to just include Baltimore City and LA
NEI.Balt <- subset(NEI, fips=="24510")
NEI.LA <- subset(NEI, fips=="06037")

# Subset just the motor vehicle sources
NEI.Balt.vehicles <- NEI.Balt[is.element(NEI.Balt$SCC, SCC.codes), ]
NEI.LA.vehicles <- NEI.LA[is.element(NEI.LA$SCC, SCC.codes), ]

# Sum the motor vehicle emissions in each city by year
Balt.vehicle.emissions <- tapply(NEI.Balt.vehicles$Emissions,
                                 NEI.Balt.vehicles$year,
                                 FUN=sum)

LA.vehicle.emissions <- tapply(NEI.LA.vehicles$Emissions,
                                 NEI.LA.vehicles$year,
                                 FUN=sum)

# Build a data.frame
year <- as.integer(unlist(dimnames(Balt.vehicle.emissions)))
Baltimore <- as.numeric(Balt.vehicle.emissions)
LA <- as.numeric(LA.vehicle.emissions)
emissions <- data.frame(cbind(year, Baltimore, LA))

# Convert data frame from wide to long for ggplot2
emissions <- gather(emissions, city, total, Baltimore:LA, factor_key=TRUE)

# Plot the results
cols <- brewer.pal(4, "Set1")
cols <- cols[1:2]
cols.lines <- rep(cols[2:1], each = 4)
cols.points <- rep(cols, each = 4)
png(filename = "plot6.png", width = 480, height = 480)
g <- ggplot(emissions, aes(year, total))
# Explicit call to print() required to output results to file
print(g + geom_point(color = cols.points, size = 3) + 
           facet_grid(. ~ city) + 
           geom_smooth(method = "lm", 
                       linetype = "dashed", 
                       se = FALSE, 
                       aes(color = cols.lines)) + 
           ggtitle("Baltimore City vs Los Angeles Motor Vehicle PM2.5 Emissions") + 
           xlab("Year") +
           ylab("PM2.5 (in tons)") +
           theme(legend.position = "none"))
dev.off()
