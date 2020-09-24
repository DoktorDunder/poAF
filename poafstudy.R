# Code used for poAF study
# User: Jonas Bjurgert

library(dplyr)
library(ggplot2)
library(survival)
library(survminer)

# Variable "database_landspitali" is the entire dataset from Landspitali
database_landspitali <- `2020_20_02_ECG_Jonas`
rm(`2020_20_02_ECG_Jonas`)

#######################################################################################################
# Figure 1 - Patient diagram
# Grouping of the 36,566 patients depending on:
# 1: ECG post procedure y/n?
# 2: Pre-existing Afib?
# 3: poAF time after surgery - 30d, 90d and unlim.

#1. 18075 n, 20491 y
table(database_landspitali$ECG_post_ANY)

#2. 20118 n, 3553 y
table(database_landspitali$ECG_pre_AF_any)

# 3. 
#   30-day: 3230 n, 363 y
table(database_landspitali$ECG_post_AF_30day - database_landspitali$ECG_pre_AF_any)

#   90-day: 11746 n, 2073 y
variable90day <- ifelse(database_landspitali$ECG_post_AF_any_d <91, 3, 0)
table(variable90day - database_landspitali$ECG_pre_AF_any)

#   Unlim:  12057 n, 2802 y
table(database_landspitali$ECG_post_AF_any - database_landspitali$ECG_pre_AF_any)

#######################################################################################################
# Table 1 - Incidence

database_landspitali %>% mutate(database_landspitali$ECG_post_AF_30day,
                         ifelse(database_landspitali$BigClass == "Neurosurgery_major", 1, 0))











