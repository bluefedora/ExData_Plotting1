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

#build datetime character vector 
dv <- paste(consumption$Date, consumption$Time)

#convert time characters to POSIXlt date/time class
consumption$Time <- strptime(dv, format="%d/%m/%Y %H:%M:%S")

#convert date characters to date class
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")

#produce plot 2
png("plot2.png")
plot(consumption$Time, consumption$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()

