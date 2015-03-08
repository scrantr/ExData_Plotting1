# $Id: plot4.R,v 1.5 2015/03/08 02:44:02 richard Exp richard $

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

png(filename="plot4.png",
    width=480,
    height=480,
    units="px")

par(mfcol=c(2,2))

# upper left
plot(house.power.subset$Date.Time,
     as.numeric(house.power.subset$Global_active_power),
     type="l",
     xlab="",
     ylab="Global Active Power",
     main="")

# lower left
ylimits <- range(c(as.numeric(house.power.subset$Sub_metering_1),
                   as.numeric(house.power.subset$Sub_metering_2),
                   as.numeric(house.power.subset$Sub_metering_3)))

plot(house.power.subset$Date.Time,
     rep(ylimits[2], length(house.power.subset$Date.Time)),
     type="n",
     ylim=c(ylimits[1], ylimits[2]),
     xlab="",
     ylab="Energy sub metering")

lines(house.power.subset$Date.Time,
      as.numeric(house.power.subset$Sub_metering_1),
      type="l",
      col="black")

lines(house.power.subset$Date.Time,
      as.numeric(house.power.subset$Sub_metering_2),
      type="l",
      col="red")

lines(house.power.subset$Date.Time,
      as.numeric(house.power.subset$Sub_metering_3),
      type="l",
      col="blue")

legendary <- c("Sub_metering_1",
               "Sub_metering_2",
               "Sub_metering_3")

colorful <- c("black",
              "red",
              "blue")

legend("topright",
       legendary,
       col=colorful,
       bty="n",
       text.col="black",
       lty="solid")

# upper right
plot(house.power.subset$Date.Time,
     house.power.subset$Voltage,
     type="l",
     main="",
     xlab="datetime",
     ylab="Voltage")

# lower right
plot(house.power.subset$Date.Time,
     house.power.subset$Global_reactive_power,
     type="l",
     main="",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()

# end of plot4.R

