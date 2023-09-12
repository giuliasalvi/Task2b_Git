***********************************
**** Giulia Salvi
**** Task 2
**** Data Management
***********************************

*Note: to remove duplication of code, I first used macros and loops and then 
*I used xi instead of some loops. You can find the loops I coded before commented

clear all
*Please change it to make it work
global rootdir "C:\Users\xsalgi\Desktop\Task2\2b\AK91"
cd $rootdir
local infile "Raw/NEW7080"
local outfile "Analysis/Input"
set mem 500m
use `infile', replace
local varlist "v1 v2 v4 v9 v10 v16 v18 v19 v20 v27"
local varnames "AGE AGEQ EDUC LWKLYWGE MARRIED CENSUS QOB RACE SMSA YOB"
rename (`varlist') (`varnames')
*Region of residence dummies
* Rename region of residence dummies
local regionlist "v5 v6 v11 v12 v13 v21 v24 v25"
local regionnames "ENOCENT ESOCENT MIDATL MT NEWENG SOATL WNOCENT WSOCENT"
rename (`regionlist') (`regionnames')
*Label
label variable MARRIED "MARRIED (1=Married)"
label variable QOB "Quarter of birth"
label variable RACE "RACE (1=black)"
label variable SMSA "SMSA (1=center city)"
label variable YOB "year of birth"

* Drop unnecessary variables
local dropvars "v8 v3 v7 v14 v15 v17 v22 v23 v26"
drop (`dropvars')

gen COHORT=20.29
replace COHORT=30.39 if YOB<=39 & YOB >=30
replace COHORT=40.49 if YOB<=49 & YOB >=40
replace AGEQ=AGEQ-1900 if CENSUS==80
replace YOB=YOB-1900 if CENSUS==70
gen AGEQSQ= AGEQ*AGEQ


** Generate YOB dummies **********
foreach i of numlist 0/9 {
gen YR2`i'=0  

replace YR2`i'=1 if YOB==2`i'  
replace YR2`i'=1 if YOB==3`i' 
replace YR2`i'=1 if YOB==4`i'
} 

** Generate QOB dummies ***********
/*foreach i of numlist 1/4 {
gen QTR`i' =0
replace QTR`i' =1  if QOB==`i' 
}
*/

char QOB[omit]4
xi i.QOB
rename _IQOB_* QTR*

** Generate YOB*QOB dummies ********
foreach i of numlist 1/3{
	foreach z of numlist 0/9 {
gen QTR`i'2`z'= QTR`i'*YR2`z'

}
}







* Save files for different cohorts
preserve
local max_cohort_1 20.30
keep if COHORT < `max_cohort_1'
save "`outfile'/TableIV_data", replace
restore

preserve 
local min_cohort_2 30.00
local max_cohort_2 30.40
keep if COHORT > `min_cohort_2' & COHORT < `max_cohort_2'
save "`outfile'/TableV_data", replace
restore

preserve 
local min_cohort_3 40.00
keep if COHORT > `min_cohort_3'
save "`outfile'/TableVI_data", replace
restore