#This script uses the Windows credentials of the user to log into the Gigacow test server to retrieve data.
#In order to use this script you need to be running R as a registered Gigacow user on a computer capable of
#accessing the Active Directory of SLU.

#install.packages("odbc")
#install.packages("DBI")


library(odbc)
library(DBI)

#Connecting to the database using the R user credentions.
con <- dbConnect(odbc(),
                 Driver = "SQL Server",
                 Server = "gigacow_qa.db.slu.se",
                 Database = "Gigacow_QA"
)
odbcListObjects(con)

#Shows the available tables in the schema.
odbcListObjects(con, catalog="Gigacow_QA", schema="science")

#Multiple examples of tables accessible to the user.
table_id_robot <- Id(catalog = "Gigacow_QA", schema = "science", table = "MilkRobot_DataView")
DF.Robot <- dbReadTable(con, table_id_robot)

table_id.common <- Id(catalog = "Gigacow_QA", schema = "science", table = "CowMilkYield_Common_View")
DF.Common <- dbReadTable(con, table_id.common)

table_id.lactation <- Id(catalog = "Gigacow_QA", schema = "science", table = "Reproduction_Lactation_DataView")
DF.Lactation <- dbReadTable(con, table_id.lactation)

table_id.traffic <- Id(catalog = "Gigacow_QA", schema = "science", table = "Traffic_DataView")
DF.Traffic <- dbReadTable(con, table_id.traffic)

table_id.cow <- Id(catalog = "Gigacow_QA", schema = "science", table = "Gigacow_Cow_DataView")
DF.Cow <- dbReadTable(con, table_id.cow)

table_id_robotYield <- Id(catalog = "Gigacow_QA", schema = "science", table = "CowMilkYield_Robot_View")
DF.RobotYield <- dbReadTable(con, table_id_robotYield)





#Looking at two values with summarised data
with(DF.Robot, table(FarmName_Pseudo))
with(DF.Grop, table(FarmName_Pseudo))
dbDisconnect(con)