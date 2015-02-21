# plot1.R code creates line plot of total PM2.5 emissions in the United states from 1999 - 2008

# Read in dataset from working directory

NEI <- readRDS("./summarySCC_PM25.rds")

# sum up all emissions for each year

E <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)

# create plot that shows total PM2.5 emissions from 1999 - 2008

png('plot1.png', width=480, height=480)

# type of plot shows data point connected with line

plot(E$year, E$Emissions, type = "b", 
     main = "Total Emissions from PM2.5 in the U.S.",
     xlab = "Year", ylab = "PM 2.5 Emissions")


dev.off()