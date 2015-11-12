## Author: John Letteboer
## Date: October 23, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 2
## ---------------------------------------------
## Question 5
##
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
## 
## Output:
## -------
## plot5.R end plot5.png

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset of Baltimore City
BaltimoreCityNEI <- subset(NEI, fips == "24510")

# Find coal combustion-related sources
vehicles_related <- grepl("vehicles", SCC$EI.Sector, ignore.case = TRUE)
vehicles_related <- SCC[vehicles_related,]
vehicles_related <- BaltimoreCityNEI[BaltimoreCityNEI$SCC %in% vehicles_related$SCC,]

# Aggregate the total PM2.5 emissions  
agg <- aggregate(Emissions ~ year, vehicles_related, sum)

# Setting output to png file
png('plot5.png')

#Setting colors
library(RColorBrewer)
cols <- rev(brewer.pal(7,"Blues"))

# Creating a barplot to see if total emissions have decreased in Baltimore City.
library(ggplot2)
ggp <- ggplot(agg, aes(factor(year), Emissions)) + 
    geom_bar(stat="identity", fill = "lightblue") + 
    theme_bw() +
    #guides(fill=FALSE) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions from motor vehicle sources in Baltomore City"))

print(ggp)
#"Finish" the image
dev.off()