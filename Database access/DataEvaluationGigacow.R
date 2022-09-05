#This script uses the Windows credentials of the user to log into the Gigacow test server.
#The script then uses dbplyr to run queries written as dplyr code to be executed on the server
#and then collect the stats so that they can be calculated by the user on Rstudio,

#install.packages("odbc")
#install.packages("DBI")
#install.packages("dplyr")
#install.packages("dbplyr")

library(odbc)
library(DBI)
library(dplyr)
library(dbplyr)


#Connecting to the database using the R user credentions.
con <- dbConnect(odbc(),
                 Driver = "SQL Server",
                 Server = "sqldbtest2-1.ad.slu.se\\inst1",
                 Database = "Gigacow_QA"
)
odbcListObjects(con)

#Shows the available tables in the schema.
odbcListObjects(con, catalog="Gigacow_QA", schema="science")

#The below code chunks run SQL queries on each table and then downloads the result.
Activity_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Activity_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Activity = collect(Activity_Con)

CowMilkYield_Common_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "CowMilkYield_Common_View")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
CowMilkYield_Common = collect(CowMilkYield_Common_Con)

CowMilkYield_Other_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "CowMilkYield_Other_View")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
CowMilkYield_Other = collect(CowMilkYield_Other_Con)

CowMilkYield_Robot_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "CowMilkYield_Robot_View")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
CowMilkYield_Robot = collect(CowMilkYield_Robot_Con)

#This section mergs all tables by FarmName_Pseudo to create a table with summary stats.

SummaryStats = full_join(Activity, CowMilkYield_Common, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, CowMilkYield_Other, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, CowMilkYield_Robot, by = "FarmName_Pseudo")
colnames(test) = c("FarmName_Pseudo", "Activity", "FarmCowMilkYield_Common", "FarmCowMilkYield_Other", "FarmCowMilkYield_Robot")
SummaryStats

show_query(test)