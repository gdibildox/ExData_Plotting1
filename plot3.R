### read data

## reading first 5 rows to determine variable classes
data5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 5, na.strings = "?")
classes <- sapply(data5rows, class)

## read all data with known number of rows, classes and NA string (determined number of rows in txt file with: wc -l household_power_consumption.txt)
dataAll <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 2075260, colClasses = classes, na.strings = "?")

## convert Date data
dataAll$Date <- as.Date(dataAll$Date, "%d/%m/%Y") #DD/MM/YYYY

## perform subselection on dates of interest
dataSub <- dataAll[grep("2007-02-01", dataAll$Date)[1]:(grep("2007-02-03", dataAll$Date)[1]-1),]

## convert Time data
cols <- c( "Date" , "Time" )
dataSub$t <- apply( dataSub[ , cols ] , 1 , paste , collapse = " " )
dataSub$t <- strptime(dataSub$t, "%Y-%m-%d %H:%M:%S")

### create png file

png(file = "plot3.png",width = 480, height = 480)
plot(dataSub$t,dataSub$Sub_metering_1, type="l", xlab = "",ylab = "Energy sub metering (kilowatts)")
points(dataSub$t,dataSub$Sub_metering_2, type="l", col="red")
points(dataSub$t,dataSub$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=2, cex = 0.8, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))
dev.off()
