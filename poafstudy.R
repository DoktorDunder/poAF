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
table(database_landspitali$ECG_post_AF_30day,database_landspitali$ECG_pre_AF_any)

#   90-day: 11746 n, 2073 y
variable90day <- ifelse(database_landspitali$ECG_post_AF_any_d <91, 3, 0)
table(variable90day - database_landspitali$ECG_pre_AF_any)

table()
#   Unlim:  12057 n, 2802 y
table(database_landspitali$ECG_post_AF_any - database_landspitali$ECG_pre_AF_any)

#######################################################################################################
# Table 1 - Incidence
# comp90 = 90day AF excluding pre-AF - 3= yes , 2= no, 1


poafcompvar <- database_landspitali$ECG_post_AF_30day(ifelse(ECG_post_AF_30day==0,))
comp30day <- (database_landspitali$ECG_post_AF_30day - database_landspitali$ECG_pre_AF_any)
table(comp30day)

comp90day <- (variable90day - database_landspitali$ECG_pre_AF_any)
compall <- (database_landspitali$ECG_post_AF_any - database_landspitali$ECG_pre_AF_any)



x <- ftable(database_landspitali$ECG_pre_AF_any, database_landspitali$BigClass, database_landspitali$ECG_post_AF_any, 
            dnn = c("Preaf", "Surg", "Poaf"))
x[,2]

y <- ftable(database_landspitali$ECG_pre_AF_any, database_landspitali$BigClass, variable90day,
            dnn= c("Preaf", "Surg", "poaf"))
y






## Define the 90-day variable
variable90day <- ifelse(database_landspitali$ECG_post_AF_any_d <91, 1, 0)

## Insert in freqtable
tab90 <- ftable(database_landspitali$ECG_pre_AF_any, database_landspitali$BigClass, variable90day,
                dnn= c("Preaf", "Surg", "poaf"))

## Same freqtable but with the non-time restricted variable
tabinf <- ftable(database_landspitali$ECG_pre_AF_any, database_landspitali$BigClass, database_landspitali$ECG_post_AF_any, 
                 dnn = c("Preaf", "Surg", "Poaf"))

## For instance: Poaf in AbdMaj is 222 in the 90 day grp, but just 169 in the supposedly much larger group