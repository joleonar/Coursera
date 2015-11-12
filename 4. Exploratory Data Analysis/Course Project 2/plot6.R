## Author: John Letteboer
## Date: October 23, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 2
## ---------------------------------------------
## Question 6
##
## Compare emissions from motor vehicle sources in Baltimore City with emissions from 
## motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
## has seen greater changes over time in motor vehicle emissions?
## 
## Output:
## -------
## plot6.R end plot6.png

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset of Baltimore City and Los Angeles County
BaltimoreCityNEI <- subset(NEI, fips == "24510")
BaltimoreCityNEI$City <- "Baltimore City"
LA_NEI <- subset(NEI, fips == "06037")
LA_NEI$City <- "Los Angeles County"

# Combine the two
bothNEI <- rbind(BaltimoreCityNEI, LA_NEI)

# Find coal combustion-related sources
vehicles_related <- grepl("vehicles", SCC$EI.Sector, ignore.case = TRUE)
vehicles_related <- SCC[vehicles_related,]
vehicles_related <- bothNEI[bothNEI$SCC %in% vehicles_related$SCC,]

# Aggregate the total PM2.5 emissions 
agg <- aggregate(Emissions ~ year + City, vehicles_related, sum)

# Setting output to png file
png('plot6.png')

#Setting colors
library(RColorBrewer)
cols <- rev(brewer.pal(7,"Blues"))

# Creating a barplot.
library(ggplot2)
ggp <- ggplot(agg, aes(factor(year), Emissions, fill=City)) + 
    geom_bar(stat="identity") + 
    facet_grid( .~ City) + 
    theme_bw() +
    guides(fill=FALSE) +
    scale_fill_manual(values = cols) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions from motor vehicle in Baltomore & Los Angeles"))

print(ggp)
#"Finish" the image
dev.off()