<<<<<<< HEAD
library(janitor)
library(lubridate)

# Question 1

m100 = read_html("https://en.wikipedia.org/wiki/List_of_Olympic_records_in_swimming")
m100

pre_iaaf =
  m100 %>%
  html_element("td:nth-child(6) , td:nth-child(5) , th+ td , .jquery-tablesorter tbody th , .jquery-tablesorter td:nth-child(2) , .jquery-tablesorter td:nth-child(1)") %>% ## select table element
  html_table()                                      ## convert to data frame

pre_iaaf

pre_iaaf =
  pre_iaaf %>%
  clean_names() %>%
  mutate(date = mdy(date))

pre_iaaf

# Question 2

install.packages("rtweet")
install.packages("tidytext")

library(tidytext)
library(rtweet)
library(ggplot2)
library(dplyr)

appname <- "myapp"
key     <- "mylongAPI"
secret  <- "secretKey"

rstats_tweets <- search_tweets(q = "David Lynch",
                               n = 200,
                               include_rts = FALSE)

twit.data <- as_tibble(rstats_tweets)

View(twit.data)
=======
library(janitor)
library(lubridate)

# Question 1

m100 = read_html("https://en.wikipedia.org/wiki/List_of_Olympic_records_in_swimming")
m100

pre_iaaf =
  m100 %>%
  html_element("td:nth-child(6) , td:nth-child(5) , th+ td , .jquery-tablesorter tbody th , .jquery-tablesorter td:nth-child(2) , .jquery-tablesorter td:nth-child(1)") %>% ## select table element
  html_table()                                      ## convert to data frame

pre_iaaf

pre_iaaf =
  pre_iaaf %>%
  clean_names() %>%
  mutate(date = mdy(date))

pre_iaaf

# Question 2

install.packages("rtweet")
install.packages("tidytext")

library(tidytext)
library(rtweet)
library(ggplot2)
library(dplyr)

appname <- "myapp"
key     <- "mylongAPI"
secret  <- "secretKey"

rstats_tweets <- search_tweets(q = "David Lynch",
                               n = 200,
                               include_rts = FALSE)

twit.data <- as_tibble(rstats_tweets)

View(twit.data)
>>>>>>> 6abd1b965e6796350454bf87e1f4a915b5e0489d
