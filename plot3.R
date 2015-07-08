####################
        #          #
        #   DATA   #
        #          #
        ####################

#download data
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "exdata_data_household_power_consumption.zip")

#open file and read data
data <- read.table(file = unz("exdata_data_household_power_consumption.zip",
                              "household_power_consumption.txt"), header = TRUE,
                   sep=";", na.strings = "?")

#transform & subset data
#add POSIXct column DateTime
data["DateTime"] <- paste(as.character(data$Date),' ',as.character(data$Time))
data$DateTime <- strptime(x = data$DateTime, format = "%d/%m/%Y %H:%M:%S")

#subset by dates
begin <- as.POSIXct("2007-02-01")
logi <- data[,10] >= begin
data <- data[logi,]
end <- as.POSIXct("2007-02-03")
logi <- data[,10] < end
data <- data[logi,]

#final set
data <- data[!is.na(data[,1]),]


####################
        #          #
        #   PLOT   #
        #          #
        ####################


png(filename="plot3.png",width = 480,height = 480,units = "px")

#Add data to plot
plot(data$DateTime,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(x = data$DateTime, y = data$Sub_metering_2, type="l", col="red")
lines(x = data$DateTime, y = data$Sub_metering_3, type="l", col="blue")
#Add legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=1, lwd=1, bty="o");

dev.off()

