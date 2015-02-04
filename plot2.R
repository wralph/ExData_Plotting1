
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
print("creating plot1.png")

png(file ="plot2.png", bg="white", width=480, height=480)
par(mar = c(3,4,4,2))
##with(data.filtered, hist(Global_active_power, dow, main ="Global Active Power", col="orangered", xlab="Global Active Power (kilowatts)"))
with(data.filtered, plot(Global_active_power ~ tm2, main ="Global Active Power", col="black", ylab="Global Active Power (kilowatts)", type="l"))
dev.off()


as.factor(format(data.filtered$Date, format="%a"))