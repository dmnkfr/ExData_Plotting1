################################################################################
###    This script reads, tidies and organizes the household consumption     ###
###            dataset and creates plot nr 1 of the assessment.              ###
################################################################################

################################################################################
###                       Reading and organizing part                        ###
################################################################################
# read file
household <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
# check size in MB
object.size(household)/10^6
# check data
head(household)
# we only need the data between 2007-02-01 and 2007-02-02
# check date format
class(household$Date)
# returns character, use strptime() to convert to date
household$Date <- strptime(household$Date, "%e/%m/%Y")
# subset relevant data
householdSub <- subset(household, household$Date > "2007-01-31" & household$Date < "2007-02-03")
# remove original data set
rm(household)
# convert the date format
datetime <- paste(as.Date(householdSub$Date), householdSub$Time)
householdSub$Datetime <- as.POSIXct(datetime)
# check new subset
head(householdSub)
################################################################################
###                            Plotting part                                 ###
################################################################################
# change device
png('plot4.png', width = 480, height = 480)
# change layout AFTER device change!
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# plot to png
with(householdSub, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage (volt)", xlab="datetime")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="datetime")
})
# turn off device
dev.off()
# Voilà!