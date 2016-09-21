# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

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
SCC.codes <- SCC[coal.combustion.indices, "SCC"]

# Sanity check of which categories have been subsetted
# unique(SCC[coal.combustion.indices, "EI.Sector"])

# Subset just the coal combustion sources
NEI.coal.combustion <- NEI[is.element(NEI$SCC, SCC.codes), ]

# Sum the total coal combustion emissions in US by year
coal.combustion.emissions <- tapply(NEI.coal.combustion$Emissions, 
                                    NEI.coal.combustion$year, 
                                    FUN=sum)
coal.combustion.emissions.thousands <- coal.combustion.emissions / 1000

# Build a data.frame
year <- as.integer(unlist(dimnames(coal.combustion.emissions.thousands)))
total <- as.numeric(coal.combustion.emissions.thousands)
emissions <- data.frame(cbind(year, total))

# Plot the results
cols <- brewer.pal(4, "Set1")
png(filename = "plot4.png", width = 480, height = 480)
g <- ggplot(emissions, aes(year, total))
print(g + geom_point(color = cols[1], size = 3) + 
           geom_smooth(method = "lm", 
                       linetype = "dashed", 
                       se = FALSE, 
                       aes(color = cols[1])) + 
           ggtitle("United States Total Coal Combustion-Related PM2.5 Emissions by Year") + 
           xlab("Year") +
           ylab("Coal Combustion-Related PM2.5 (in thousands of tons)") +
           theme(legend.position = "none"))
dev.off()