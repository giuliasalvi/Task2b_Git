***********************************
**** Giulia Salvi
**** Task 1
**** Table V - data management 
***********************************
clear
set mem 500m
cd $rootdir
local infile "Management\Input\NEW7080"
local outfile "Analysis/Input/TableV_data.dta"
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
gen AGEQSQ= AGEQ*AGEQ

** Generate YOB dummies **********
gen YR20=0  
replace YR20=1 if YOB==1920  
replace YR20=1 if YOB==30 
replace YR20=1 if YOB==40 
gen YR21=0  
replace YR21=1 if YOB==1921  
replace YR21=1 if YOB==31
replace YR21=1 if YOB==41 
gen YR22=0  
replace YR22=1 if YOB==1922  
replace YR22=1 if YOB==32 
replace YR22=1 if YOB==42 
gen YR23=0  
replace YR23=1 if YOB==1923 
replace YR23=1 if YOB==33 
replace YR23=1 if YOB==43 
gen YR24=0  
replace YR24=1 if YOB==1924  
replace YR24=1 if YOB==34 
replace YR24=1 if YOB==44 
gen YR25=0  
replace YR25=1 if YOB==1925  
replace YR25=1 if YOB==35 
replace YR25=1 if YOB==45 
gen YR26=0  
replace YR26=1 if YOB==1926  
replace YR26=1 if YOB==36 
replace YR26=1 if YOB==46 
gen YR27=0  
replace YR27=1 if YOB==1927  
replace YR27=1 if YOB==37 
replace YR27=1 if YOB==47 
gen YR28=0  
replace YR28=1 if YOB==1928  
replace YR28=1 if YOB==38 
replace YR28=1 if YOB==48 
gen YR29=0  
replace YR29=1 if YOB==1929  
replace YR29=1 if YOB==39 
replace YR29=1 if YOB==49 

** Generate QOB dummies ***********
gen QTR1=0
replace QTR1=1 if QOB==1
gen QTR2=0
replace QTR2=1 if QOB==2
gen QTR3=0
replace QTR3=1 if QOB==3
gen QTR4=0
replace QTR4=1 if QOB==4

** Generate YOB*QOB dummies ********
gen QTR120= QTR1*YR20
gen QTR121= QTR1*YR21
gen QTR122= QTR1*YR22
gen QTR123= QTR1*YR23
gen QTR124= QTR1*YR24
gen QTR125= QTR1*YR25
gen QTR126= QTR1*YR26
gen QTR127= QTR1*YR27
gen QTR128= QTR1*YR28
gen QTR129= QTR1*YR29

gen QTR220= QTR2*YR20
gen QTR221= QTR2*YR21
gen QTR222= QTR2*YR22
gen QTR223= QTR2*YR23
gen QTR224= QTR2*YR24
gen QTR225= QTR2*YR25
gen QTR226= QTR2*YR26
gen QTR227= QTR2*YR27
gen QTR228= QTR2*YR28
gen QTR229= QTR2*YR29

gen QTR320= QTR3*YR20
gen QTR321= QTR3*YR21
gen QTR322= QTR3*YR22
gen QTR323= QTR3*YR23
gen QTR324= QTR3*YR24
gen QTR325= QTR3*YR25
gen QTR326= QTR3*YR26
gen QTR327= QTR3*YR27
gen QTR328= QTR3*YR28
gen QTR329= QTR3*YR29

keep if COHORT>30.00 & COHORT <30.40

save `outfile', replace