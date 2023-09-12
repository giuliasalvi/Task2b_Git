***********************************
**** Giulia Salvi
**** Task 1
**** Peogram to produce Table IV-VI 
***********************************



log using "C:\Users\xsalgi\Desktop\AK91\master.log", replace 

*Please change it to make it work
global rootdir "C:\Users\xsalgi\Desktop\AK91"
cd $rootdir

*Load raw data to Management/Input folder. 

*Remove and create Management/Input directory 
* /Q -- Quiet mode, won't prompt for confirmation to delete folders.
* /S -- Run the operation on all folders of the selected path.
!rmdir "Management/Input" /s /q
mkdir "Management/Input"
copy Raw/NEW7080.dta Management/Input/

*Build data sets in Analysis/Input
!rmdir "Analysis/Input" /s /q
mkdir "Analysis/Input"
do Management/Code/TableIV_data.do
do Management/Code/TableV_data.do
do Management/Code/TableVI_data.do

*Analysis to replicate tables 
!rmdir "Analysis/Results" /s /q
mkdir "Analysis/Results"
do Analysis/Code/TableIV_analysis.do
do Analysis/Code/TableV_analysis.do
do Analysis/Code/TableVI_analysis.do

log close
