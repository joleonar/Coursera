## Author: John Letteboer
## Date: October 6, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 1
## ---------------------------------------------
## This is script 3/4
## Output is plot3.png

pngfile <- "plot3.png"

source("load_dataset.R")

# Setting output to png file
png(pngfile, width=480, height=480)

plot(df$Time, df$Sub_metering_1, 
     type="l", 
     xlab="",
     ylab="Energy sub metering",
     main="",
     col = "black")
lines(df$Time, df$Sub_metering_2, type="l", col = "red")
lines(df$Time, df$Sub_metering_3, type="l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=1)

#"Finish" the image
dev.off()