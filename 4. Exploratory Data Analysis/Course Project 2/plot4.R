## Author: John Letteboer
## Date: October 23, 2015
## ---------------------------------------------
## Exploratory Data Analysis: Course Project 2
## ---------------------------------------------
## Question 4
##
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
## 
## Output:
## -------
## plot4.R end plot4.png

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Find coal combustion-related sources
coal_related <- grepl("coal|comb", SCC$EI.Sector, ignore.case = TRUE)
coal_related <- SCC[coal_related,]
coal_related <- NEI[NEI$SCC %in% coal_related$SCC,]

# Aggregate the total PM2.5 emissions  
agg <- aggregate(Emissions ~ year, coal_related, sum)

# Setting output to png file
png('plot4.png')

#Setting colors
library(RColorBrewer)
cols <- rev(brewer.pal(7,"Blues"))

# Creating a barplot to see if total emissions have decreased in Baltimore City.
library(ggplot2)
ggp <- ggplot(agg, aes(factor(year), Emissions/10^6)) + 
    geom_bar(stat="identity", fill = "lightblue") + 
    theme_bw() +
    #guides(fill=FALSE) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^6 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions coal combustion-related sources"))

print(ggp)
#"Finish" the image
dev.off()
