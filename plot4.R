user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")


if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

require("data.table")
require("dplyr")

## reading data
zipfile <- "exdata-data-household_power_consumption.zip"
if(!file.exists(zipfile))
{
  ### download dataset
  setInternet2(TRUE)
  zip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(zip, zipfile, mode="wb")  
  rm(zip)  
}

## unzip
unzippedFile <- "household_power_consumption.txt"
if(!file.exists(unzippedFile))
{
  print(zipfile)
  print(unzippedFile)
  unzip(zipfile, files = unzippedFile, list = FALSE, overwrite = TRUE,
        junkpaths = TRUE, exdir = ".", unzip = "internal",setTimes = FALSE)  
}

## reading data
data <- fread(unzippedFile, sep = ';')

## transforming dates
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## preparing filtered data
validDates <- c(as.Date("01/02/2007", "%d/%m/%Y"), as.Date("02/02/2007", "%d/%m/%Y"))
data.filtered <- filter(data, Date %in% validDates)
data.filtered$Global_active_power <- as.numeric(data.filtered$Global_active_power)
#data.filtered <- transform(data.filtered, dow=as.factor(format(data.filtered$Date, format="%a")))
data.filtered <- transform(data.filtered, 
                           tm2=strptime(paste(data.filtered$Date, data.filtered$Time), format="%Y-%m-%d %H:%M:%S"))

## creating plot1
print("creating plot4.png")

png(file ="plot4.png", bg="white", width=480, height=480)

par(mfcol=c(2,2))

# plot 1 - top left
plot(data.filtered$Global_active_power ~ data.filtered$tm2, type="l", ylab="global active power", xlab="")

#plot2 - bottom left
plot(data.filtered$Sub_metering_1 ~ data.filtered$tm2, type="l", ylab="Energy sub metering", xlab="")
lines(data.filtered$Sub_metering_2 ~ data.filtered$tm2, type="l", col="red")
lines(data.filtered$Sub_metering_3 ~ data.filtered$tm2, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), cex=0.5, lty="solid")

# plot 3 - top right
plot(data.filtered$Voltage ~ data.filtered$tm2, type="l", ylab="Voltage", xlab="datetime")

# plot 4 - bottom right
plot(data.filtered$Global_reactive_power~data.filtered$tm2, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()

Sys.setlocale("LC_TIME", user_lang)