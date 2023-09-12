***********************************
**** Giulia Salvi
**** Task 1
**** Table IV - Analysis
***********************************

clear
cd $rootdir
local infile "Analysis/Input/TableVI_data.dta"
local outdir "Analysis/Results"
use `infile', replace

** Col 1 3 5 7 ***
est clear
reg  LWKLYWGE EDUC  YR20-YR28 
est store c1
reg  LWKLYWGE EDUC  YR20-YR28 AGEQ AGEQSQ
est store c3
reg  LWKLYWGE EDUC  RACE MARRIED SMSA NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT YR20-YR28  
est store c5
reg  LWKLYWGE EDUC  RACE MARRIED SMSA NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT YR20-YR28 AGEQ AGEQSQ 
est store c7


** Col 2 4 6 8 ***
ivregress 2sls LWKLYWGE YR20-YR28 (EDUC = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 YR20-YR28)
est store c2
ivregress 2sls LWKLYWGE YR20-YR28 AGEQ AGEQSQ (EDUC = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 YR20-YR28)
est store c4
ivregress 2sls LWKLYWGE YR20-YR28 RACE MARRIED SMSA NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT  (EDUC = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 YR20-YR28)
est store c6
ivregress 2sls LWKLYWGE YR20-YR28 RACE MARRIED SMSA NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT AGEQ AGEQSQ (EDUC = QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 YR20-YR28)
est store c8 

*Export as a table in Latex
esttab c* using `outdir'/TableVI.tex, replace b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) booktabs ///
se r2 ar2  ///
alignment(D{.}{.}{-1}) width(0.9\hsize)  