#install.packages("pacman")
pacman::p_load(pacman, broom, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, psych)

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
unique(Ridesharing$name)

#Correlation Matrix for collinearity
Numeric <- Ridesharing[,c('hour','distance','surge_multiplier',
                          'temperature','precipProbability','windSpeed',
                          'visibility','moonPhase')]
CM <- cor(Numeric)

png("Correlation Matrix.png")
corrplot(CM, method = 'number', title = 'Correlation Matrix for Numeric Variables',
         mar = c(0,0,2,0), tl.col = 'black')
dev.off()

#Select desired features
Rides <- Ridesharing[,c('datetime','hour','cab_type','name','price','distance',
                        'surge_multiplier','temperature',
                        'precipProbability','windSpeed', 'moonPhase')]

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

#Remove cab_type feature from data frames
Uber$cab_type <- NULL
Lyft$cab_type <- NULL

#Split into Training/Validation Sets


#Summary stats for Training
summary(Analyze)

#Set data frame equal to Company for current analysis
Analyze <- Uber

#Feature selection and model creation (t-statistics and p-values)
model <- lm(price ~ ., data=Analyze)
summary(model)

#Assumptions - Mean of residuals is zero (PASS)
mean(model$residuals)

#Assumptions - Homoscedasticity, or equal variance, of residuals (PASS)
#Assumptions - Normality of residuals (Mostly PASS - Does slop off at higher Quantiles?)
par(mfrow=c(2,2))
plot(model)

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