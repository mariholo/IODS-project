#Marianne Holopainen data wrangling, 4 assignment 28.11.2022


library(dplyr)

library(tidyverse)

#read the datasets
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..", show_col_types = FALSE)

#show colnames
colnames(hd); colnames(gii)

#show summaries
summary(hd)
summary(gii)


#rename variables

colnames(hd)

# change the name of the chosen columns
colnames(hd)[3] <- "HDI" #  "Human Development Index (HDI)" 
colnames(hd)[4] <- "Life.Exp" #"Life.Exp" = Life expectancy at birth
colnames(hd)[5] <- "Edu.Exp" #"Edu.Exp" = Expected years of schooling 
colnames(hd)[6] <- "Edu.Mean" #"Mean Years of Education" 
colnames(hd)[7] <- "GNI" #"GNI" = Gross National Income per capita
colnames(hd)[8] <- "GNI.HDI" #"GNI per Capita Rank Minus HDI Rank"  


colnames(gii)
colnames(gii)[3] <- "GII" #"Gender Inequality Index (GII)" 
colnames(gii)[4] <- "Mat.Mor" #"Maternal mortality ratio"
colnames(gii)[5] <- "Ado.Birth" #Adolescent birth rate
colnames(gii)[6] <- "Parli"  #Percetange of representatives in parliament
colnames(gii)[7] <- "Edu2.F"  #"Population with Secondary Education (Female)"
colnames(gii)[8] <- "Edu2.M"  #"Population with Secondary Education (Male)"
colnames(gii)[9] <- "Labo.F"  #"Labour Force Participation Rate (Female)" 
colnames(gii)[10] <- "Labo.M"  #"Labour Force Participation Rate (Male)"     


#Mutate the “Gender inequality” data and create two new variables. The first one should be the ratio of Female and Male populations with secondary education in each country. 
#(i.e. edu2F / edu2M). The second new variable should be the ratio of labor force participation of females and males in each country (i.e. labF / labM).


#"Edu2.FM" = Edu2.F / Edu2.M
gii <- mutate(gii, Edu2.FM = Edu2.F/Edu2.M)

#"Labo.FM" = Labo2.F / Labo2.M
gii <- mutate(gii, Labo.FM = Labo.F/Labo.M)


#Join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join). 
#The joined data should have 195 observations and 19 variables. Call the new joined data "human" and save it in your data folder. 

hd_gii <- inner_join(hd, gii, by = c ("Country"))


# look at the column names of the joined data set
colnames(hd_gii)
hd_gii

write_csv(hd_gii, "hd_gii_data.csv")
read_csv("hd_gii_data.csv")


