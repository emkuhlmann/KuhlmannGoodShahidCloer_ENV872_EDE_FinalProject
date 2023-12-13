# KuhlmannGoodShahidCloer_ENV872_EDE_FinalProject
EDE final project

# Exploring Variables Impacting Asthma Rates and Birth Weight in California 

## Summary

This repository contains code and data for our project investigating asthma rates and low birth weights in relation to PM 2.5, wildfire rates and socioeconomic status in California.There is a Metadata folder containing information on each of the datasets.The Code folder contains all of the coding files relating to exploratory analysis, data wrangling and data visualizations. The Data Folder contains Raw data and Processed data files. Raw data was downloaded from the respective online databases and processed within R, subsequently stored in the Processed folder. 

Our analysis consists of running multiple linear regression models, heatmaps and scatterplots to determine which variables significantly impact low birth weights at term (tLBW) and asthma rates. We are looking at 36 counties across California for which we have complete data for the years 2005-2019.

## Investigators

Ashton Cloer,Duke University
Elizabeth Good,Duke University
Emily Kuhlmann,Duke University, emily.kuhlmann@duke.edu
Sakina Shahid,Duke University, ss1392@duke.edu

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

Raw/EPA_AQS_annual/annual_conc_by_monitor_<year>.csv:

Processed/CA_AQ_processed.csv:

Raw/CA_wildfire/<year>.csv: 

Processed/CA_wildfire_processed.csv: 

## Scripts and code

<list any software scripts/code contained in the repository and a description of their purpose.>

1. DataProcessing_SocioEco.RMD: This RMD was used for data wrangling the socioeconomic data, normalizing the data, removing unnecessary counties, saving processed data files, and testing visualization and exploratory data techniques for the final project.
2. FinalCodeforSocio.RMD: Used to communicate final code needed for the final project that represents the socioeconomic data and exploratory analysis.
3. DataProcessing_Asthma.R: This code was used to wrangle the emergency department visits for asthma dataset from the CDC, join it with the processed county population data, normalize the number of emergency department visits by county population, and do initial data visualization.
4. DataVis_Asthma.R: This code provides the processed asthma data and creates the heatmap used in the final PDF.
5. PopulationData.R: This code was used to pull population data for California counties from 2005-2019 using the tidycensus package. It was also used to wrangle the data to inlude the necessary counties and other information. 
6. DataProcessing_BirthPercent.RMD: This code was used to upload the raw data to R and wrangled to tidy the dataset to include relevant counties, years and information. 
7. DataVis_BirthPercent.RMD: The code here was used to visualize the heatmap for low birth weight by county from 2005-2019. 
8. FinalPorjectCode.RMD: This is the code used to create the PDF document which contains all of the necessary graphs, visualizations and analysis pertaining to our project. 

## Quality assurance/quality control

<https://www.dataone.org/best-practices/develop-quality-assurance-and-quality-control-plan>
<https://www.dataone.org/best-practices/ensure-basic-quality-control>
<https://www.dataone.org/best-practices/communicate-data-quality>
<https://www.dataone.org/best-practices/identify-outliers>
<https://www.dataone.org/best-practices/identify-values-are-estimated>

To maintain QA/QC in our analysis, datasets were first checked individually for NAs and were noted amongst a list of counties to be removed. When combining individual datasets, the counties noted with NAs were removed and datasets were joined using variables with the same name, such as Year, CountyFIPS, and County. Secondly, variables of interest, such as poverty and asthma rates, were normalized as per 100k residents. Lastly, this repository was used to facilitate sharing code and the workload amongst the group members.  
