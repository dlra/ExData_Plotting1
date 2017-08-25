#################################
# Exploratory Data Analysis
# Week 1 Project
# Plot 4: Multiplot
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
# plot4
par(mfcol = c(2,2),
    mar = c(4,4,3,1),
    pty = "m",
    lwd = 0.9
)
# (1,1)
with(UC_data,
     plot(dateTime,Global_active_power,
          type = "l",
          xlab="",
          ylab="Global Active Power",
          cex.axis = 0.9,
          cex.lab = 0.9,
          mgp = c(2.6,0.9,0)
     )
)
# (2,1)
with(UC_data, {
  plot(dateTime,Sub_metering_1,
       type = "n",
       xlab="",
       ylab="Energy sub metering",
       cex.axis = 0.9,
       cex.lab = 0.9,
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
       cex = 0.8,
       bty = "n"
)
# (1,2)
with(UC_data,
     plot(dateTime,Voltage,
          type = "l",
          xlab="datetime",
          ylab="Voltage",
          cex.axis = 0.9,
          cex.lab = 0.9,
          mgp = c(2.6,0.9,0)
     )
)
# (2,2)
with(UC_data,
     plot(dateTime,Global_reactive_power,
          type = "l",
          xlab="datetime",
          cex.axis = 0.9,
          cex.lab = 0.9,
          mgp = c(2.6,0.9,0)
     )
)
dev.copy(png, file = "plot4.png")
dev.off()