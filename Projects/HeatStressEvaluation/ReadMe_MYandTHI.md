# From sensitive to robust athlete – exploring the opportunities of genomic selection to help dairy cows cope with increasing temperatures: Part I – THI and its effect on MY

**Project group:** Lena-Mari Tamminen, Tomas Klingström, Martin Johnsson, Patricia Ask-Gullstrand, Joakim Svensson

**Author of ReadMe:** Patricia Ask-Gullstrand, patricia.gullstrand@slu.se, patriciagullstrand91@gmail.com

**Contact:** tomas.klingstrom@slu.se

**ReadMe last date edited:** 2024-12-12

## Table of Contents
0. Prerequisites
1. Features
2. Project description
3. Aims
4. Objective
5. Data required
6. Running order of scripts
7. Methods and statistical analysis
8. Data editing description
   1.  Population criteria
   2.  Editing criteria
9. References
10. Final file description

## Prerequisites
VS Code, Git and GitHub. Clone the following repositories:
- https://github.com/TKlingstrom/Gigacow-tools.git (data processing)
- https://github.com/jockepolis/HeatStressEvaluationSummer24.git (mainly for modelling)
- Download required data from SLU Gigacow's infrastructure (Samo), see "Data required" for more info

## Features
- Data processing of cow database data, DelPro data and weather data.
- Statistical modelling.

## Project description
This study investigates the relationship between Temperature-Humidity Index (THI) and milk yield in dairy cattle. THI is a widely used metric to evaluate heat stress in livestock to reflect the thermal comfort of animals. Elevated THI levels can lead to heat stress, adversely affecting feed intake, metabolism, and therefore milk synthesis in dairy cows. Understanding the impact of THI on productivity is critical for optimizing milk production in the face of climate variability. The findings will help dairy farmers implement targeted strategies to improve animal welfare and maintain economic sustainability under changing environmental conditions.

## Aims
The aim of this study was to examine how variations in temperatures and climate affect milk productivity in Nordic dairy cattle breeds kept under Swedish conditions. Both Wilmink and quantile regression for each lactation were performed to estimate expected milk yield. Generalized Additive Models were used to analyze the data in order to explore variation between and within herds and to relate this to the overall farm impact, and individual cow’s heat tolerance and resilience.

## Objective
The objective of this study was to quantify the effect of THI on milk yield by analyzing the degree to which increasing THI levels correlate with changes in milk production. 
The null hypothesis is that an increase in adjusted THI (i.e. thermal stress) will lead to decreasing milk production. 

## Data required
Data are required from SLU’s Gigacow infrastructure on Samo. All data are to be put into the “../Gigacow-tools/Projects/HeatStressEvaluation/Data/CowData folder. The following data is required from the DelPro management system:
- Del_Calving.csv
- Del_Cow.csv
- Del_CowMilkYield_Common.csv
- Del_CowMilkYield_Robot.csv
- Del_DryOff.csv
- Del_Insemination.csv
- Del_Lactation.csv
- Del_Milk_Robot.csv
- Del_PregnancyCheck.csv
- 
And the following data from cow database with specification according to “Produktbeskrivningar_20211011.doc” from previous Svensk Mjölk, and “Kodförteckning_2012.pdf” from Växa Sverige:
- Kok_Calving.csv
- Kok_DairyDelivery.csv
- Kok_Health.csv
- Kok_HerdEntryExit.csv
- Kok_CowMilkSampling.csv
- Kok_LactationReturn.csv
- Kok_Lineage.csv
- Kok_Reproduction.csv
- Kok_VeterinaryTreatment.csv
  
This project also uses data from the Swedish Meteorological and Hydrological Institute mesoscale analysis system (SMHI MESAN), manually put into the folder “../Data/WeatherData/AllPreProcessedWeatherData.”

## Running order of scripts
Run the following scripts to generate the key dataframes specified:

Scripts under “../Gigacow-tools/HeatStressEvaluation/DataPreprocessing/”:
1.	BuildingDataset.ipynb (advised)
  - updated.csv
  - ii.	MY_weather.csv
    - HeatStressCleanWorkFlow.ipynb (old process code, redundant)
    - DataEditing – OLD_CODE (even older process code, redundant)

2.	HS_MY_FilteringDataframe.ipynb
- MY_weather_filtered.csv
- Note: Desk. stat. at end of script for Table 1

