

library(here)
library(tidyverse)
library(readxl)


list1213 <- read_excel(here("data","LeadershipTurnover2.xlsx"), sheet = "2012-13") %>%
    mutate_if(is_character, str_trim)


list1415 <- read_excel(here("data","LeadershipTurnover2.xlsx"), sheet = "2014-15") %>%
    mutate_if(is_character, str_trim)

list1516 <- read_excel(here("data","LeadershipTurnover2.xlsx"), sheet = "2015-16") %>%
    mutate_if(is_character, str_trim)

list1718 <- read_excel(here("data","LeadershipTurnover2.xlsx"), sheet = "2017-18") %>%
    mutate_if(is_character, str_trim)

list1819 <- read_excel(here("data","LeadershipTurnover2.xlsx"), sheet = "2018-19") %>%
    mutate_if(is_character, str_trim)
# list1920 <- read_excel(here("data","LeadershipTurnover2.xlsx"), sheet = "2019-20")


all <- list1213 %>% 
    full_join(list1415, by = c("District", "School")) %>% 
    full_join(list1516, by = c("District", "School")) %>% 
    full_join(list1718, by = c("District", "School")) %>% 
    full_join(list1819, by = c("District", "School"))




all <- arrange(all, District, School)



all2 <- all %>% 
    mutate(Change.1213.1415 = str_detect(`Simple 12-13`,`Simple 14-15`),
           Change.1415.1516 = str_detect(`Simple 14-15`,`Simple 15-16`),
           Change.1516.1718 = str_detect(`Simple 15-16`,`Simple 17-18`),
           Change.1718.1819 = str_detect(`Simple 17-18`,`Simple 18-19`))





forprint <- all2 %>%
    select(-starts_with("Year"), -starts_with("Super"), -starts_with("Change")) 

writexl::write_xlsx(forprint, "Review.xlsx")    
