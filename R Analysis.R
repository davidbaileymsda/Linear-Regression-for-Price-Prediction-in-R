#install.packages("pacman")
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, psych)

#set working directory
setwd("C:/Users/david/Desktop/Data Analytics Capstone/Task 1/Data & Analysis")
getwd()

#import data set
Ridesharing <- import("rideshare_kaggle.csv")

#Remove records with missing prices
55095 / 693071  #7.94%
Ridesharing <- Ridesharing[complete.cases(Ridesharing),]

#Summary stats for proposal
str(Ridesharing)
head(Ridesharing)
summary(Ridesharing)

#Select desired features and convert character features to factors
Rides <- Ridesharing[,c('datetime','hour','source','destination','cab_type',
                     'name','price','distance','surge_multiplier','temperature',
                     'short_summary','precipProbability','windSpeed','visibility',
                     'moonPhase')]


#Split into Uber and Lyft Datasets

#Summary stats for Uber

#Summary stats for Lyft

#Set table equal to Company for current analysis

#Check regression assumptions

#Feature selection

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