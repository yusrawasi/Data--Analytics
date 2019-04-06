install.packages('tidyverse')
install.packages('ggplot2')

library(tidyverse)

library(ggplot2)
data("table1")
data("table2")
data("table3")
data("table4a")
data("table4b")
View(table2)
View(who)
#---yusra-------------------------------
# http://rstudio-pubs-static.s3.amazonaws.com/267396_2b709b3cf0c246d1aac22e745a727a61.html?fbclid=IwAR36qiiSSjOoJxlmaJG5YfTHCY3Xj1Fv3XWxNKOs2CQatWVqzLrIXInXUKs


who1 <- who %>%
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

who1

who2 <-  who1 %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2 

who3 <-  who2 %>%
  separate(key, c("new","type", "sexage"), sep="_")

who3

who4 <- who3 %>%
  select(-new, -iso2,-iso3)
who4



who5 <- who4  %>%
  separate(sexage, c("Sex","Age"), sep = 1)

who5
