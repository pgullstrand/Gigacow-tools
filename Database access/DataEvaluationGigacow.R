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

Feed_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Feed_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Feed_DataView = collect(Feed_DataView_Con)

Gigacow_Cow_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Gigacow_Cow_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Gigacow_Cow_DataView = collect(Gigacow_Cow_DataView_Con)

Health_BCS_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Health_BCS_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Health_BCS_DataView = collect(Health_BCS_DataView_Con)

Health_DiagnosisTreatment_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Health_DiagnosisTreatment_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Health_DiagnosisTreatment_DataView = collect(Health_DiagnosisTreatment_DataView_Con)

MilkOther_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "MilkOther_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
MilkOther_DataView = collect(MilkOther_DataView_Con)

MilkRobot_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "MilkRobot_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
MilkRobot_DataView = collect(MilkRobot_DataView_Con)

Reproduction_Abortion_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Abortion_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Reproduction_Abortion_DataView = collect(Reproduction_Abortion_DataView_Con)

Reproduction_Calving_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Calving_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Reproduction_Calving_DataView = collect(Reproduction_Calving_DataView_Con)

Reproduction_DryOff_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_DryOff_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Reproduction_DryOff_DataView = collect(Reproduction_DryOff_DataView_Con)

Reproduction_Insemination_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Insemination_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Reproduction_Insemination_DataView = collect(Reproduction_Insemination_DataView_Con)

Reproduction_Lactation_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Lactation_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Reproduction_Lactation_DataView = collect(Reproduction_Lactation_DataView_Con)

Reproduction_PregnancyCheck_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_PregnancyCheck_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Reproduction_PregnancyCheck_DataView = collect(Reproduction_PregnancyCheck_DataView_Con)

Reproduction_ReproductionStatus_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_ReproductionStatus_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Reproduction_ReproductionStatus_DataView = collect(Reproduction_ReproductionStatus_DataView_Con)

Stillborn_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Stillborn_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SillbornCalfReference), .groups = 'drop')
Stillborn_DataView = collect(Stillborn_DataView_Con)

Traffic_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Traffic_DataView")) %>%
  group_by(FarmName_Pseudo) %>%
  summarise(count = n_distinct(SE_Number), .groups = 'drop')
Traffic_DataView = collect(Traffic_DataView_Con)

#This section merges all tables by FarmName_Pseudo to create a table with summary stats.

SummaryStats = full_join(Activity, CowMilkYield_Common, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, CowMilkYield_Other, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, CowMilkYield_Robot, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, Feed_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, Gigacow_Cow_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, Health_BCS_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, Health_DiagnosisTreatment_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, MilkOther_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats, MilkRobot_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Reproduction_Abortion_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Reproduction_Calving_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Reproduction_DryOff_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Reproduction_Insemination_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Reproduction_Lactation_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Reproduction_PregnancyCheck_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Reproduction_ReproductionStatus_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Stillborn_DataView, by = "FarmName_Pseudo")
SummaryStats = full_join(SummaryStats,  Traffic_DataView, by = "FarmName_Pseudo")
colnames(SummaryStats) = c("FarmName_Pseudo", "Activity", "MilkYield_Common", "MilkYield_Other", "MilkYield_Robot", "Feed", "Cow_list", "BCS", "Treatment", "MilkOther", "MilkRobot","Abortion","Calving", "DryOff", "Insemination", "Lactation", "Pregnancy check", "Reproduction status", "Stillborn", "Traffic")


#This section calculates the total number of individuals in each data table in Gigacow. It is not quite as tidy as it should be but a work in progress.
SummaryStats2 = SummaryStats %>%
  summarise(across(where(is.integer), ~ sum(.x, na.rm = TRUE)))

SummaryStats3 = bind_rows(SummaryStats, SummaryStats2)
