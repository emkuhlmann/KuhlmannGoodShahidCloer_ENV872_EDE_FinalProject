# KuhlmannGoodShahidCloer_ENV872_EDE_FinalProject
EDE final project

# Exploring Variables Impacting Asthma Rates and Birth Weight in California 

## Summary

This repository contains code and data for our project investigating asthma rates and low birth weights in relation to PM 2.5, wildfire rates and socioeconomic status in California.There is a Metadata folder containing information on each of the datasets.The Code folder contains all of the coding files relating to exploratory analysis, data wrangling and data visualizations. The Data Folder contains Raw data and Processed data files. Raw data was downloaded from the respective online databases and processed within R, subsequently stored in the Processed folder. 

Our analysis consists of running multiple linear regression models, heatmaps and scatterplots to determine which variables significantly impact low birth weights at term (tLBW) and asthma rates. We are looking at 36 counties across California for which we have complete data for the years 2005-2019.

## Investigators

Ashton Cloer, Duke University;

Elizabeth Good, Duke University, eag73@duke.edu;

Emily Kuhlmann, Duke University, emily.kuhlmann@duke.edu;

Sakina Shahid, Duke University, ss1392@duke.edu

## Keywords

pm2.5, asthma, tLBW, california, wildfire

## Database Information

Data of Percentage of low term birth weights, asthma rates (accessed 11/09/2023) and socioeconomic status by counties in California comes from the CDC National Environmental Public Health Tracking Network.

https://ephtracking.cdc.gov/DataExplorer/

County population data were pulled using the 'tidycensus' package in R. Annual American Community Survey data for counties with populations greater than 65,000 were accessed. 

Wildfire data comes from the CalFire annual statistics summary publications (aka Redbooks) accessed 11/07/2023.

https://www.fire.ca.gov/our-impact/statistics

Air quality data (PM2.5 and ozone) comes the the US EPS Air Data pregenerate data files for annual summary data accessed 11/07/2023. 

https://aqs.epa.gov/aqsweb/airdata/download_files.html#Annual

## Folder structure, file formats, and naming conventions 

The repository contains a Code folder which has all data processing R files for each individual variable and the files with the analytical model code. There is also a Data folder, with Raw and Processed folders within. The Raw folder contains unprocessed .csv files pulled from the data sources. The Processed folder contains wrangled datasets for each variable.  

The data files are all in .csv format and the code are in R files or RMD files. 

For individual variables, the file name contains the variable name, CA, and will say if it is processed. Similarly, the code files are named after the variable and the purpose of the file (e.g. data visualization or data processing). 

## Metadata


Raw/CA_Asthma_EDVisits.csv: 
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| StateFIPS | one-digit state FIPS number (6 for CA) | integer | NA |
| State | California  | factor | NA |
| CountyFIPS | 4-digit county FIPS number  | integer | NA |
| County | county name  | factor | NA |
| Year | year of data | integer | NA |
| Value | number of emergency department visits for asthma  | factor | number of visits |
| Data Comment | empty column for comments  | logi | NA |

Processed/Asthma_data_processed.csv:
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| CountyFIPS | 4-digit county FIPS number  | integer | NA |
| County | county name  | factor | NA |
| Year | year of data | integer | NA |
| Visits | number of emergency department visits for asthma  | integer | number of visits |
| Population | annual population for each county | integer | number of people |
| visits_per100k | number of emergency department visits for asthma per 100k people in the county | numeric | number of visits per 100k |

Processed/CA_population_data.csv:
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| CountyFIPS | 4-digit county FIPS number  | integer | NA |
| County | county name  | factor | NA |
| Year | year of data | integer | NA |
| Population | annual population for each county | integer | number of people |

Processed/CAcounties
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| County | names of all counties included in all datasets | factor | NA |

Raw/poverty05_19
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| StateFIPS | one-digit state FIPS number (6 for CA) | integer | NA |
| State | California | factor | NA |
| CountyFIPS | 4-digit county FIPS number | factor | NA |
| County | names of all counties included in all datasets | character | NA |
| Year | year of data | numeric | NA |
| Value | poverty rate for each county | numeric | percent |

Processed/poverty1_processed
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| CountyFIPS | 4-digit county FIPS number | factor | NA |
| County | names of all counties included in all datasets | character | NA |
| Year | year of data | numeric | NA |
| Percent_Poverty | poverty rate for each county | numeric | percent |
| Population | annual population for each county | integer | number of people |
| Poverty_per100k | poverty rate for each county normalized | numeric | number of people per 100k |

Processed/poverty_byyear_processed
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| Year | year of data | numeric | NA |
| mean_percent | average poverty rate per year | numeric | percent |


Raw/BirthPercent
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| StateFIPS | one-digit state FIPS number (6 for CA) | factor | NA |
| State | California | factor | NA |
| CountyFIPS | 4-digit county FIPS number | factor | NA |
| County | Name of County | factor | NA |
| Year | year of data | integer | NA |
| Value | poverty rate for each county | numeric | NA |

