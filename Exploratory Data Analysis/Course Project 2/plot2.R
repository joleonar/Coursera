## Author: John Letteboer
## Date: October 23, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 2
## ---------------------------------------------
## Question 2
##
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question
## 
## Output:
## -------
## plot2.R end plot2.png

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")