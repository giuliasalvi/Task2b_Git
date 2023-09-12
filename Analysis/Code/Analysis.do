***********************************
**** Giulia Salvi
**** Task 2
**** Analysis
***********************************

clear all
cd $rootdir
* Function used throughout
do "Analysis/Code/programs_stata.do"
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

*Export as a table
esttab c* using `outdir'/Table`i'.tex, replace b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
se  ///
alignment(D{.}{.}{-1}) width(0.9\hsize)  

**********************************************************************************************************************************************

****Using the program
columns_oddn, y(`y') x(`x') year_dummies(`year_dummies') geo_dummies(`geo_dummies') controlc3(AGEQ AGEQSQ) controlc5(RACE MARRIED SMSA)
*Export as a table in Latex
*Outputs are saved with the suffix _p to make them different from the previous one. 
esttab c* using `outdir'/Table`i'_p.tex, replace b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
se   ///
alignment(D{.}{.}{-1}) width(0.9\hsize)  

}      

