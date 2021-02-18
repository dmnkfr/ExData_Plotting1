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
png('plot2.png', width = 480, height = 480)
# plot to png
plot(householdSub$Global_active_power~householdSub$Datetime, 
     type="l", 
     xlab = "",
     ylab = "Global Active Power (kilowatts")

# turn off device
dev.off()
# Voilà!
