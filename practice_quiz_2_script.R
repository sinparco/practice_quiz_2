#Load Packages
library(tidyverse)
library(psych)
library(haven)

#Load Data
raw_data <- read_csv(file="raw_data.csv")

#Fix Data
raw_data <- read_csv(file="raw_data.csv",na=c("","NA","-999"))

#Labelling Data
categorical_variables <- select(raw_data, sex)
categorical_variables$sex <- as.factor(categorical_variables$sex)
levels(categorical_variables$sex) <- list("Male"=1, "Female"=2)
sex <- categorical_variables$sex

#Creating Item Scales
pos_affect <- select (raw_data, delighted, elated, enthusiastic, excited)
neg_affect <- select (raw_data, angry, anxious, ashamed)
Neuroticism <- raw_data$Neuroticism
Extraversion <- raw_data$Extraversion

#Fixing Bad Values
is_bad_value <- pos_affect<0 | pos_affect>3
pos_affect[is_bad_value] <- NA
is_bad_value <- neg_affect<0 | neg_affect >3
neg_affect[is_bad_value] <- NA
is_bad_value <- Neuroticism<0 | Neuroticism >24
Neuroticism[is_bad_value] <- NA
is_bad_value <- Extraversion<0 | Extraversion >24
Extraversion[is_bad_value] <- NA

#Descriptive Analysis
#psych::describe(depression_items)

#Obtaining Scale Scores
pos_affect <- psych::alpha(as.data.frame(pos_affect), check.keys=FALSE)$scores
neg_affect <- psych::alpha(as.data.frame(neg_affect), check.keys=FALSE)$scores

#Combine into analytic_data
analytic_data <- cbind(categorical_variables, pos_affect, neg_affect, Neuroticism, Extraversion)

#Saving .RData, CSV, .SAV 
save(analytic_data,file="quiz2_analytic_data_.RData")
write_csv(analytic_data,path="quiz1_analytic_data_.csv")
