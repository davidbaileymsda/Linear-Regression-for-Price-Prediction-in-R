#install.packages("pacman")
pacman::p_load(pacman, broom, caret, corrplot, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, psych)

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
Numeric <- Ridesharing[,c('hour','distance','price','surge_multiplier',
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
UberPartition <- createDataPartition(Uber$price, p=0.7, list = FALSE)
set.seed(127)
UTrain <- Uber[UberPartition,]
UValidate <- Uber[-UberPartition,]

dim(UTrain)
dim(UValidate)

LyftPartition <- createDataPartition(Lyft$price, p=0.7, list = FALSE)
set.seed(127)
LTrain <- Lyft[LyftPartition,]
LValidate <- Lyft[-LyftPartition,]

dim(LTrain)
dim(LValidate)

#Summary stats for Training
summary(UTrain)
summary(LTrain)

###UBER BRANCH###

#Feature selection and model creation (t-statistics and p-values)
Uinitialmodel <- lm(price ~ ., data=UTrain)
summary(Uinitialmodel)

#Refined model
Umodel <- lm(price ~ name + weekday + windSpeed + distance, data=UTrain)
summary(Umodel)

#Assumptions - Mean of residuals is zero (PASS)
mean(Umodel$residuals)

#Assumptions - Homoscedasticity, or equal variance, of residuals (PASS)
par(mfrow=c(2,2))
plot(Umodel)

#Test on Validation Set and calculate RMSE and R Square for prediction accuracy
Uprediction <- as.numeric(predict(Umodel, newdata = UValidate))
summary(Uprediction)
Uerrors <- as.vector(UValidate$price - as.numeric(Uprediction))
summary(Uerrors)

RMSE(Uprediction, UValidate$price)
R2(Uprediction, UValidate$price)

#Plot predicted vs actual values
plot(Uprediction,UValidate$price,
     xlab="predicted",ylab="actual",main="Predicted vs. actual values - Uber")

###LYFT BRANCH###

#Feature selection and model creation (t-statistics and p-values)
Linitialmodel <- lm(price ~ ., data=LTrain)
summary(Linitialmodel)

#Refined model
Lmodel <- lm(price ~ name + surge_multiplier + distance, data=LTrain)
summary(Lmodel)

#Assumptions - Mean of residuals is zero (PASS)
mean(Lmodel$residuals)

#Assumptions - Homoscedasticity, or equal variance, of residuals (PASS)
par(mfrow=c(2,2))
plot(Lmodel)

#Test on Validation Set and calculate RMSE and R Square for prediction accuracy
Lprediction <- as.numeric(predict(Lmodel, newdata = LValidate))
summary(Lprediction)
Lerrors <- as.vector(LValidate$price - as.numeric(Lprediction))
summary(Lerrors)

RMSE(Lprediction, LValidate$price)
R2(Lprediction, LValidate$price)

#Plot predicted vs actual values
plot(Lprediction,LValidate$price,
     xlab="predicted",ylab="actual",main="Predicted vs. actual values - Lyft")

### Clean Up ###################################################################

# Clear Packages
p_unload(all)   #For pacman and extra packages

# Clear Plots, if there are any
dev.off()

# Clear global environment
rm(list = ls())

# Clear Console CTRL+L
cat("\014")
