#Marianne Holopainen, R script for the week 6 
#2.12.2022


# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)

# Read the rats data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",  header = TRUE, sep = '\t')

#names
names(BPRS)
names(RATS)


#structure
str(BPRS)
str(RATS)


#summary
summary(BPRS)
summary(RATS)

View(RATS)
View(BPRS)


#Convert the categorical variables of both data sets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


#Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. 
library(dplyr); library(tidyr); library(stringr) ; library(tidyverse)
#BPRS
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

View(BPRSL)
str(BPRSL)
summary(BPRSL)

write_csv(BPRS, "BPRS.csv")
read_csv("BPRS.csv")

write_csv(BPRSL, "BPRSL.csv")
read_csv("BPRSL.csv")

#RATS
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>%
  arrange(Time)


View(RATSL)
str(RATSL)
summary(RATSL)

write_csv(RATS, "RATS.csv")
read_csv("RATS.csv")

write_csv(RATSL, "RATSL.csv")
read_csv("RATSL.csv")

