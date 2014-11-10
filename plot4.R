#Download and unzip the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, dest = "household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")
powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE) 
#Adjust time to incorporate correct date from the Date column
powerConsumptionData <- transform(powerConsumptionData,  Time = paste(Date,Time,sep=" "))

#Convert date and time to correct classes
powerConsumptionData <- transform(powerConsumptionData, Date = as.Date(Date,"%d/%m/%Y"))
powerConsumptionData <- transform(powerConsumptionData, Time = strptime(powerConsumptionData$Time, format="%d/%m/%Y %T"))

#subset to just the dates of interest 
powerConsumptionData <- powerConsumptionData[powerConsumptionData$Date == "2007-02-01" | powerConsumptionData$Date == "2007-02-02",]

#Turn values of interest to numeric
powerConsumptionData <- transform(powerConsumptionData,  Global_active_power = as.numeric(Global_active_power ) )
powerConsumptionData <- transform(powerConsumptionData,  Global_reactive_power = as.numeric(Global_reactive_power ) )
powerConsumptionData <- transform(powerConsumptionData,  Voltage = as.numeric(Voltage ) )
powerConsumptionData <- transform(powerConsumptionData,  Sub_metering_1 = as.numeric(Sub_metering_1 ) )
powerConsumptionData <- transform(powerConsumptionData,  Sub_metering_2 = as.numeric(Sub_metering_2 ) )
powerConsumptionData <- transform(powerConsumptionData,  Sub_metering_3 = as.numeric(Sub_metering_3 ) )

#Open a png device
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

#set number of rows and cols to 2 by 2
par(mfrow = c(2,2))

#plot the first graph for Gobal_active_power
plot(powerConsumptionData$Time,powerConsumptionData$Global_active_power, type="l",ylab="Global Active Power",xlab="", cex.lab=0.8)

#plot the second graph for Voltage
plot(powerConsumptionData$Time,powerConsumptionData$Voltage, type="l",ylab="Voltage",xlab="datetime",cex.lab = 0.8)

#Create the third plot for sub-metering values
plot(powerConsumptionData$Time,powerConsumptionData$Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab="",cex.lab = 0.7)
points(powerConsumptionData$Time,powerConsumptionData$Sub_metering_2, type="l", col ="red")
points(powerConsumptionData$Time,powerConsumptionData$Sub_metering_3, type="l", col ="blue")
legend("topright", lty=c(1,1,1), lwd=c(1,1,1), col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  cex=0.5)

#Create the fourth plot for Global_reactive_power
plot(powerConsumptionData$Time,powerConsumptionData$Global_reactive_power, type="l",ylab="Global_reactive_power",xlab="datetime",cex.lab=0.8)

#Save the file
dev.off()