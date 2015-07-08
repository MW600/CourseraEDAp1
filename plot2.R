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

png(filename="plot2.png", width = 480, height = 480, units = "px")
with(data,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",
               xlab=""))
dev.off()