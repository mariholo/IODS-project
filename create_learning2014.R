#Marianne Holopainen, 7.11.2022, exercise 2. 

#reading the JYTOPKYS3.data into R.

library(tidyverse) # install.packages("tidyverse")
JYTOPKYS3_data <- read.delim("~/IODS-project/data/JYTOPKYS3-data.txt")
  stringsAsFactors = FALSE
  View(JYTOPKYS3_data)

#Create an analysis dataset with the variables gender, age, attitude, 
#deep, stra, surf and points.
#Scale all combination variables to the original scales (by taking the mean). 
#Exclude observations where the exam points variable is zero. 
#(The data should then have 166 observations and 7 variables)

#Deep     Deep approach             ~d_sm+d_ri+d_ue
#Surf     Surface approach          ~su_lp+su_um+su_sb
#Stra     Strategic approach        ~st_os+st_tm
#Points   Yhteispisteet (max kaikista)'

#VAR d_sm:1=D03+D11+D19+D27 #seaking meaning.
#+VAR d_ri:1=D07+D14+D22+D30 #relating ideas.
#+VAR d_ue:1=D06+D15+D23+D31 #use of evidence.
#+VAR su_lp:1=SU02+SU10+SU18+SU26 #lack of purpose.
#+VAR su_um:1=SU05+SU13+SU21+SU29 #unrelated memorising.
#+VAR su_sb:1=SU08+SU16+SU24+SU32 #syllabus-boundeness.
#+VAR st_os:1=ST01+ST09+ST17+ST25 #organized studying.
#+VAR st_tm:1=ST04+ST12+ST20+ST28 #time management.
#+VAR Deep:1=d_sm+d_ri+d_ue #deep approach.
#+VAR Surf:1=su_lp+su_um+su_sb #surface approach.
#+VAR Stra:1=st_os+st_tm #strategic approach.

#deep, surf, stra and their means. 
attach(JYTOPKYS3_data)
  JYTOPKYS3_data$deep <- (D03+D11+D19+D27+D07+D14+D22+D30+D06+D15+D23+D31)/12
JYTOPKYS3_data$surf <- (SU02+SU10+SU18+SU26+SU05+SU13+SU21+SU29+SU08+SU16+SU24+SU32)/12
JYTOPKYS3_data$stra <- (ST01+ST09+ST17+ST25+ST04+ST12+ST20+ST28)/8
detach(JYTOPKYS3_data)

exercise_data2 <- JYTOPKYS3_data[c(57:63)]#choose the correct outcomes.

attach(exercise_data2)#lopullinen data tehtavaan.
exercise_data_final <- exercise_data2[ which(Points > 0),]#exludes 0 values.
detach(exercise_data2)

View(exercise_data_final)

#Use `str()` and `head()` to make sure that the structure of the data is correct?
write_csv(exercise_data_final, "learning2014.csv")
read_csv("learning2014.csv")

?read_csv()

#ANALYSIS.

#1, explore the sturucture and dimensions of the data.

#data for the analyses
library(tidyverse) # install.packages("tidyverse")
learning2014.data <- read.csv("~/IODS-project/data/learning2014-data.txt")
stringsAsFactors = FALSE
View(learning2014.data)

#N = gender
learning2014.data %>%
  count(gender, sort = TRUE)
#N =age
learning2014.data %>%
  count(age, sort = TRUE)


library(tidyverse)
library(gapminder) # dataset
library(finalfit)
library(broom)
library(ggplot2)

#statistics.
glimpse(learning2014.data)
ff_glimpse(learning2014.data) 

#MEANS by sex.
learning2014.data %>% 
  group_by(gender) %>% 
  summarise(mean(points))

learning2014.data %>% 
  group_by(gender) %>% 
  summarise(mean(surf))

learning2014.data %>% 
  group_by(gender) %>% 
  summarise(mean(deep))

learning2014.data %>% 
  group_by(gender) %>% 
  summarise(mean(stra))

#boxplot by sex.
boxplot(learning2014.data$points ~ learning2014.data$gender,
        xlab = "Gender",
        ylab = "Points")
boxplot(learning2014.data$deep ~ learning2014.data$gender,
        xlab = "Gender",
        ylab = "Deep Approach")
boxplot(learning2014.data$stra ~ learning2014.data$gender,
        xlab = "Gender",
        ylab = "Strategic Approach")
boxplot(learning2014.data$surf ~ learning2014.data$gender,
        xlab = "Gender",
        ylab = "Surface Approach")


plot(learning2014.data$age, learning2014.data$points)

#histogrammit outcomeille
hist(learning2014.data$points,
     breaks = 20, 
     xlab = " Points",
     main = " Histogram of total Points")

hist(learning2014.data$deep,
     breaks = 20, 
     xlab = " Points",
     main = " Histogram of Deep Approach")

hist(learning2014.data$surf,
     breaks = 20, 
     xlab = " Points",
     main = " Histogram of total Surface Approach")

hist(learning2014.data$stra,
     breaks = 20, 
     xlab = " Points",
     main = " Histogram of Strategic Approach")

#connections of variables to total scores
plot(learning2014.data$deep, learning2014.data$points,
     xlab = "Deep Approach",
     ylab = "Points")
plot(learning2014.data$stra, learning2014.data$points,
     xlab = "Strategic Approach",
     ylab = "Points")
plot(learning2014.data$surf, learning2014.data$points,
     xlab = "Surface Approach",
     ylab = "Points")

#different graphs.
ggplot(learning2014.data, aes(x = deep, y = points)) +
  geom_point() +
  stat_smooth()
ggplot(learning2014.data, aes(x = surf, y = points)) +
  geom_point() +
  stat_smooth()
ggplot(learning2014.data, aes(x = stra, y = points)) +
  geom_point() +
  stat_smooth()


#3.

#regression models.

#model1.

#check the correlations
cor(learning2014.data$stra, learning2014.data$deep)
cor(learning2014.data$stra, learning2014.data$surf)
cor(learning2014.data$surf, learning2014.data$deep)


model1 <- lm(points ~ deep + stra + surf, data = learning2014.data)

summary(model1)

#model2

model2 <- lm(points ~ stra + surf, data = learning2014.data)

summary(model2)


#the following diagnostic plots: Residuals vs Fitted values, Normal QQ-plot and Residuals vs Leverage.

par(mfrow=c(2,2))
plot(model2)
par(mfrow=c(1,1))





