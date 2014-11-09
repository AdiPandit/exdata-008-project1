#Download and unzip the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, dest = "household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")

#Load the data
powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE) 
#Adjust time to incorporate date from adjacent Date column
powerConsumptionData <- transform(powerConsumptionData,  Time = paste(Date,Time,sep=" "))

#transform date and time to correct classes
powerConsumptionData <- transform(powerConsumptionData, Date = as.Date(Date,"%d/%m/%Y"))
powerConsumptionData <- transform(powerConsumptionData, Time = strptime(powerConsumptionData$Time, format="%d/%m/%Y %T"))

#subset to just the dates of interest 
powerConsumptionData <- powerConsumptionData[powerConsumptionData$Date == "2007-02-01" | powerConsumptionData$Date == "2007-02-02",]
powerConsumptionData <- transform(powerConsumptionData,  Global_active_power = as.numeric(Global_active_power ) )

#Create png device
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

#Plot the Global_active_power against time
plot(powerConsumptionData$Time,powerConsumptionData$Global_active_power, type="l",ylab="Global Active Power(kilowatts)",xlab="")
#Save the file
dev.off()