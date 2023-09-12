***********************************
**** Giulia Salvi
**** Task 2
**** Program to produce Table IV-VI 
***********************************



log using "C:\Users\xsalgi\Desktop\Task2\2b\master.log", replace 

*Please change it to make it work
global rootdir "C:\Users\xsalgi\Desktop\Task2\2b\AK91"
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
do Management/Code/Management.do


*Analysis to replicate tables 
!rmdir "Analysis/Results" /s /q
mkdir "Analysis/Results"
do Analysis/Code/Analysis.do


log close
