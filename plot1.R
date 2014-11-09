
#Download and unzip the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, dest = "household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")

#Load the data
powerConsumptionData <- read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)
# Convert Date to Date class
powerConsumptionData <- transform(powerConsumptionData,Date = as.Date(Date,"%d/%m/%Y"))
# Convert Time to POSIXct time format
powerConsumptionData <- transform(powerConsumptionData,Time = as.POSIXct(strptime(Time,"%H:%M:%S")))
#subset to just the dates of interest 
powerConsumptionData <- powerConsumptionData[powerConsumptionData$Date == "2007-02-01" | powerConsumptionData$Date == "2007-02-02",]
# convert Global_active_power to numeric class
powerConsumptionData <- transform(powerConsumptionData,  Global_active_power = as.numeric(Global_active_power ) )
#Open png device of specified size of 480 by 480 pixels
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
# generate the histogram with specified labels,color and axis limits 
hist(powerConsumptionData$Global_active_power , xlim=c(0,6), ylim=c(0,1200), col="red", main="Global Active Power", xlab = "Global active power(kilowatts)", ylab="Frequency", xaxt="n")
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2))
#save the file
dev.off()

