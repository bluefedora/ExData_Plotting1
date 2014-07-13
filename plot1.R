## Author: BlueFedora
## Version 1.1
## Updated 7/13/2014 

#download and unzip data file function
blueFedoraDownload <- function (fileURL, destfile, method="auto", exdir=".") {
    if(!file.exists("./data")) {
        dir.create("./data")
    }
    if (!file.exists(destfile)) {
        download.file(fileURL, destfile=destfile, method=method)
        unzip(destfile, exdir=exdir)
    }
}

#download and unzip the data file if needed
destfile <- "./data/householdPowerConsumption.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
blueFedoraDownload(fileURL, destfile, exdir="./data", method="curl")

#set data file path and name, season to taste
dataFile <- "./data/household_power_consumption.txt" 

# read data into data set
full.data.set <- read.csv(dataFile, sep=";", na.strings="?")

#subset, use only selected days
consumption <- subset(full.data.set, Date=="1/2/2007" | Date=="2/2/2007")

#remove large data set from envirnoment
rm(full.data.set)

#produce plot1
png("plot1.png")
hist(consumption$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()
                        