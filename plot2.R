# libraries
require(utils)
require(cairoDevice) # anti-aliasing figure
# download, load data and subset
fileUrl <-
'https://d396qusza40orc.cloudfront.net/exdata%2Fdata
%2FNEI_data.zip'
download.file(fileUrl,
destfile = './Data.zip',
method = 'curl', quiet = T)
if(file.exists('./Data.zip')) {
# Extract data file
unzip('./Data.zip')
# Delete original Zip file if it exists
invisible(file.remove('./Data.zip'))
}
## This first line will likely take a few seconds. Be
patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Delete data files .rds
if(all(file.exists('./summarySCC_PM25.rds',
'Source_Classification_Code.rds'))) {
invisible(file.remove('./summarySCC_PM25.rds',
'Source_Classification_Code.rds'))) {
invisible(file.remove('./summarySCC_PM25.rds',
'Source_Classification_Code.rds'))
}
# Create the png
png('./plot2.png', width = 500, height = 450,
res = 55, type = 'cairo') # default is 480px X 480px
# subset data
NEI_Baltimore <- subset(NEI, fips == "24510")
# Make Plot
with(aggregate(Emissions ~ year, NEI_Baltimore, sum),
plot(Emissions~year, pch = 18,
xlab = '', ylab = 'Total PM2.5 Emissions (tons)',
main = 'Total PM2.5 Emissions by Year in Baltimore City',
col = "blue", type = "b", xlim = c(1999, 2008),
lty = 2, lwd = 1.5, lab = c(10, 5, 7)))
# Close png file
dev.off(
