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

#  Question 4:
#  Across the United States, how have emissions from coal combustion-related sources from 1999-2008?
sccCoal <- sccFile[grepl("coal", sccFile$Short.Name, ignore.case = T),]
neiCoal <- neiFile[neiFile$SCC %in% sccCoal$SCC,]

totalCoal <- aggregate(Emissions ~ year + type, neiCoal, sum)

ggplot(totalCoal, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emission by Type and Year")) +
  xlab("Year") +
  ylab(expression("US " ~ PM[2.5] ~ "Coal Emission")) +
  scale_colour_discrete(name = "Type of sources") +
  theme(legend.title = element_text(face = "bold"))

#  Create the png file with the graphic.
dev.copy(png, file="plot4.png", height=480, width=480)

#  Close file.
dev.off()
