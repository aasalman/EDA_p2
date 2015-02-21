# plot2.R code creates line plot of total PM2.5 emissions in Baltimore from 1999 - 2008

# Read in dataset from working directory and subest Baltimore data

NEI <- readRDS("./summarySCC_PM25.rds")
Balt <- subset(NEI,fips == "24510")

# sum up all emissions for each year in Baltimore

Balt.E <- aggregate(Balt[c("Emissions")], list(year = Balt$year), sum)

# create plot 

png('plot2.png', width=480, height=480)

# type of plot shows data point connected with line

plot(Balt.E$year, Balt.E$Emissions, type = "b", 
     main = "Total Emissions from PM2.5 in Baltimore",
     xlab = "Year", ylab = "PM 2.5 Emissions")


dev.off()