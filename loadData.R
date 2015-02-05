loadData <- function() {
	
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
	data <- fread(unzippedFile, sep = ';', colClasses="character",  na="?")

	## transforming dates
	data$Date <- as.Date(data$Date, "%d/%m/%Y")

	## preparing filtered data
	validDates <- c(as.Date("01/02/2007", "%d/%m/%Y"), as.Date("02/02/2007", "%d/%m/%Y"))
	data.filtered <- filter(data, Date %in% validDates)

	data.filtered$Global_active_power <- as.numeric(data.filtered$Global_active_power)	
	data.filtered$Global_reactive_power <- as.numeric(data.filtered$Global_reactive_power)	
	
	data.filtered$Voltage <- as.numeric(data.filtered$Voltage)	
	data.filtered$Global_intensity <- as.numeric(data.filtered$Global_intensity)	
	
	data.filtered$Sub_metering_1 <- as.numeric(data.filtered$Sub_metering_1)	
	data.filtered$Sub_metering_2 <- as.numeric(data.filtered$Sub_metering_2)	
	data.filtered$Sub_metering_3 <- as.numeric(data.filtered$Sub_metering_3)	
	data.filtered <- transform(data.filtered, 
                           DateTime=strptime(paste(data.filtered$Date, data.filtered$Time), format="%Y-%m-%d %H:%M:%S"))

}