## Author: John Letteboer
## Date: October 6, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 1
## ---------------------------------------------
## This is script 1/4
## Output is plot1.png

pngfile <- "plot1.png"

source("load_dataset.R")

# Setting output to png file
png(pngfile, width=480, height=480)

hist(df$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")

#"Finish" the image
dev.off()

