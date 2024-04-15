#install.packages("odbc")
#install.packages("DBI")
#install.packages("dplyr")
#install.packages("dbplyr")
#install.packages("ggplot2")
#install.packages("likert")

library(odbc)
library(DBI)
library(dplyr)
library(dbplyr)
library(likert)
library(ggplot2)


#Connecting to the database using the R user credentions.
con <- dbConnect(odbc(), 
                 Driver = "/opt/microsoft/msodbcsql18/lib64/libmsodbcsql-18.3.so.2.1", 
                 Server = "gigacow.db.slu.se", 
                 Database = "gigacow", 
                 UID = "gig_kok", 
                 PWD = rstudioapi::askForPassword("Enter your password"),
                 TrustServerCertificate = "yes")
odbcListObjects(con)

Calving_Con = con %>% tbl(in_catalog("gigacow", "sciKok", "Kok_Calving"))

#The below code chunks run SQL queries on each table and then downloads the result.
Calving_Con = con %>% tbl(in_catalog("gigacow", "sciKok", "Kok_Calving"))
Calving_Cow_Raw = collect(Calving_Con)

#This is a test to make sure that the number of calvings remain the same after the recoding is done.
calving_counts_Raw <- Calving_Cow_Raw %>%
  group_by(CalvingEase) %>%
  summarise(count = n())

#Step: 1: Recoding to numerical values and storing levels
Calving_Cow <- Calving_Cow_Raw %>%
  mutate(CalvingEase = as.factor(dplyr::recode(CalvingEase,
                              'Lätt, ingen hjälp (L)' = 1,
                              'Lätt, med hjälp (L)' = 2,
                              'Normal förlossning (N)' = 3,
                              'Svår, utan veterinärhjälp (S)' = 4,
                              'Svår, med Veterinärhjälp (S)' = 5,
                              'Svår förlossning (kon bedöms ej kunnat kalva utan draghjälp) (S)' = 6,
                              'Tidig kalvning (T)' = 7,
                              'Felläge (F)' = 8,
                              'Uppgift om förlossning saknas' = 9)))

CalvingEase_levels <- c('Lätt, ingen hjälp (L)', 
                        'Lätt, med hjälp (L)', 
                        'Normal förlossning (N)', 
                        'Svår, utan veterinärhjälp (S)',
                        'Svår, med Veterinärhjälp (S)',
                        'Svår förlossning (kon bedöms ej kunnat kalva utan draghjälp) (S)',
                        'Tidig kalvning (T)',
                        'Felläge (F)',
                        'Uppgift om förlossning saknas'
                        )

calving_counts <- Calving_Cow %>% #Count to make sure data remains the same
  group_by(CalvingEase) %>%
  summarise(count = n())

# Step 2: Filter data for farms with at least 50 calvings
filtered_data <- Calving_Cow %>%
  group_by(ActiveHerdNumber) %>%
  filter(n() >= 50) %>%
  ungroup()

filtered_data %>%
  group_by(ActiveHerdNumber) %>%
  summarise(MeanCE = mean(as.integer(CalvingEase)), SD_CE = sd(as.integer(CalvingEase)), n = n())


CalvingEaseSummary = filtered_data %>%
  group_by(ActiveHerdNumber, CalvingEase) %>%
  summarise(n = n()) %>%
  mutate (freq = n / sum(n)) %>%
  arrange(ActiveHerdNumber, CalvingEase)

sum(CalvingEaseSummary$n)  