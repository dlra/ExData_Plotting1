#################################
# Exploratory Data Analysis
# Week 1 Project
# Plot 3: Time Series for Energy Sub Metering
# DLRA
# 25/8/17
#################################

## read data, subset by date, reformat
UC_data<-read.table(file="household_power_consumption.txt",header = T,sep=";",
                    colClasses = c(rep("character",2),rep(NA,7)))
UC_data$Date <- as.Date(UC_data$Date,format = "%d/%m/%Y")
UC_data <- UC_data[UC_data$Date==as.Date("2007-02-01") |
                     UC_data$Date==as.Date("2007-02-02"),]
UC_data$dateTime <- strptime(paste(UC_data$Date,UC_data$Time,sep=" "),
                             "%Y-%m-%d %H:%M:%S")
# check class of variables
sapply(UC_data, class)
# further reformat
UC_data <- data.frame(
  sapply(UC_data,function(x)
  {
    if(is.factor(x)) as.numeric(as.character(x))
    else x
  }
  )
)
# plot3
par(
  mar = c(5,2,3,0),
  mfrow = c(1,1),
  pty = "s"
)
with(UC_data, {
  plot(dateTime,Sub_metering_1,
       type = "n",
       xlab="",
       ylab="Energy sub metering",
       cex.axis = 0.8,
       cex.lab = 0.8,
       mgp = c(2.6,0.9,0)
  )
  lines(dateTime,Sub_metering_1,
        col = "black"
  )
  lines(dateTime,Sub_metering_2,
        col = "red"
  )
  lines(dateTime,Sub_metering_3,
        col = "blue"
  )
})
legend("topright",
       lty = "solid",
       #pch = 3,
       col = c("black","red","blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       cex = 0.75
)
dev.copy(png, file = "plot3.png")
dev.off()