library(sampleSelection)
library(tidyverse)
library(modelsummary)
library(VIM)
library(mice)

wages <- read_csv("/Users/Benjamin Fillmore/Documents/Courses/class_data/wages12.csv")
wages <- as.data.frame(wages)

wages$college <- as.factor(wages$college)
wages$married <- as.factor(wages$married)
wages$union   <- as.factor(wages$union)

mean(is.na(wages$logwage))
a<-aggr(wages)
summary(a)

# MAR

# Listwise Deletion

newwages <- na.omit(wages)
list.est <- lm(logwage ~ hgc + union + college + exper + exper^2, data = newwages)
summary(list.est)

# Mean Imputation

dfMean.imp <- wages
dfMean.imp$logwage[is.na(dfMean.imp$logwage)] <- mean(dfMean.imp$logwage,na.rm=T)
imp.est <- lm(logwage ~ hgc + union + college + exper + exper^2, data = dfMean.imp)
summary(imp.est)

# Sample Selection

wages$valid <- is.na(wages$logwage)
wages$valid <- ifelse(wages$valid==TRUE,"0","1")

heck <- selection(selection = valid ~ hgc + union + college + exper + married + kids,
          outcome = logwage ~ hgc + union + college + exper + I(exper^2),
          data = wages, method = "2step")
summary(heck)

# probit

prob.est <- glm(union==1 ~ hgc + college + exper + married + kids, data = wages)
summary(prob.est)

# predicted probability

wages$pred.probit <- predict(prob.est, newdata = wages, type = "response")
summary(wages$pred.probit)
mean(summary(wages$pred.probit))

# married & kids

prob.est$coefficients["married"] <- 0
prob.est$coefficients["kids"]    <- 0

wages$pred.probit <- predict(prob.est, newdata = wages, type = "response")
summary(wages$pred.probit)
mean(summary(wages$pred.probit))

# No, deleting out the relationship between married & kids on our dependent variable would compromise the model, I'd assume
