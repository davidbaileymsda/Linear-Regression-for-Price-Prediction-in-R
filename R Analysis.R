#install.packages("pacman")
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, psych)

#set working directory
setwd("C:/Users/david/Desktop/Data Analytics Capstone/Task 1/Data & Analysis")
getwd()

#import data set
Ridesharing <- import("rideshare_kaggle.csv")
summary(Ridesharing)

#Remove records with missing prices
55095 / 693071  #7.94%
Ridesharing <- Ridesharing[complete.cases(Ridesharing),]

#Summary stats for proposal
str(Ridesharing)
head(Ridesharing)
summary(Ridesharing)

#Select desired features
Rides <- Ridesharing[,c('datetime','hour','cab_type','name','price','distance',
                        'surge_multiplier','temperature',
                        'precipProbability','windSpeed',
                        'visibility','moonPhase')]

#Convert datetime to dayofweek
Rides$datetime <- weekdays(Rides$datetime)
colnames(Rides)[1] <- 'weekday'

#Convert characters into factors to check levels
Rides$weekday <- as.factor(Rides$weekday)
Rides$cab_type <- as.factor(Rides$cab_type)
Rides$name <- as.factor(Rides$name)
Rides$short_summary <- as.factor(Rides$short_summary)

#Check and order levels, if needed
levels(Rides$weekday)

#Split into Uber and Lyft Datasets
Uber <- subset(Rides, cab_type=='Uber',)
Lyft <- subset(Rides, cab_type=='Lyft',)

#Summary stats for Uber
summary(Uber)

#Summary stats for Lyft
summary(Lyft)

#Set table equal to Company for current analysis
Analyze <- Uber

#Check regression assumptions

#Check for collinearity

#Feature selection (t-statistics and p-values)

#Split into Training/Validation Sets

#Regression Model

#Test on Validation Set

#Prediction Accuracy

### Clean Up ###################################################################

# Clear Packages
p_unload(all)   #For pacman and extra packages

# Clear Plots, if there are any
dev.off()

# Clear global environment
rm(list = ls())

# Clear Console CTRL+L
cat("\014")