#This script is used to count the number of cows recorded on the different 
#Gigacow farms. It should be noted that this is the total number of animals
#recorded in the DelPro and includes animals which may have been culled prior to
#data recording for Gigacow being started.

#install.packages("stringr")
#install.packages("tidyr")
#install.packages("dplyr")

library(stringr)
library(tidyr)
library(dplyr)

#The animal counting function.
# Filter by specific farms by uncommenting the #filter function.
# Filter for more than 2 farms by repeating the | FarmName_Pseudo ==  "" statement)
# Using the The SE_Number in group_by separates animals by which farm they were 
# born on as the SE_Number includes the farm ID of where they were born.


DF.CowCount = DF.Cow %>% 
#  filter(FarmName_Pseudo == "" | FarmName_Pseudo == "") %>% #Add Farm names to only count a specific farm.
  mutate(SE_Number = gsub("-\\d+$|-\\d{4}-\\d+$","", SE_Number)) %>%
  group_by(FarmName_Pseudo, SE_Number) %>%
  summarise(N = length(SE_Number), .groups = 'drop')
