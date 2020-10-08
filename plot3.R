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

#  Question 3:
#  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
#  variables, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#  Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
#  answer this question.

neiBaltimore <- neiFile[neiFile$fips=="24510",]

#  Create the png file with the graphic.
dev.copy(png, file="plot3.png", height=480, width=480)

#  Plot the graphic.
ggplot(neiBaltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions in Baltimore City from 1999 to 2008 by Source Type"))


#  Close file.
dev.off()