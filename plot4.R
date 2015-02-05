user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

source("loadData.R")
data.filtered <- loadData()

## creating plot4
print("creating plot4.png")

png(file ="plot4.png", bg="white", width=480, height=480)

par(mfcol=c(2,2))

# plot 1 - top left
plot(data.filtered$Global_active_power ~ data.filtered$DateTime, type="l", ylab="global active power", xlab="")

# plot2 - bottom left
plot(data.filtered$Sub_metering_1 ~ data.filtered$DateTime, type="l", ylab="Energy sub metering", xlab="")
lines(data.filtered$Sub_metering_2 ~ data.filtered$DateTime, type="l", col="red")
lines(data.filtered$Sub_metering_3 ~ data.filtered$DateTime, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), cex=0.5, lty="solid")

# plot 3 - top right
plot(data.filtered$Voltage ~ data.filtered$DateTime, type="l", ylab="Voltage", xlab="datetime")

# plot 4 - bottom right
plot(data.filtered$Global_reactive_power ~ data.filtered$DateTime, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()

Sys.setlocale("LC_TIME", user_lang)