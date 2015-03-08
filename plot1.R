# $Id: plot1.R,v 1.3 2015/03/08 02:44:02 richard Exp richard $

host.name <- "https://d396qusza40orc.cloudfront.net"
file.name <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
save.name <- "household_power_consumption.zip"
full.name <- sprintf("%s/%s", host.name, file.name)
download.file(full.name, save.name, "wget")

house.power <- read.table(unz("household_power_consumption.zip",
							  "household_power_consumption.txt"),
                          header=TRUE,
                          stringsAsFactors=FALSE,
                          sep=";")

relevant.dates <- c("1/2/2007",
                    "2/2/2007")

house.power.subset <- subset(house.power,
                             house.power$Date %in% relevant.dates,
                             select = c("Date",
                                        "Time",
                                        "Global_active_power",
                                        "Global_reactive_power",
                                        "Voltage",
                                        "Global_intensity",
                                        "Sub_metering_1",
                                        "Sub_metering_2",
                                        "Sub_metering_3"))

Date.Time <- strptime(paste(house.power.subset$Date,
                      house.power.subset$Time),
					  "%d/%m/%Y %H:%M:%S")

house.power.subset <- cbind(house.power.subset, Date.Time)

png(filename="plot1.png",
    width=480,
    height=480,
    units="px")

hist(as.numeric(house.power.subset$Global_active_power),
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power",
     col="red",
     plot=TRUE)

dev.off()

# end of plot1.R