Processed/BirthPercent_counties
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| StateFIPS | one-digit state FIPS number (6 for CA) | factor | NA |
| State | California | factor | NA |
| CountyFIPS | 4-digit county FIPS number | factor | NA |
| County | Name of County | factor | NA |
| Year | year of data | factor | NA |
| Value | poverty rate for each county | numeric | NA |

Raw/EPA_AQS_annual/annual_conc_by_monitor_year.csv:

Note that all year files have the same columns, and units marked "yes" are determined by row by the 'Units of Measure' column
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| State Code | state FIPS in which monitor resides | chr | NA |
| County Code | county FIPS in which monitor resides | chr | NA |
| Site Num | unique numbe within county identifying site | chr | NA |
| Parameter Code | AQS code corresponding to measured parameter | num | NA |
| POC | "Parameter Occurrence Code" distinguishes different instruments measuring same parameter at same site | num | NA |
| Latitude | monitor's angular distance north of the equator | num | decimal degrees |
| Longitude | monitor's angular distance east of the prime meridian | num | decimal degrees |
| Datum | datum associated with the lat long | chr | NA |
| Parameter Name | name assigned in AQS to parameter; pollutant or non-pollutants | chr | NA |
| Sample Duration | length of time that air passes through monitoring device before measure | chr | NA |
| Pollutant Standard | description of the ambient air quality standard rules for aggregate statistics | chr | NA |
| Metric Used | base metric used in calculation of aggregate statistics | chr | NA |
| Method Name | description of processes, equipment, and protocols in gathering and measuring sample | chr | NA |
| Year | year represented by annual summary data | num | NA |
| Units of Measure | unit of measure for the parameter | chr | NA |
| Event Type | indicates whether data measured during exceptional events are included in the summary | chr | NA |
| Observation Count | number of samples taken during the year | num | NA |
| Observation Percent | percent representing the number of observations taken with respect to the number scheduled to be taken | num | NA |
| Completeness Indicator | indication of whether regulatory data completeness criteria have been met | chr | NA |
| Valid Day Count | number of days during the year where daily monitoring criteria were met | num | NA |
| Required Day Count | number of days during the year which the monitor was scheduled to take samples | num | NA |
| Exceptional Data Count | number of data points affected by exceptional air quality events | num | NA |
| Null Data Count | count of scheduled samples when no data was collected and reason no reported | num | NA |
| Primary Exceedance Count | number of samples during the year that exceeded the primary standard | num | NA |
| Secondary Exceedance Count | number of sample during the year that exceeded the secondary standard | num | NA |
| Certification Indicator | indication whether the completeness and accuracy of the information has been certified by the submitter | chr | NA |
| Num Obs Below MDL | the number of samples that were below the method detection limit | num | NA |
| Arithmetic Mean | the average value for the year | num | yes |
| Arithmetic Standard Dev | the standard deviation about the mean for the year | num | yes |
| 1st Max Value | the highest value for the year | num | yes |
| 1st Max DateTime | the date and time when the highest value was taken | POSIXct | NA |
| 2nd Max Value | the second highest value for the year | num | yes |
| 2nd Max DateTime | the date and time when the second highest value was taken | POSIXct | NA |
| 3rd Max Value | the third highest value for the year | num | yes |
| 3rd Max DateTime | the date and time when the third highest value was taken | POSIXct | NA |
| 4th Max Value | the fourth highest value for the year | num | yes |
| 4th Max DateTime | the date and time when the fourth highest value was taken | POSIXct | NA |
| 1st Max Non Overlapping Value | for 8-hour CO averages, the highest value of the year | num | yes |
| 1st NO Max DateTime | the date and time when the first maximumnon overlapping value for the year was taken | POSIXct | NA |
| 2nd Max Non Overlapping Value | for 8-hour CO averages, the second highest value of the year that does not share any hours with the 8-hour period of the first max non overlapping value | num | yes |
| 2nd NO Max DateTime | the date and time when the second maximum non overlapping value for the year was taken | POSIXct | NA |
| 99th Percentile | the value from this monitor for which 99 percent of the rest of the measured values for the year are equal to or less than | num | yes |
| 98th Percentile | the value from this monitor for which 98 percent of the rest of the measured values for the year are equal to or less than | num | yes |
| 95th Percentile | the value from this monitor for which 95 percent of the rest of the measured values for the year are equal to or less than | num | yes |
| 90th Percentile | the value from this monitor for which 90 percent of the rest of the measured values for the year are equal to or less than | num | yes |
| 75th Percentile | the value from this monitor for which 75 percent of the rest of the measured values for the year are equal to or less than | num | yes |
| 50th Percentile | the value from this monitor for which 50 percent of the rest of the measured values for the year are equal to or less than | num | yes |
| 10th Percentile | the value from this monitor for which 10 percent of the rest of the measured values for the year are equal to or less than | num | yes |
| Local Site Name | the name of the site given by the air pollution control agency that operates it | chr | NA |
| Address | the approximate street address of the monitoring site | chr | NA |
| State Name | the name of the state where the monitoring site is located | chr | NA |
| County Name | the name of the county where the monitoring site is located | chr | NA |
| City Name | the name of the city where the monitoring site is located | chr | NA |
| CBSA Name | the name of the core bases statistical area (metropolitan area) where the monitoring site is located | chr | NA |
| Date of Last Change | the date the last time any numeric values in this record wer eupdated in the AQS data system | Date | NA |

