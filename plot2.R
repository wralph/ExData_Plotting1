user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

source("loadData.R")
data.filtered <- loadData()

## creating plot2
print("creating plot2.png")

png(file ="plot2.png", bg="white", width=480, height=480)
with(data.filtered, plot(Global_active_power ~ DateTime, col="black", ylab="Global Active Power (kilowatts)", xlab="", type="l"))
dev.off()

Sys.setlocale("LC_TIME", user_lang)
