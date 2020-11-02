#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from 
# Steven Ruggles, Sarah Flood, Ronald Goeken, Josiah Grover, Erin Meyer, Jose Pacas and Matthew Sobek. IPUMS USA: Version 10.0 [dataset]. 
# Minneapolis, MN: IPUMS, 2020. Retrieved from https://doi.org/10.18128/D010.V10.0
# # so that it can be used as a census data in our model.
# Author: Rutvik Gupta
# Data: 2nd November 2020
# Contact: rutvik.gupta@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
setwd("C:/Users/rutvi")
raw_data <- read_dta("usa_00002.dta")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- 
  raw_data %>% 
  select(stateicp,
         sex, 
         age, 
         race)
         

#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)
reduced_data <- 
  reduced_data %>%
  count(stateicp,
        sex, 
        age, 
        race) %>%
  group_by(stateicp,
           sex, 
           age, 
           race)

reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

reduced_data$age <- as.integer(reduced_data$age)

# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data, "census_data.csv")
  


         