import excel "../../social mobility (1)/data_forpublication/raw/1998_CSALADINEV.xlsx", sheet("stata") firstrow clear

rename lastname lastname_raw
gen lastname=lower(lastname_raw)

rename count population_count

***************************
do create_name_groups.do
***************************


rename population_count count


gen year=1998

preserve
do collapse_withweight.do count year
save "$population_control_data_dir/pop_y1998_year.dta" ,replace
restore

gen y5= floor(year/5)*5

do collapse_withweight.do count y5
save "$population_control_data_dir/pop_y1998_y5.dta" ,replace


