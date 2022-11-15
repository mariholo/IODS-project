
#Marianne Holopainen 14.11.2022, data wrangling in week 3.



install.packages("boot")
install.packages("readr")

#3. ja 4. exercises 

url <- "https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/"



# web address for math class data
url_math <- paste(url, "student-mat.csv", sep = "/")

# print out the address
url_math

# read the math class questionnaire data into memory
math <- read.table(url_math, sep = ";" , header = TRUE)

# web address for Portuguese class data
url_por <- paste(url, "student-por.csv", sep = "/")

# print out the address


# read the Portuguese class questionnaire data into memory
por <- read.table(url_por, sep = ";", header = TRUE)

# look at the column names of both data sets
colnames(math); colnames(por)

math <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/student-mat.csv", sep=";", header=TRUE)
por <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/student-por.csv", sep=";", header=TRUE)


library(dplyr)

library(tidyverse)

# give the columns that vary in the two data sets
free_cols

# the rest of the columns are common identifiers used for joining the data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)



# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

#TAI
#math_por <- inner_join(math, por, by = c ("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob", "reason", "guardian" ,  "traveltime", "studytime","schoolsup","famsup" , "activities" ,"nursery", "higher","internet", "romantic", "famrel" , "freetime" , "goout" , "Dalc" ,  "Walc" ,"health"))



# look at the column names of the joined data set
colnames(math_por)

# glimpse at the joined data set
math_por

#5. exercise

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))



# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data
colnames(alc)


View(alc)

#6. exercise

# access the tidyverse packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = high_use))

# draw a bar plot of high_use by sex
g2 + geom_bar()



# alc is available

# access the tidyverse libraries tidyr, dplyr, ggplot2
library(tidyr); library(dplyr); library(ggplot2)

#7. Exercise

# glimpse at the alc data


# use gather() to gather columns into key-value pairs and then glimpse() at the resulting data
gather(alc) %>% glimpse

# it may help to take a closer look by View() and browse the data
gather(alc) %>% View

# draw a bar plot of each variable
gather(alc) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar()


#3.7  Save the joined and modified data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse).

#write modified data
write_csv(alc, "alc_data.csv")
read_csv("alc_data.csv")

#write joined data
write_csv(math_por_data, "math_por_data.csv")
read_csv("math_por_data.csv")




