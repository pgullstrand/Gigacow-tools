library(dplyr)
# grouping timeinarea_totalseconds according to Breed and farm
df.timeinarea_mean = dfmilk %>%
  group_by(FarmName_Pseudo.x, BreedName) %>%
  summarise_at(vars(TimeInArea_totalSeconds), list(TimeInArea_totalSeconds = mean))

#group cows together according to time of milking and TimeinArea_totalSeconds

df.cowstogether = df5edit %>%
  group_by(FarmName_Pseudo.x,TrafficEventDateTime,PreviousArea,Gigacow_Cow_Id,BreedName) %>%
  summarise_at(vars(TimeInArea_totalSeconds), list(TimeInArea_totalSeconds = mean))