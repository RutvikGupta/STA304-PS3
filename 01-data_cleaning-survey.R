#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from Tausanovitch, Chris and Vavreck, Lynn. 2020. 
# Democracy Fund + UCLA Nationscape, October 10-17, 2019 (version 20200814).
# Retrieved from https://www.voterstudygroup.org/downloads?key=88d78bb4-8775-430d-bda2-27b88f955618
# so that it can be used as a survey data in our model.
# Author: Rutvik Gupta
# Data: 2nd November 2020
# Contact: rutvik.gupta@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
setwd("C:/Users/rutvi")
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(interest,
         registration,
         vote_2016,
         vote_intention,
         vote_2020,
         ideo5,
         employment,
         foreign_born,
         gender,
         census_region,
         hispanic,
         race_ethnicity,
         household_income,
         education,
         state,
         congress_district,
         age)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_data<-
  reduced_data %>%
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0))

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "survey_data.csv")

