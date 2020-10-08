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


#  Question 2:
#  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#  from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#  Select the Baltimore data based on NEI file information.
baltimoreneiData <- neiFile[neiFile$fips=="24510",]

aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreneiData,sum)

# Plot the graphic.
barplot(
        aggTotalsBaltimore$Emissions,
        names.arg=aggTotalsBaltimore$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From All Baltimore City Sources"
)

#  Create the png file with the graphic.
dev.copy(png, file="plot2.png", height=480, width=480)

#  Close file.
dev.off()