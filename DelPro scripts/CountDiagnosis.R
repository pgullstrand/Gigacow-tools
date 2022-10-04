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
                 Server = "sqldbtest2-1.ad.slu.se\\inst1",
                 Database = "Gigacow_QA"
)
odbcListObjects(con)

DiagnosisList_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Health_DiagnosisTreatment_DataView")) %>%
  group_by(FarmName_Pseudo, DiagnosisName) %>%
  count(FarmName_Pseudo,DiagnosisName, sort = TRUE)
DF.DiagnosisList = collect(DiagnosisList_Con)


TreatmentList_Con = con %>% tbl(in_catalog("Gigacow_QA", "science", "Health_DiagnosisTreatment_DataView")) %>%
  group_by(FarmName_Pseudo, DiagnosisName) %>%
  count(FarmName_Pseudo,TreatmentName, sort = TRUE)
DF.TreatmentList = collect(TreatmentList_Con)
#test
