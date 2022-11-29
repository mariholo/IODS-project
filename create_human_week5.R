#Marianne Holopainen 29.11.2022
#Data Wrangling for the week 5

#link to the original data source: https://hdr.undp.org/data-center/human-development-index#/indicies/HDI
library(dplyr)
library(tidyverse)


#read the datasets
data5 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", sep=",", header = TRUE)

#Explore the structure and the dimensions of the data and describe the dataset briefly
str(data5)
summary(data5)
colnames(data5)

#data has 19 variables and 195 obs;  [1] "HDI.Rank"       "Country"        "HDI"            "Life.Exp"       "Edu.Exp"        "Edu.Mean"       "GNI"            "GNI.Minus.Rank"
#[9] "GII.Rank"       "GII"            "Mat.Mor"        "Ado.Birth"      "Parli.F"        "Edu2.F"         "Edu2.M"         "Labo.F"        
#[17] "Labo.M"         "Edu2.FM"        "Labo.FM"

# "HDI" #  "Human Development Index (HDI)" 
#"Life.Exp" = Life expectancy at birth
#"Edu.Exp" = Expected years of schooling 
# "Edu.Mean" = "Mean Years of Education" 
#"GNI" = Gross National Income per capita
#GNI.Minus.Rank = "GNI per Capita Rank Minus HDI Rank"  
#"GII" #"Gender Inequality Index (GII)" 
#"Mat.Mor" #"Maternal mortality ratio"
#"Ado.Birth" #Adolescent birth rate
#"Parli.F"  #Percetange of representatives in parliament
#"Edu2.F"  #"Population with Secondary Education (Female)"
#"Edu2.M"  #"Population with Secondary Education (Male)"
#"Labo.F"  #"Labour Force Participation Rate (Female)" 
# "Labo.M"  #"Labour Force Participation Rate (Male)" 


#transform the Gross National Income (GNI) variable to numeric (using string manipulation)
data5$GNI
str(data5$GNI)

# access the stringr package (part of `tidyverse`)
library(stringr)

# remove the commas from GNI and print out a numeric version of it
data5$GNI <- gsub(",", ".", data5$GNI) %>% as.numeric


#Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above): 
#"Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"

library(dplyr)
# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
data5 <- select(data5, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(data5)


# filter out all rows with NA values
data5_f <- filter(data5, complete.cases(data5))

data5_f

#Remove the observations which relate to regions instead of countries.
##?


# add countries as rownames
rownames(data5_f) <- data5_f$Country
data5_f

#remove the country name column from the data
data5_f <- dplyr::select(data5_f, -Country)

str(data5_f)


write_csv(data5_f, "human_data5.csv")
read_csv("human_data5.csv")


