*****************************************
**** Giulia Salvi
**** Task 2
**** Program
*****************************************

cap program drop columns_oddn
*I create a little program to generate Columns 1,3,5,7
program columns_oddn
*Note: Please add at controlc3 your control for column 3 and at controlc5 your
*controls for column 5. Column 7'll have both. 
syntax, y(varname) x(varname) year_dummies(varlist) geo_dummies(varlist) controlc3(varlist) controlc5(varlist)

** Col 1 3 5 7 ***
est clear
reg  `y' `x'  `year_dummies' 
est store c1
reg  `y' `x'   `year_dummies' `controlc3'
est store c3
reg  `y' `x'  `controlc5' `geo_dummies' `year_dummies' 
est store c5
reg  `y' `x'   `controlc5' `geo_dummies' `year_dummies' `controlc3'
est store c7

end 


