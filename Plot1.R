setwd("C:/Users/accou/Desktop/ks/COURSERA/Exploratory Data Analysis")

library(dplyr)

library(ggplot2)



#Download and Unzip files



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
number.add.width<-800                            
number.add.height<-800                            

# png("plot1.png", width=number.add.width, height=number.add.height)
# Group total NEI emissions per year:
total.emissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))
clrs <- c("pink", "green", "blue", "yellow")
x1<-barplot(height=total.emissions$Emissions/1000, names.arg=total.emissions$year,
            xlab="years", ylab=expression('total PM'[2.5]*' emission in kilotons'),ylim=c(0,8000),
            main=expression('Total PM'[2.5]*' emissions at various years in kilotons'),col=clrs)

## Add text at top of bars
text(x = x1, y = round(total.emissions$Emissions/1000,2), label = round(total.emissions$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")
