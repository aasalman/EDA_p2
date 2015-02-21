# plot6.R code creates line plot of total PM2.5 emissions from motor vehicle sources in Baltimore and Los Angeles
# from 1999 - 2008

# Read in dataset from working directory and subest Baltimore data

NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load ggplo2

library("ggplot2")

# filter data that is associated from motor vehicle sources indicated in the Source Classification Code Table

mv <- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
mvSCC <- SCC[mv,]$SCC
mvNEI <- NEI[NEI$SCC %in% mvSCC,]

# subset all of Baltimore and Los Angeles data

mvBLA <- subset(mvNEI,fips == "24510"|fips == "06037")

# sum all sources to create total per year for Baltimore and Los Angeles

mv.b.la <- aggregate(mvBLA[c("Emissions")], list(fips = mvBLA$fips, year = mvBLA$year), sum)

# create city name column that matches fips

mv.b.la[mv.b.la$fips == "06037", "City"] <- "Los Angeles"
mv.b.la[mv.b.la$fips == "24510", "City"] <- "Baltimore"

# create plot that shows total PM2.5 emissions of motor vehicle sources comparing Baltimore and Los Angeles 
# from 1999 - 2008

png('plot6.png', width=480, height=480)

# type of plot shows data point connected with line

qplot(year, Emissions, data = mv.b.la, geom = c('point','line'), color = City,
      main = "Total Motor Vehicle Source Emissions from PM2.5 - Baltimore and Los Angeles",
      xlab = "Year", ylab = "PM 2.5 Emissions")

dev.off()