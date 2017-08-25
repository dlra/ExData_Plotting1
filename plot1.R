#################################
# Exploratory Data Analysis
# Week 1 Project
# Plot 1: Histogram of Global Active Power
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
UC_data <- data.frame(
  sapply(UC_data,function(x)
  {
    if(is.factor(x)) as.numeric(as.character(x))
    else x
  }
  )
)
# plot1
par(mar = c(5,2,3,0),
    mfrow = c(1,1),
    pty = "m"
)
hist(UC_data$Global_active_power,
     main ="",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red",
     cex.axis = 0.8,
     cex.lab = 0.9,
     cex.main = 0.8,
     font.main = 15,
     font.axis = 1,
     font.lab = 18,
     family = "sans",
     mgp = c(2.5,0.9,0)
)
title("Global Active Power",
      cex.main = 0.9,
      line = 1)
dev.copy(png, file = "plot1.png")
dev.off()