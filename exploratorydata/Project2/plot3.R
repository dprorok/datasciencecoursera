# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

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

# Subset by type


# Sum the total emissions by type and year


# Sum the total emissions by year
total.emissions <- tapply(NEI.Baltimore$Emissions, NEI.Baltimore$year, FUN=sum)
total.emissions.thousands <- total.emissions / 1000

# Plot the results
png(filename = "plot3.png", width = 480, height = 480)


dev.off()
