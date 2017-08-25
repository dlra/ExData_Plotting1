#################################
# Exploratory Data Analysis
# Week 1 Project
# Plot 2: Time series of Global Active Power
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
# plot2
par(
  mar = c(5,2,3,0),
  mfrow = c(1,1),
  pty = "s"
)
with(UC_data,
     plot(dateTime,Global_active_power,
          type = "l",
          xlab="",
          ylab="Global Active Power (kilowatts)",
          cex.axis = 0.8,
          cex.lab = 0.8,
          mgp = c(2.6,0.9,0)
     )
)
dev.copy(png, file = "plot2.png")
dev.off()