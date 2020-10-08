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

#  Question 5:
#  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
baltimoreMotor <- subset(neiFile, neiFile$fips == "24510" & neiFile$type == "ON-ROAD")
baltimoreMotorAGG <- aggregate(Emissions ~ year, baltimoreMotor, sum)

ggplot(baltimoreMotorAGG, aes(year, Emissions)) +
  geom_line(col = "steelblue3") +
  geom_point(col = "steelblue3") +
  ggtitle(expression("Baltimore " ~ PM[2.5] ~ "Motor Vehicle Emissions by Year [1999 - 2008]")) +
  xlab("Year") +
  ylab(expression(~PM[2.5]~ "Motor Vehicle Emissions"))

#  Create the png file with the graphic.
dev.copy(png, file="plot5.png", height=480, width=480)

#  Close file.
dev.off()
