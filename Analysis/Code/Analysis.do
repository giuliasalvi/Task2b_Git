***********************************
**** Giulia Salvi
**** Task 2
**** Analysis
***********************************

clear all
*Please change it to make it work
global rootdir "C:\Users\xsalgi\Desktop\Task2\2b\AK91"
cd $rootdir

foreach i in IV V VI {
local infile "Analysis/Input/Table`i'_data"
local outdir "Analysis/Results"
use `infile', replace

* Model Specification
local y="LWKLYWGE"    //dependent variable
local x="EDUC"
local year_dummies= "YR20-YR28"
local geo_dummies= "NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT" 


** Col 1 3 5 7 ***
est clear
reg  `y' `x'  `year_dummies'
est store c1
reg  `y' `x'  `year_dummies' AGEQ AGEQSQ
est store c3
reg  `y' `x'  RACE MARRIED SMSA `geo_dummies' `year_dummies'  
est store c5
reg  `y' `x'  RACE MARRIED SMSA `geo_dummies' `year_dummies' AGEQ AGEQSQ 
est store c7


** Col 2 4 6 8 ***
ivregress 2sls `y' `year_dummies' (`x' = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 `year_dummies')
est store c2
ivregress 2sls `y' `year_dummies' AGEQ AGEQSQ (`x' = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 `year_dummies')
est store c4
ivregress 2sls `y' `year_dummies' RACE MARRIED SMSA `geo_dummies'  (`x' = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 `year_dummies')
est store c6
ivregress 2sls `y' `year_dummies' RACE MARRIED SMSA `geo_dummies' AGEQ AGEQSQ (`x' = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 `year_dummies')
est store c8 

}