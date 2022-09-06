#This script contain a number of pipes to parse the Cow Traffic dataframe and
# manipulate it to extract statistics or understand cow traffic related to milking. 
library(tidyr)
library(dplyr)

#You may need to turn PreviousArea into a factor (ie use as.factor on the column)
#for this script to work depending on how R interprets the row.

#This pipe removes all Traffic events which are not related to a cow entering the
#milking robot.
DF.trafficMilkings = DF.Traffic %>% 
  drop_na(MilkingInterval) %>%
  filter(MilkingInterval_totalSeconds != 0)# %>%
#  as.factor(PreviousArea)

#This pipe create a set of groups and calculate how many times cows has been
# registered to enter the robot from different Previous Areas.

Area.list = DF.trafficMilkings %>%
  group_by(FarmName_Pseudo, GroupName, TrafficDeviceName, PreviousArea) %>%
  summarise(N = length(PreviousArea), .groups = 'drop')

#write.csv(head(DF.trafficMilkings), file = "TrafficData")
#
