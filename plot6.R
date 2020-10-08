# Get the current directory
getwd()

# Call Packages:  ggplot2
library(ggplot2)

# reading and exploring:  
# -  NEI data - National Emmissions Data
neiFile <- readRDS("data/summarySCC_PM25.rds")
head(neiFile)
str(neiFile)

# -  Source Classification Code
sccFile <- readRDS("data/Source_Classification_Code.rds")
head(sccFile)
str(sccFile)
summary(sccFile)

#  Question 6:  
#  Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
#  Los Angeles City, California(fips == "06037"). Which city has seen greater changes over time in motor vehicle 
#  emissions?

baltLosAngelesMotors <- subset(neiFile, neiFile$fips %in% c("24510","06037") & neiFile$type == "ON-ROAD")
baltLosAngelesMotorsAGG <- aggregate(Emissions ~ year + fips, baltLosAngelesMotors, sum)

#  Create the png file with the graphic.
png("plot6.png")

ggplot(baltLosAngelesMotorsAGG, aes(year, Emissions, col = fips)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Baltimore and Los Angeles" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  labs(x = "Year", y = expression(~PM[2.5]~ "Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008") ) +
  scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) +
  theme(legend.title = element_text(face = "bold"))

#  Close file.
dev.off()