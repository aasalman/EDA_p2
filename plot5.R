# plot5.R code creates line plot of total PM2.5 emissions from motor vehicle sources in Baltimore from 1999 - 2008

# Read in dataset from working directory and subest Baltimore data

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplo2

library("ggplot2")

# filter data that is associated from motor vehicle sources indicated in the Source Classification Code Table

mv <- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
mvSCC <- SCC[mv,]$SCC
mvNEI <- NEI[NEI$SCC %in% mvSCC,]

# subset all of Baltimore data

mvBalt <- subset(mvNEI,fips == "24510")

# sum all sources to create total per year for Baltimore

mvb <- aggregate(mvBalt[c("Emissions")], list(year = mvBalt$year), sum)

# create plot that shows total PM2.5 emissions from motor vehicle sources from 1999 - 2008

png('plot5.png', width=480, height=480)

# type of plot shows data point connected with line

qplot(year, Emissions, data = mvb, geom = c('point','line'),
      main = "Total Motor Vehicle Source Emissions from PM2.5 in Baltimore",
      xlab = "Year", ylab = "PM 2.5 Emissions")

dev.off()