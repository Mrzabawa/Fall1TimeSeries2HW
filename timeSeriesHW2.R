library(tidyverse)
library(lubridate)
library(zoo)

rawData <- read.csv("PM_2_5_Raleigh2.csv")
####################################################
rawData$Date <- mdy(rawData$Date)
modelData <- rawData %>%
  mutate(Year = year(Date), Month = month(Date))%>%
  group_by(Year, Month)%>%
  select(Year, Month, Daily.Mean.PM2.5.Concentration)%>%
  summarize(MonthlyMean = mean(Daily.Mean.PM2.5.Concentration, na.rm = TRUE))%>%
  mutate(Date = ymd(paste(Year, Month, "01")))
summary(modelData)
####################################################
#split data in to validation and testing
trainData <- modelData%>%
  filter(Date <= ymd("2018-6-01"))

testData <- modelData%>%
  filter(Date > ymd("2018-6-01"))

####################################################
#save RDA for test and train
save(trainData, file =  "trainDataTimeSeriesHW2.RDA")
save(testData, file = "testDataTimeSeriesHW2.RDA")
####################################################


