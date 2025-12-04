

* load brides
use "../../social mobility (1)/data_forpublication/raw/marriages_wives.dta" , clear
rename countblname countglname
tempfile wife
save `wife'

* load grooms
use "../../social mobility (1)/data_forpublication//raw/marriages_husbands.dta" , clear
append using `wife'



drop if lastname==""
keep if inrange(yearmdate, 1895,1951)


***************************
do create_name_groups.do
***************************

gen y10 = floor(year/10)*10
gen y5 = floor(year/5)*5


rename countglname count


* create collapses by decade, half decade, year
preserve
do collapse_withweight count y10
save "$population_control_data_dir/marriages_pop_y10.dta", replace

restore, preserve
do collapse_withweight count y5
save "$population_control_data_dir/marriages_pop_y5.dta" , replace

restore
do collapse_withweight count year
save "$population_control_data_dir/marriages_pop_y.dta" , replace
