# Get the current directory
getwd()

# Call Packages:  ggplot2
library(ggplot2)

# reading and exploring:  
# -  NEI data - National Emissions Data
neiFile <- readRDS("data/summarySCC_PM25.rds")
head(neiFile)
str(neiFile)

# -  Source Classification Code
sccFile <- readRDS("data/Source_Classification_Code.rds")
head(sccFile)
str(sccFile)
summary(sccFile)

#  Question 1:
#  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#  Using the base plotting system, make a plot showing:
#  a.  Total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#  Calculate total of emissions.
total_annual_emissions <- aggregate(Emissions ~ year, neiFile, FUN = sum)

#  Assign the color to the graphic.
colorRange <- 2:(length(total_annual_emissions$year)+1)

with(total_annual_emissions, 
     barplot(height=Emissions/1000, names.arg = year, col = colorRange, 
             xlab = "Year", ylab = expression('PM'[2.5]*' in Kilotons'),
             main = expression('Annual Emission PM'[2.5]*' from 1999 to 2008')))

#  Create the png file with the graphic.
dev.copy(png, file="plot1.png", height=480, width=480)

#  Close file.
dev.off()