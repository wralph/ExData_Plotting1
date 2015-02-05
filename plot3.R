user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

source("loadData.R")
data.filtered <- loadData()

## creating plot3
print("creating plot3.png")

png(file="plot3.png", bg="white", width=480, height=480)

plot(data.filtered$Sub_metering_1 ~ data.filtered$DateTime, type="l", ylab="Energy sub metering", xlab="")
lines(data.filtered$Sub_metering_2 ~ data.filtered$DateTime, type="l", col="red")
lines(data.filtered$Sub_metering_3 ~ data.filtered$DateTime, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), cex=0.75, lty="solid")

dev.off()

Sys.setlocale("LC_TIME", user_lang)