Processed/CA_AQ_processed.csv:

Note that units marked "yes" are determined by row by the 'Units of Measure' column
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| Latitude | monitor's angular distance north of the equator | num | decimal degrees |
| Longitude | monitor's angular distance east of the prime meridian | num | decimal degrees |
| Pollutant Standard | description of the ambient air quality standard rules for aggregate statistics | chr | yes |
| Year | year represented by annual summary data | num | NA |
| Units of Measure | unit of measure for the parameter | chr | NA |
| Arithmetic Mean | the average value for the year | num | yes |
| State Name | the name of the state where the monitoring site is located (California) | chr | NA |
| County Name | the name of the county where the monitoring site is located | chr | NA |

Raw/CA_wildfire/year.csv: 

Note that all year files have the same columns
| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| UNIT | county in which the fire occurred | chr | NA |
| YEAR | year in which the fire occurred | num | NA |
| ACRES BURNED | number of acres burned in the fire | num | acres |

Processed/CA_wildfire_processed.csv: 

| Column Name  | Description | Data Class | Units
| ------------- | ------------- | ------------- | ------------- |
| UNIT | county in which the fire occurred | chr | NA |
| YEAR | year in which the fire occurred | num | NA |
| mean | average number of acres burned in the fire | num | acres |

## Scripts and code

1. DataProcessing_SocioEco.RMD: This RMD was used for data wrangling the socioeconomic data, normalizing the data, removing unnecessary counties, saving processed data files, and testing visualization and exploratory data techniques for the final project.
2. FinalCodeforSocio.RMD: Used to communicate final code needed for the final project that represents the socioeconomic data and exploratory analysis.
3. DataProcessing_Asthma.R: This code was used to wrangle the emergency department visits for asthma dataset from the CDC, join it with the processed county population data, normalize the number of emergency department visits by county population, and do initial data visualization.
4. DataVis_Asthma.R: This code provides the processed asthma data and creates the heatmap used in the final PDF.
5. PopulationData.R: This code was used to pull population data for California counties from 2005-2019 using the tidycensus package. It was also used to wrangle the data to inlude the necessary counties and other information. 
6. DataProcessing_BirthPercent.RMD: This code was used to upload the raw data to R and wrangled to tidy the dataset to include relevant counties, years and information. 
7. DataVis_BirthPercent.RMD: The code here was used to visualize the heatmap for low birth weight by county from 2005-2019.
8. CA_wildfire_processing.R: This code reads in each year of raw wildfire data and joins it into one data file with average acreage burned per county per year.
9.  DataProcessing_AirQuality.R: This code reads in each year of airquality data, joins it into one data file, and selects the columns and parameters of interest.
10.  DataVis_wildfire.R: This code takes the processed wildfire data and makes a heat map of acreage burned per county per year.
11.  DataVis_AirQuality.R: This code takes the processed air quality data, filters it into PM2.5 and ozone data summarazed by county by year, and creates box and whisker plots as well as time series plots.
12.  CA_Counties_Mapping.R: This code creates maps to visualize the counties included in the analysis as well as maps of the PM2.5 and ozone air quality monitor locations. 
13.  linear_model.R: This code combines all of the variables of interest into one data frame for MLR analysis. It runs MLR for asthma and birth weights and also does an ANOVA analysis for asthma and birth weights by county. 
14. FinalPorjectCode.RMD: This is the code used to create the PDF document which contains all of the necessary graphs, visualizations and analysis pertaining to our project.


## Quality assurance/quality control

<https://www.dataone.org/best-practices/develop-quality-assurance-and-quality-control-plan>
<https://www.dataone.org/best-practices/ensure-basic-quality-control>
<https://www.dataone.org/best-practices/communicate-data-quality>
<https://www.dataone.org/best-practices/identify-outliers>
<https://www.dataone.org/best-practices/identify-values-are-estimated>

To maintain QA/QC in our analysis, datasets were first checked individually for NAs and were noted amongst a list of counties to be removed. When combining individual datasets, the counties noted with NAs were removed and datasets were joined using variables with the same name, such as Year, CountyFIPS, and County. Secondly, variables of interest, such as poverty and asthma rates, were normalized as per 100k residents. Lastly, this repository was used to facilitate sharing code and the workload amongst the group members.  
