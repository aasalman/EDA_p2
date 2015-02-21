# plot3.R code creates line plot of total PM2.5 emissions in Baltimore from 1999 - 2008 comparing each type

# Read in dataset from working directory and subest Baltimore data

NEI <- readRDS("./summarySCC_PM25.rds")
Balt <- subset(NEI,fips == "24510")

# load ggplot2

library("ggplot2")

# sum up all emissions for each year in Baltimore

Balt.E <- aggregate(Balt[c("Emissions")], list(type = Balt$type, year = Balt$year), sum)

# create plot

png('plot3.png', width=480, height=480)

# type of plot shows data point connected with line

qplot(year, Emissions, data = Balt.E, geom = c('point','line'), color = type,
      main = "Total Emissions from PM2.5 in Baltimore by type",
      xlab = "Year", ylab = "PM 2.5 Emissions")

dev.off()