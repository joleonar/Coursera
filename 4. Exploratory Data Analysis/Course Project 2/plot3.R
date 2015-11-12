## Author: John Letteboer
## Date: October 23, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 2
## ---------------------------------------------
## Question 3
##
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
## plot answer this question.
## 
## Output:
## -------
## plot3.R end plot3.png

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset of Baltimore City
BaltimoreCityNEI <- subset(NEI, fips == "24510")

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year + type, BaltimoreCityNEI, sum)

# Setting output to png file
png('plot3.png', width = 550)

#Setting colors
library(RColorBrewer)
cols <- rev(brewer.pal(7,"Blues"))

# Creating a barplot to see if total emissions have decreased in Baltimore City.
library(ggplot2)
ggp <- ggplot(agg, aes(factor(year), Emissions, fill=type, group=1)) + 
    geom_bar(stat="identity") + 
    facet_grid( .~ type) + 
    theme_bw() +
    guides(fill=FALSE) +
    scale_fill_manual(values = cols) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Type")) +
    geom_smooth(size = 1, color = "red", linetype = 2, method = "lm", se = FALSE)
    
print(ggp)
#"Finish" the image
dev.off()

