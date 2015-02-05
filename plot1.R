user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

source("loadData.R")
data.filtered <- loadData()

## creating plot1
print("creating plot1.png")

png(file ="plot1.png", bg="white", width=480, height=480)
with(data.filtered, hist(Global_active_power, main ="Global Active Power", col="orangered", xlab="Global Active Power (kilowatts)"))
dev.off()

Sys.setlocale("LC_TIME", user_lang)
