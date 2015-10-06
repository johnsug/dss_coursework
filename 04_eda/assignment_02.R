
# load data (original source: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
names(SCC) <- gsub("\\.", "_", names(SCC))  ## minor reformatting (due to 'sqldf' not liking periods)

# libraries
library(sqldf)
library(ggplot2)

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#    make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
df_01 <- sqldf("select year, sum(Emissions) as Emissions from NEI group by 1 order by 1")
plot(df_01, type="o", xlab="Year", ylab="PM2.5 Emissions (in tons)", xaxt="n")
title("U.S. PM2.5 Emissions")
axis(1, at=c(1999, 2002, 2005, 2008), labels=c(1999, 2002, 2005, 2008))
dev.copy(png, file="plot1.png")
dev.off()

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.
df_02 <- sqldf("select year, sum(Emissions) as Emissions from NEI where fips = 24510 group by 1 order by 1")
plot(df_02, type="o", xlab="Year", ylab="PM2.5 Emissions (in tons)", xaxt="n")
title("Baltimore City, Maryland PM2.5 Emissions")
axis(1, at=c(1999, 2002, 2005, 2008), labels=c(1999, 2002, 2005, 2008))
dev.copy(png, file="plot2.png")
dev.off()

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these 
#    four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in 
#    emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
df_03 <- sqldf("select year, type, sum(Emissions) as Emissions from NEI where fips = 24510 group by 1, 2 order by 2")
ggplot(df_03, aes(x=year, y=Emissions)) + geom_line() + geom_point() + facet_wrap(~type) + 
  labs(title="Baltimore City, Maryland PM2.5 Emissions by Source", x="Year", y="PM2.5 Emissions (in tons)")
dev.copy(png, file="plot3.png")
dev.off()

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
df_04 <- sqldf("select year, sum(Emissions) as Emissions from NEI 
               where SCC in (select SCC from SCC where EI_Sector like '%coal%') group by 1")
plot(df_04, type="o", xlab="Year", ylab="PM2.5 Emissions (in tons)", xaxt="n")
title("U.S. Coal Combustion-Related PM2.5 Emissions")
axis(1, at=c(1999, 2002, 2005, 2008), labels=c(1999, 2002, 2005, 2008))
dev.copy(png, file="plot4.png")
dev.off()

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
df_05 <- sqldf("select year, sum(Emissions) as Emissions from NEI 
               where SCC in (select SCC from SCC where EI_Sector like 'Mobile%') and fips = 24510 group by 1")
plot(df_05, type="o", xlab="Year", ylab="PM2.5 Emissions (in tons)", xaxt="n")
title("Baltimore City, Maryland PM2.5 Emissions\nfrom Motor Vehicles")
axis(1, at=c(1999, 2002, 2005, 2008), labels=c(1999, 2002, 2005, 2008))
dev.copy(png, file="plot5.png")
dev.off()

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los 
#    Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle 
#    emissions?
df_06 <- sqldf("select year, fips, sum(Emissions) as Emissions from NEI 
               where SCC in (select SCC from SCC where EI_Sector like 'Mobile%') and fips in ('24510', '06037') 
               group by 1, 2 order by 2, 1")
df_06$fips <- cut(as.numeric(df_06$fips), c(0,20000,99999), c("Los Angeles County, California", "Baltimore City, Maryland"))
ggplot(df_06, aes(x=year, y=Emissions)) + geom_line() + geom_point() + facet_wrap(~fips) + 
  labs(title="PM2.5 Emissions from Motor Vehicles\nLos Angeles vs Baltimore City") + 
  labs(x="Year", y="PM2.5 Emissions (in tons)")
dev.copy(png, file="plot6.png")
dev.off()
