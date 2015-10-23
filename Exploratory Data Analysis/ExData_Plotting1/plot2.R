## Author: John Letteboer
## Date: October 6, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 1
## ---------------------------------------------
## This is script 2/4
## Output is plot2.png

pngfile <- "plot2.png"

source("load_dataset.R")

# Setting output to png file
png(pngfile, width=480, height=480)

plot(df$Time, df$Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     main="")

#"Finish" the image
dev.off()
