# plot4.R code creates line plot of total PM2.5 emissions from coal combustion sources in the U.S. from 1999 - 2008

# Read in dataset from working directory and subest Baltimore data

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplo2

library("ggplot2")

# filter data that is associated from combustion (level 1) and coal (level 3) sources indicated in the 
# Source Classification Code Table

# subset of combustion sources

combustion <- grepl("comb", SCC$EI.Sector, ignore.case=TRUE)

# subset of coal sources

coal <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE) 

# subset of intersect of coal and combustion sources

coal.combustion <- (combustion & coal)
ccSCC <- SCC[coal.combustion,]$SCC

# subset of all emisions from coal combustion sources

ccNEI <- NEI[NEI$SCC %in% ccSCC,]
CC <- aggregate(ccNEI[c("Emissions")], list(year = ccNEI$year), sum)

# create plot

png('plot4.png', width=480, height=480)

# type of plot shows data point connected with line

qplot(year, Emissions, data = CC, geom = c('point','line'),
      main = "Total Coal Combustion Emissions from PM2.5 in the U.S.",
      xlab = "Year", ylab = "PM 2.5 Emissions")

dev.off()