3.	PreparationsForWilminks.ipynb
- CleanedYieldData.csv
- Note: Performs THI threshold estimation at end of script

Scripts under “../HeatStressEvaluationSummer24-1/Wilminks/”
1.	WilminksHeatApp.ipynb
- HeatApproachCleanedYieldDataTest61.csv
- HeatApproachCleanedYieldDataTest67.csv
2.	WilminksQuantileHeatApp.ipynb
- HeatApproachCleanedYieldDataTestQuantile61.csv
- HeatApproachCleanedYieldDataTestQuantile67.csv

Scripts under “../HeatStressEvaluationSummer24-1/ModelingFarmLevelYield/”
1.	GAM_FarmMeanTemp.ipynb
2.	GAM_FarmMeanTHI.ipynb
3.	GAM_FarmMeanCumHeatLoad.ipynb

Scripts under “../HeatStressEvaluationSummer24-1/ModelingIndicidualsYield/”
1.	GAM_ IndividualTemp.ipynb
2.	GAM_IndividualTHI.ipynb
3.	GAM_IndividualHeat.ipynb

## Methods and statistical analysis
Production data were extracted from the SLU Gigacow infrastructure from nine commercial dairy herds in Sweden with data recorded from 2022-01-01 until 2024-08-18. Matching weather data from the Swedish Meteorological and Hydrological Institute mesoscale analysis system (SMHI MESAN) were merged with each milking event. A mean value of MESAN data was added to each day when the cow was not milked, e.g. during dry off period and during errors in data collection from the milking system resulting in no milk yield data for the given milking event.

The Wilmink lactation curve was adapted as follows: Y(t)=a+bt+ce(-dt)

where Y(t) is milk yield at time (t) post-calving; a is intercept; b is the linear increase rate of milk yield over time; c is the initial exponential increase in milk yield, d is the rate at which the exponential increase declines over time. To ensure the accuracy of the model, autocorrelation was examined and a robust variant of the Wilmink curve was fitted by adjusting the model introducing lagged daily values to better capture the underlying trend in milk production (Poppe et al., 2020; Ghaderi Zefreh et al., 2024). Finally, the daily milk yield and its change were again normalized relative to the newly adjusted expected yield.
An adjusted THI was used which is defined according to Mader et al. (2006) where temperature, humidity, wind speed and global irradiance are combined. Heat stress threshold assumed at 15 ºC, or a THI of 61 degrees, where adjusted THI was defined as follows:

〖THI〗_adj=4.51+0.8*T+RH*(T-14.4)+46.4-(1.992*WS)+(0.0068*RAD)

The threshold for thermal stress was also estimated using piecewise linear regression with initial parameters at 12.72, -0.00, 0.07, 61 according to intercept, slope and breakpoint estimations. This yielded a THI threshold of 67 degrees, which was used for further analysis.

Bayesian generalized additive models were used to estimate the effect of temperature, adjusted THI, and cumulative heat load on normalized milk production in the different herds as well as for individual cows within respective herd using both 61 and 67 THI degrees as threshold for thermal stress.

## Data editing description
**Population criteria**
-	Data from 2022-01-01 to 2024-08-18
-	Dairy cattle from nine commercial herds included
-	Keep only NRDC (Swedish Red Dairy Cattle, Danish Red, and Swedish Ayrshire), SH, SJB and dairy crosses

**Editing criteria**
-	Combining cow database and DelPro data, see specific notes at start of script “BuildingDataframe.ipynb”

    o	In building the dataframe, cow database data is considered superior and data from DelPro is used to .fillna() of various columns.

    o	In the event of missing data from cow database, DelPro data is used in order to include the given herd in the study
-	Have to start milking by 1-40DIM and maintain milking until 100-400DIM
-	Keep only 1-8 lactation, ordered into parity 1, 2, ≥3
-	Set MY between 2.5-60kg to handle outliers, kick-offs and incomplete milkings
-	Remove colostrum, assume 4 days 

## References
- Ghaderi Zefreh et al., 2024: https://doi.org/10.1016/j.animal.2024.101248
- Mader et al., 2006: https://doi.org/10.2527/2006.843712x
- Poppe et al., 2020: https://doi.org/10.3168/jds.2019-17290

