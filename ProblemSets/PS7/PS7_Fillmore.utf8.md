---
title: "PS7_FIllmore"
author: "Benjamin Fillmore"
date: "3/25/2021"
output:
  pdf_document: default
  html_document: default
---




load in data

```r
path <- '/Users/Benjamin Fillmore/Documents/Courses/data_science_for_economists/Data'
wages <- as_tibble(read.csv(paste(path, '/wages.csv', sep='')))
```

drop hgc/tenure missing values

```r
wage_up <- wages[complete.cases(wages$hgc),]
wage_up <- wages[complete.cases(wages$tenure),]
```

summary table

```r
datasummary_skim(wage_up,histogram=F,output="markdown")
```



|        | Unique (#)| Missing (%)| Mean|  SD|  Min| Median|  Max|
|:-------|----------:|-----------:|----:|---:|----:|------:|----:|
|logwage |        670|          25|  1.6| 0.4|  0.0|    1.7|  2.3|
|hgc     |         17|           0| 13.1| 2.5|  0.0|   12.0| 18.0|
|tenure  |        259|           0|  6.0| 5.5|  0.0|    3.8| 25.9|
|age     |         13|           0| 39.2| 3.1| 34.0|   39.0| 46.0|

```r
est <- lm(logwage ~ hgc + as.factor(college) + poly(tenure, 2, raw=T) + age + as.factor(married), data = wage_up) #.062 is the complete case estimate of years of schooling on wages
summary(est)
```

```
## 
## Call:
## lm(formula = logwage ~ hgc + as.factor(college) + poly(tenure, 
##     2, raw = T) + age + as.factor(married), data = wage_up)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -1.83546 -0.22417  0.02922  0.24821  0.89254 
## 
## Coefficients:
##                                      Estimate Std. Error t value Pr(>|t|)    
## (Intercept)                         0.5335692  0.1459622   3.656 0.000265 ***
## hgc                                 0.0623931  0.0053844  11.588  < 2e-16 ***
## as.factor(college)not college grad  0.1451682  0.0344848   4.210 2.69e-05 ***
## poly(tenure, 2, raw = T)1           0.0495251  0.0051813   9.558  < 2e-16 ***
## poly(tenure, 2, raw = T)2          -0.0015597  0.0002930  -5.324 1.15e-07 ***
## age                                 0.0004412  0.0027465   0.161 0.872388    
## as.factor(married)single           -0.0220462  0.0177095  -1.245 0.213351    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.3436 on 1662 degrees of freedom
##   (562 observations deleted due to missingness)
## Multiple R-squared:  0.2084,	Adjusted R-squared:  0.2055 
## F-statistic: 72.92 on 6 and 1662 DF,  p-value: < 2.2e-16
```

imputations

```r
wage_up %<>% mutate(logwage2 = case_when(!is.na(logwage) ~ logwage, is.na(logwage) ~ mean(wage_up$logwage,na.rm=T))) # mean imputation

head(wage_up) 
```

```
## # A tibble: 6 x 7
##   logwage   hgc college          tenure   age married logwage2
##     <dbl> <int> <chr>             <dbl> <int> <chr>      <dbl>
## 1   NA       12 not college grad   5.33    37 single      1.63
## 2    1.86    12 not college grad   5.25    37 single      1.86
## 3    1.61    12 not college grad   1.25    42 single      1.61
## 4    2.20    17 college grad       1.75    43 married     2.20
## 5    2.09    12 not college grad  17.8     42 married     2.09
## 6    1.53    12 not college grad   2.25    39 married     1.53
```

```r
est2 <- lm(logwage2 ~ hgc + as.factor(college) + poly(tenure, 2, raw=T) + age + as.factor(married), data = wage_up) # estimated model with mean imputation

pred.data = predict(est, newdata = wage_up)
head(pred.data)
```

```
##        1        2        3        4        5        6 
## 1.641504 1.638752 1.483410 1.695118 1.833661 1.548199
```

```r
wage_up %<>% mutate(logwage3 = case_when(!is.na(logwage) ~ logwage, is.na(logwage) ~ pred.data)) # predicted imputation

est3 <- lm(logwage3 ~ hgc + as.factor(college) + poly(tenure, 2, raw=T) + age + as.factor(married), data = wage_up) # estimated model with predicted imputation

imp<-mice(wage_up,m=6,meth="norm.nob")
```

```
## 
##  iter imp variable
##   1   1  hgc
##   1   2  hgc
##   1   3  hgc
##   1   4  hgc
##   1   5  hgc
##   1   6  hgc
##   2   1  hgc
##   2   2  hgc
##   2   3  hgc
##   2   4  hgc
##   2   5  hgc
##   2   6  hgc
##   3   1  hgc
##   3   2  hgc
##   3   3  hgc
##   3   4  hgc
##   3   5  hgc
##   3   6  hgc
##   4   1  hgc
##   4   2  hgc
##   4   3  hgc
##   4   4  hgc
##   4   5  hgc
##   4   6  hgc
##   5   1  hgc
##   5   2  hgc
##   5   3  hgc
##   5   4  hgc
##   5   5  hgc
##   5   6  hgc
```

```
## Warning: Number of logged events: 3
```

```r
fit<-with(imp, lm(logwage~hgc+as.factor(college)+poly(tenure,2,raw=T)+age+married))
est4<-pool(fit) # estimated model with MICE


modelsummary(list(est,est2, est3,est4), output="latex")
```

\begin{table}[H]
\centering
\begin{tabular}[t]{lcccc}
\toprule
  & Model 1 & Model 2 & Model 3 & Model 4\\
\midrule
(Intercept) & 0.534 & 0.708 & 0.534 & 0.536\\
 & (0.146) & (0.116) & (0.112) & (0.146)\\
hgc & 0.062 & 0.050 & 0.062 & 0.062\\
 & (0.005) & (0.004) & (0.004) & \vphantom{1}(0.005)\\
as.factor(college)not college grad & 0.145 & 0.168 & 0.145 & 0.145\\
 & (0.034) & (0.026) & (0.025) & (0.034)\\
poly(tenure, 2, raw = T)1 & 0.050 & 0.038 & 0.050 & 0.049\\
 & (0.005) & (0.004) & (0.004) & (0.005)\\
poly(tenure, 2, raw = T)2 & -0.002 & -0.001 & -0.002 & -0.002\\
 & (0.000) & (0.000) & (0.000) & (0.000)\\
age & 0.000 & 0.000 & 0.000 & 0.000\\
 & (0.003) & (0.002) & (0.002) & (0.003)\\
as.factor(married)single & -0.022 & -0.027 & -0.022 & \\
 & (0.018) & (0.014) & (0.013) & \\
marriedsingle &  &  &  & -0.023\\
 &  &  &  & (0.018)\\
\midrule
Num.Obs. & 1669 & 2229 & 2229 & 1671\\
Num.Imp. &  &  &  & 6\\
R2 & 0.208 & 0.147 & 0.277 & 0.208\\
R2 Adj. & 0.206 & 0.145 & 0.275 & 0.206\\
AIC & 1179.9 & 1091.1 & 925.5 & \\
BIC & 1223.2 & 1136.8 & 971.1 & \\
Log.Lik. & -581.936 & -537.549 & -454.737 & \\
F & 72.917 & 63.985 & 141.686 & \\
\bottomrule
\end{tabular}
\end{table}
