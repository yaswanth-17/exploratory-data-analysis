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
invisible(file.remove('./summarySCC PM25.rds'
'Source_Classification_Code.rds'))
}
# Create the png
png('./plot6.png', width = 700, height = 370,
res = 75, type = 'cairo') # default is 480px X 480px
# Make Plot
NEI %>%
dplyr::filter(fips %in% c("24510", "06037"),
type == 'ON-ROAD') %>%
group_by(year, fips) %>%
summarise(sum = sum(Emissions)) %>%
ggplot(aes(year, sum, col = fips)) +
geom_point() + geom_line() +
labs(title = 'Total PM2.5 Emission by Year in Baltimore
and Los Angeles',
subtitle = 'Subsetted from Motor Vehicle Sources ("On-
Road type")') +
xlab('') + ylab('Total PM2.5 Emission (tons)') +
scale_colour_discrete(name = "City", labels = c("Los
Angeles", "Baltimore")) +
theme(legend.title = element_text(face = "bold")) +
scale_x_continuous(breaks = unique(NEI$year)) +
theme_bw()
# Close png file
dev.off()
