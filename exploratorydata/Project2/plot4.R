# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

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

# Find IDs of coal combustion-related sources
coal.combustion.indices <- grep("Coal", SCC$EI.Sector)
SCC.indices <- SCC[coal.combustion.indices, "SCC"]

# Subset to just include Baltimore City
NEI.Baltimore <- subset(NEI, fips=="24510")

# Subset by type
point <- subset(NEI.Baltimore, type=="POINT")
nonpoint <- subset(NEI.Baltimore, type=="NONPOINT")
onroad <- subset(NEI.Baltimore, type="ON-ROAD")
nonroad <- subset(NEI.Baltimore, type="NON-ROAD")

# Sum the total emissions by type and year
point <- tapply(point$Emissions, point$year, FUN=sum)
nonpoint <- tapply(nonpoint$Emissions, nonpoint$year, FUN=sum)
onroad <- tapply(onroad$Emissions, onroad$year, FUN=sum)
nonroad <- tapply(nonroad$Emissions, nonroad$year, FUN=sum)

# Build a data.frame
year <- as.integer(unlist(dimnames(point)))
point <- as.numeric(point)
nonpoint <- as.numeric(nonpoint)
onroad <- as.numeric(onroad)
nonroad <- as.numeric(nonroad)
emissions <- data.frame(cbind(year, point, nonpoint, onroad, nonroad))

# Convert data frame from wide to long for ggplot2
emissions <- gather(emissions, type, total, point:nonroad, factor_key=TRUE)

# Plot the results
cols <- brewer.pal(4, "Set1")
cols.lines <- c(cols[2], cols[4], cols[3], cols[1])
cols.lines <- rep(cols.lines, each = 4)
cols.points <- rep(cols, each = 4)
png(filename = "plot3.png", width = 480, height = 480)
g <- ggplot(emissions, aes(year, total))
print(g + geom_point(color = cols.points, size = 3) + 
           facet_grid(. ~ type) + 
           geom_smooth(method = "lm", 
                       linetype = "dashed", 
                       se = FALSE, 
                       aes(color = cols.lines)) + 
           ggtitle("Baltimore City Total PM2.5 Emissions by Type") + 
           ylab("PM2.5 (in tons)") +
           theme(legend.position = "none"))
dev.off()
