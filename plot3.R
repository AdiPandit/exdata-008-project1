
#Download and unzip the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, dest = "household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")

#Load the data into a data table
powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE) 

#Adjust time to incorporate the date from the adjacent date column
powerConsumptionData <- transform(powerConsumptionData,  Time = paste(Date,Time,sep=" "))

# Convert date and time to correct classes
powerConsumptionData <- transform(powerConsumptionData, Date = as.Date(Date,"%d/%m/%Y"))
powerConsumptionData <- transform(powerConsumptionData, Time = strptime(powerConsumptionData$Time, format="%d/%m/%Y %T"))
#subset to just the dates of interest 
powerConsumptionData <- powerConsumptionData[powerConsumptionData$Date == "2007-02-01" | powerConsumptionData$Date == "2007-02-02",]

#Convert values of interest to numeric type
powerConsumptionData <- transform(powerConsumptionData,  Global_active_power = as.numeric(Global_active_power ) )
powerConsumptionData <- transform(powerConsumptionData,  Sub_metering_1 = as.numeric(Sub_metering_1 ) )
powerConsumptionData <- transform(powerConsumptionData,  Sub_metering_2 = as.numeric(Sub_metering_2 ) )
powerConsumptionData <- transform(powerConsumptionData,  Sub_metering_3 = as.numeric(Sub_metering_3 ) )

#Open png device
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

#start the plot with Sub_metering_1
plot(powerConsumptionData$Time,powerConsumptionData$Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab="")

#Add Sub_metering_2 with red line
points(powerConsumptionData$Time,powerConsumptionData$Sub_metering_2, type="l", col ="red")

#Add Sub_metering_3 with blue line
points(powerConsumptionData$Time,powerConsumptionData$Sub_metering_3, type="l", col ="blue")

# Add the legend for the 3 sub_metering values plotted
legend("topright", lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Save the file
dev.off()