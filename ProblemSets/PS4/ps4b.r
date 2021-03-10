install.packages("sparklyr")
install.packages("tidyverse")

library(sparklyr)
library(tidyverse)

spark_install(version = "3.0.0")
sc  <- spark_connect(master = "local")

df1 <- as_tibble(iris)
df  <- copy_to(sc, df1)

print(class(df1))
print(class(df))
# df1 is a data.frame, df is a function
# different colnames, one is in spark formatting vs. df

df %>% select(Sepal_Length,Species) %>% head %>% print
df %>% filter(Sepal_Length>5.5) %>% head %>% print
df %>% select(Sepal_Length,Species) %>% filter(Sepal_Length>5.5) %>% head %>% print
df2 <- df %>% group_by(Species) %>% summarize(mean = mean(Sepal_Length), count = n()) %>% head %>% print
df2 <- df2 %>% group_by(Species) %>% summarize(mean = mean(Sepal_Length), count = n()) %>% head %>% print
df2 %>% arrange(Species) %>% head %>% print
