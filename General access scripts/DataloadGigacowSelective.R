#This script uses the Windows credentials of the user to log into the Gigacow test server to retrieve data.
#In order to use this script you need to be running R as a registered Gigacow user on a computer capable of
#accessing the Active Directory of SLU.

#This script uses dbplyr to take dplyr commands, translate them to SQL and send them to the server.
#This way the user can make selective downloads of data by compiling, filtering and joining tables
#prior to downloading the datasets using the collect(function). Pretty much all dplyr commands can be used
#to select, filter and manipulate data which is done in several of the Gigacow-tools scripts.
#Running the script down to the odbcListObjects() function will open a connection to the Gigacow SQL database
#and the "Connections" tab on the right (if you use Rstudio) should show you the databases accessible. You can
#here see all tables available and also load the first 1000 rows of each one to quickly see the content.

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
                 Server = "gigacow_qa.db.slu.se",
                 Database = "Gigacow_QA"
)
odbcListObjects(con)

#Shows the available tables in the schema.
odbcListObjects(con, catalog="Gigacow_QA", schema="science")


#The below code chunks run SQL queries on each table and then downloads the result.
Activity_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Activity_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "a624fb9a") #Add Farm names to only count a specific farm.
DF.Activity = collect(Activity_Con)

CowMilkYield_Common_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "CowMilkYield_Common_View")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.CowMilkYield_Common = collect(CowMilkYield_Common_Con)

CowMilkYield_Other_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "CowMilkYield_Other_View")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.CowMilkYield_Other = collect(CowMilkYield_Other_Con)

CowMilkYield_Robot_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "CowMilkYield_Robot_View")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.CowMilkYield_Robot = collect(CowMilkYield_Robot_Con)

Feed_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Feed_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Feed = collect(Feed_DataView_Con)

Gigacow_Cow_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Gigacow_Cow_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Gigacow_Cow = collect(Gigacow_Cow_DataView_Con)

Health_BCS_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Health_BCS_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.BCS = collect(Health_BCS_DataView_Con)

Health_DiagnosisTreatment_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Health_DiagnosisTreatment_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.DiagnosisTreatment = collect(Health_DiagnosisTreatment_DataView_Con)

MilkOther_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "MilkOther_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.MilkOther = collect(MilkOther_DataView_Con)

MilkRobot_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "MilkRobot_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.MilkRobot = collect(MilkRobot_DataView_Con)

Reproduction_Abortion_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Abortion_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Abortion = collect(Reproduction_Abortion_DataView_Con)

Reproduction_Calving_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Calving_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Calving = collect(Reproduction_Calving_DataView_Con)

Reproduction_DryOff_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_DryOff_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.DryOff = collect(Reproduction_DryOff_DataView_Con)

Reproduction_Insemination_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Insemination_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Insemination = collect(Reproduction_Insemination_DataView_Con)

Reproduction_Lactation_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_Lactation_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Lactation = collect(Reproduction_Lactation_DataView_Con)

Reproduction_PregnancyCheck_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_PregnancyCheck_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.PregnancyCheck = collect(Reproduction_PregnancyCheck_DataView_Con)

Reproduction_ReproductionStatus_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Reproduction_ReproductionStatus_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.ReproductionStatus = collect(Reproduction_ReproductionStatus_DataView_Con)

Stillborn_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Stillborn_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Stillborn = collect(Stillborn_DataView_Con)

Traffic_DataView_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Traffic_DataView")) %>%
  filter(FarmName_Pseudo == "a624fb9a" | FarmName_Pseudo == "f454e660") #Add Farm names to only count a specific farm.
DF.Traffic = collect(Traffic_DataView_Con)


