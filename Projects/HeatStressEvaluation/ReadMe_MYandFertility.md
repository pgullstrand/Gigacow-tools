# From sensitive to robust athlete – exploring the opportunities of genomic selection to help dairy cows cope with increasing temperatures: Part 2 – THI affecting reproduction

**Project group:** Tomas Klingström, Lena-Mari Tamminen, Martin Johnsson, Patricia Ask-Gullstrand

**Author of ReadMe:** Patricia Ask-Gullstrand, patricia.gullstrand@slu.se, patriciagullstrand91@gmail.com

**Contact:** tomas.klingstrom@slu.se 

**Last date edited:** 2024-12-12

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
The study investigates the relationship between Temperature-Humidity Index (THI) and reproduction in dairy cattle kept under Swedish conditions. THI is a widely used metric to evaluate heat stress in livestock, reflecting the thermal comfort of animals. Elevated THI levels can lead to heat stress, adversely affecting reproductive performance in dairy cattle. 

## Aims
Study aims to analyze how variations in THI influence reproductive performance by: 
- Conducting a preliminary analysis of classical fertility traits using thermal stress threshold at 61 THI as suggested by Joakim Svensson’s previous work.
- Estimating the threshold levels (using piecewise regression) at which THI begins to significantly reduce fertility, focusing on conception rate.
- Analyzing how increasing temperatures and adjusted THI affects classical fertility traits in dairy cattle.

## Objective
The objectives of this study were to determine critical THI thresholds beyond which reproductive performance (measured by conception rates) begins to decline significantly, to quantify the effect of increasing climate on classical fertility traits used in the Nordic breeding program, and to assess variability across Swedish herds and breeds used in commercial production. 

The null hypothesis is that dairy cattle experience a decrease in overall reproductive performance due to thermal stress.

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

Scripts under “../Gigacow-tools/HeatStressEvaluation/DataPreprocessing/”
1. BuildingDataset.ipynb (advised)
- updated.csv
- MY_weather.csv
  - HeatStressCleanWorkflow.ipynb (old process code, redundant)
1. FertilityTraits.ipynb – ready to push
- fertilityDF.csv
- fertilityDF_W61.csv
- fertilityDF_W67.csv
2. HS_fertility_FilteringDataframe.ipynb
- fertilityDF_W_MY61_filtered.csv (full dataframe)
- fertilityDF_W_MY67_filtered.csv (full dataframe)
- fertility_filtered61.csv (clean dataframe)
- fertility_filtered67.csv (clean dataframe)
- Note: Desk. stat at end of script for filtered data for Table 1
3. PrepCRThresholdAnalysis.ipynb
- ../Data/CR_W_MY.csv (old dataset)
- ../Data/CR_W_MY61.csv
- ../Data/CR_W_MY67.csv
- Note: performs THI thresholds estimation at end of script
Script under “../Gigacow-tools/HeatStressEvaluation/Modeling/”
1. FertilityAnalysis.ipynb

## Methods and statistical analysis
Production data were extracted from the SLU Gigacow infrastructure from seven commercial dairy herds with data recorded from 2022-01-01 until 2024-08-18. Matching weather data from the Swedish Meteorological and Hydrological Institute mesoscale analysis system (SMHI MESAN) were merged with each milking event. A mean value of MESAN data was added to each day when the cow was not milked, e.g. during dry off period and during errors in data collection from the milking system resulting in no milk yield data for the given milking event. A mean value of temperature and adjusted THI was calculated for each day, and each service was aligned with corresponding THI data. 

The following classical fertility traits defined according to Nordic Cattle Genetic Evaluation (2024) were analyzed:
- Interval from calving to first insemination (CFI), number of days
- Interval from calving to last insemination (CLI), number of days
- Interval from first to last insemination (FLI), number of days
- Number of services (NINS)
- Conception rate (CR), binary
- Calving interval (CI), number of days
- Gestation length (GL), number of days

Heat stress threshold was assumed at 15 ºC, or an adjusted THI of 61 degrees, where adjusted THI was defined according to Mader et al. (2006):

〖THI〗_adj=4.51+0.8*T+RH*(T-14.4)+46.4-(1.992*WS)+(0.0068*RAD)

The threshold for thermal stress was also estimated using piecewise linear regression with initial parameters at 0.7, -0.00, 0.07, 61 according to intercept, slope and breakpoint estimations, which yielded a THI threshold of 68 degrees.

Preliminary analysis focused on adjusted THI 7 days prior to, during and 7 days after inseminations on the basis that this period is crucial for oocyte development, estrus detection, morula/blastocyst development and early embryonic survival. These analyses were performed using linear mixed models.

## Data editing description
**Population criteria**
- Data from 2022-01-01 to 2024-08-18
- Dairy cattle from eleven commercial herds included
- Keep only data from SH and NRDC (Swedish Red Dairy Cattle, Danish Red, and Swedish Ayrshire) 
- Have fertility, THI and MY data

**Editing criteria**
1. The following filtering steps are required:
- Add 305d MY from raw data and check missing MY records (especially from herds a756bc39, 6d38bc90)
  
2. The following filtering steps are according to NAV (2024):
- Keep only lactation 1-8 
- Make parity 1, 2, >=3 
- Records within 150 days from data extraction are excluded from the data set post-trait definition
- Only the first 10 inseminations are accepted for CR 
- Age at first calving: 550d - 1100d 
- CI maximum 2 years for cows
- CFS 20 - 230d
- FLS max 365d
  
3. In addition, putting thresholds on classical fertility traits according to NAV or µ+-2SD of respective trait (i.e. if out of range, observation is put to missing)
- CFI: 20-230d
- CLI: 20-217d
- FLI: 0-365d
- CI: 301-730d
- GL: 260-302d

4. Allow for minimum 5 records in HYS groups (of insemination date) to help convergence in analysis
5. Allow for minimum 5 breed usage in contemporary groups
6. Add threshold for 305d MY

## References
- Mader et al., 2006: https://doi.org/10.2527/2006.843712x
- Nordic Cattle Genetic Evaluation: NAV official genetic evaluation of Dairy Cattle – data and genetic models. 2024. https://nordicebv.info/wp-content/uploads/2024/05/NAV-routine-genetic-evaluation-May-2024.pdf. 

## Final file description
fertilityDF_W61/67_filtered.csv containing full dataframe, not specified here

fertility_filtered61/67.csv containing the following structure:
- SE_Number: Cow identification
- Breed 
	- NRDC: SRB, DR, SAB
	- SH
- LactationNumber: Number of current calving
- Parity: Lactation 1, 2, >=3
- InseminationDate: Date of service
- HYS of insemination: Herd-Year-Season of service
- HeatStress: whether the cow experienced thermal stress 7d prior to, during and 7d after insemination, binary
	- 61 degrees for fertilityDF_W61_filtered.csv and fertility_filtered61.csv
	- 67 degrees for fertilityDF_W67_filtered.csv and fertility_filtered67.csv
- Milk_Kg: 305 day’s milk yield
- CFI: Interval between calving and first insemination, in days
- CLI: Interval between calving and last insemination, in days
- FLI: Interval between first and last insemination, in days
- NINS: Total number of inseminations during service period
- CR0: Conception rate, binary
- CI: Calving interval, in days
- GL: Gestation length, in days

