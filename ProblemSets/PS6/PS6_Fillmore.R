library(ggplot2)
library(dplyr)
library(tidyverse)

# Load in data sets

path <- '/Users/Benjamin Fillmore/Documents/Courses/data_science_for_economists/Data'


prem <- as_tibble(read.csv(paste(path, '/gen_ref_chelsea_prem.csv', sep='')))
ucl  <- as_tibble(read.csv(paste(path, '/gen_ref_chelsea_ucl.csv', sep='')))
efl  <- as_tibble(read.csv(paste(path, '/gen_ref_chelsea_efl.csv', sep='')))
fa   <- as_tibble(read.csv(paste(path, '/gen_ref_chelsea_fa.csv', sep='')))

names(prem) <- prem %>% slice(1) %>% unlist()
prem <- prem[-1,]
prem <- prem[,-30]

names(ucl) <- ucl %>% slice(1) %>% unlist()
ucl <- ucl[-1,]
ucl <- ucl[,-30]

names(efl) <- efl %>% slice(1) %>% unlist()
efl <- efl[-1,]
efl <- efl[,-21]

names(fa) <- fa %>% slice(1) %>% unlist()
fa <- fa[-1,]
fa <- fa[,-21]


# Compare Goals per Game by Player across competition
ggplot(data = prem) +
  geom_point(mapping = aes(x = Player, y = goals.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5)) 

ggplot(data = ucl) +
  geom_point(mapping = aes(x = Player, y = goals.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5))

ggplot(data = efl) +
  geom_point(mapping = aes(x = Player, y = goals.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5))

ggplot(data = fa) +
  geom_point(mapping = aes(x = Player, y = goals.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5))

# Compare Assists per Game across competition

ggplot(data = prem) +
  geom_point(mapping = aes(x = Player, y = assist.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5)) 

ggplot(data = ucl) +
  geom_point(mapping = aes(x = Player, y = assist.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5))

ggplot(data = efl) +
  geom_point(mapping = aes(x = Player, y = assist.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5))

ggplot(data = fa) +
  geom_point(mapping = aes(x = Player, y = assist.per.game, color = Pos)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5))

# Yellows by Position in UCL

ggplot(data = ucl) +
  geom_point(mapping = aes(x = Player, y = total.pks, color = pk.attempt)) +
  theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5))
