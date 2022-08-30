setwd ("~/R/Gigacow-tools")
library(readr)
# Import datasets from csv format
library(readr)
gigacow <- read_csv("gigacow.csv")
robot <- read.csv ("robot.csv")
lactation <- read.csv ("lactation.csv")
traffic <- read.csv ("trafficedited.csv")

# merge datasets based on gigacow ID
library(dplyr)
library (tidyr)
df1 <- left_join(gigacow, traffic, by = "Gigacow_Cow_Id")

# drop columns not needed in df1
df2edit <- select (df1, -3, -5, -15:-29)
df3edit <- select (df2edit, -13, -17, -24, -26, -36, -39:-40)

#drop rows with milkinginterval of NA

df4edit = df3edit %>% 
  drop_na(MilkingInterval)

df5edit <- select (df4edit, -7, -9:-21)

#remove previousarea from dataset df5edit which do not contain Mjolkfolla

#The long way of doing it, can be do delete each string one by one using the code below
df6edit <- df5edit[- grep("Foderbord", df5edit$PreviousArea),]


#quick way of removing a list of strings in a column is to create a list with all the strings you want to remove from the column.
remove.list <- paste(c ("Foderbord", "Obs grupp", "MS1", "kraftfoder","Unknown","Liggavdelning","Koridor till Sorteringsgrind 2","Grovfoder","Kraftfoder","VMS2","Korridor","Bete","VIP område"                    
,"OBS Avdelning", "vms 2","Vms 1"), collapse = '|')   
dfnew = df5edit %>% filter(!grepl(remove.list, PreviousArea))

#determine the number of farms in dataset
unique(df5edit$FarmName_Pseudo.x)
unique(df5edit$TrafficDeviceName)
unique (df5edit$PreviousArea)
unique (df6edit$PreviousArea)
unique(df21edit$FarmName_Pseudo.x)
unique (dfnew$PreviousArea)

library(car)

#change the name of mjolkfalla to the same spelling throughout dfnew using library car
dfmilk <- mutate(dfnew, PreviousArea =  recode(PreviousArea, "'Mjölkfålla' = 'Mjolkfalla'"))


unique (dfmilk$PreviousArea)



