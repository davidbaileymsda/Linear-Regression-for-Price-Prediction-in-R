#install.packages("pacman")
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, stringr, tidyr, psych)

#set working directory
setwd("C:/Users/david/Desktop/Data Analytics Capstone/Task 1/Data & Analysis")
getwd()

#import data set
Ridesharing <- import("rideshare_kaggle.csv")

str(Ridesharing)
head(Ridesharing)
summary(Ridesharing)

#Remove records with missing prices
55095 / 693071  #7.94%
Rides <- 

#Summary stats for proposal

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

