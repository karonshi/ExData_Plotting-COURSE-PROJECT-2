
# Plot 4
setwd("C:/Users/accou/Desktop/ks/COURSERA/Exploratory Data Analysis")

library(dplyr)
library(ggplot2)
library(stringr)

# Download and unzip

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", temp)
unzip(temp, c("summarySCC_PM25.rds", "Source_Classification_Code.rds"))
NEI <- readRDS("summarySCC_PM25.rds")
# str(NEI)
# dim(NEI)
# head(NEI)

SCC <- readRDS("Source_Classification_Code.rds")

# str(SCC)
# dim(SCC)
# head(SCC)
# visualization
number.add.width<-680                            # width length to make the changes faster
number.add.height<-680                             # height length to make the changes faster
combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[combustion.coal,]

# Find emissions from coal combustion-related sources
emissions.coal.combustion <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]
require(dplyr)
emissions.coal.related <- summarise(group_by(emissions.coal.combustion, year), Emissions=sum(Emissions))
require(ggplot2)
ggplot(emissions.coal.related, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
  geom_bar(stat="identity", color="brown") +
  #geom_bar(position = 'dodge')+
  # facet_grid(. ~ year) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in thousand tons")) +
  ggtitle("Emissions from coal combustion-related sources in thousand tons")+
  geom_label(aes(fill = year),colour = "brown", fontface = "bold")