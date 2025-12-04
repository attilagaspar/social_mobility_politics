use "$population_control_data_dir/marriages_pop_y5.dta" , clear
append using "$population_control_data_dir/pop_y2016_year.dta"
append using "$population_control_data_dir/pop_y1998_year.dta"
append using "$population_control_data_dir/pop_y1869_year.dta"
append using "$population_control_data_dir/pop_y1720_y5.dta"

replace y5 = year if y5==.&year!=.
replace year = y5 if year == .&y5!=.


tsset year
tsfill, full

keep *_share year



foreach s in "german" "commonjewishname" "nobility" "gerjewsla" /// 
 "roma" "romanian" "hunref" "top20" "endsi" "roma2" {

	ipolate `s'_share year, gen(`s'_ip)



}



*"german" "commonjewishname" "nobility" "ueduc500" "ueduc1000" "gerjewsla" /// 
 "roma" "romanian" "hunref" "top20" "endsi" "roma2" "iw_hs" "iw_ls" "ls18th" "voc" "lowstat" "highstat


keep *_ip year

save "$population_control_data_dir/population_control_ipolated_to18thcentury.dta",replace



