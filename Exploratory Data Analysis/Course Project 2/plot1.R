## Author: John Letteboer
## Date: October 23, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 2
## ---------------------------------------------
## Question 1
##
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.
## 
## Output:
## -------
## plot1.R end plot1.png

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# First we'll aggregate the total PM2.5 emission from all sources for each of the 
# years 1999, 2002, 2005, and 2008
agg <- aggregate(Emissions ~ year, NEI, sum)

# Setting output to png file
png('plot1.png')

# Creating a barplot to see if total emissions have decreased in the US from 1999 to 2008.
barplot(
    agg$Emissions/100,
    names.arg = agg$year,
    xlab = "Year",
    ylab = expression("PM"[2.5]*" Emissions (x 100)"),
    main = expression("Total PM"[2.5]* " Emissions in the United States"),
    col = "lightblue"
)

#"Finish" the image
dev.off()