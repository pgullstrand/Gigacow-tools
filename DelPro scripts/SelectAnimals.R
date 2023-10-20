#This script is made to access the Gigacow database and select all animals from a list (animallist.csv) 
#that lives on the farms specified in the script.

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

# Create a temporary table from the animal_numbers data frame in the database
db_animal_numbers <- copy_to(con, animal_numbers, name = "animal_numbers3", temporary = TRUE)

# Join the SQL table with the temporary table using semi_join
Gigacow_Cow_DataView_Con <- tbl(con, in_catalog("Gigacow_QA", "science", "Gigacow_Cow_DataView")) %>%
  filter(FarmName_Pseudo %in% c("ad0a39f5", "a756bc39")) %>%
  semi_join(db_animal_numbers, by = c("AnimalNumber" = "AnimalNumber"))

# Collect the result into a local data frame
DF.Gigacow_Cow <- collect(Gigacow_Cow_DataView_Con)

