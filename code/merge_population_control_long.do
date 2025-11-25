use "$population_control_data_dir/marriages_pop_y5.dta" , clear
append using "$population_control_data_dir/pop_y2016_year.dta "
append using "$population_control_data_dir/pop_y1998_year.dta "
append using "$population_control_data_dir/pop_y1869_year.dta "
append using "$population_control_data_dir/pop_y1720_y5.dta "

replace y5 = year if y5==.&year!=.
replace year = y5 if year == .&y5!=.


tsset year
tsfill, full

keep *_share year



foreach s in "german" "commonjewishname" "nobility" "ueduc500" "ueduc1000" /// 
 "roma" "romanian" "hunref" "top20" "endsi" "roma2" "iw_hs" "iw_ls" "ls18th" "voc" "lowstat" "highstat"{

	ipolate `s'_share year, gen(`s'_ip)



}

keep *_ip year

save "$population_control_data_dir/`1'",replace


/*
use "../data/census1720/namelist_1720.dta", clear



* Create dummy = 1 if any part of the county remained in Hungary after Trianon
* Start with 0 for everyone
gen remained_hu = 0

* Set to 1 county by county
replace remained_hu = 1 if county_standard == "Abaúj megye"
replace remained_hu = 1 if county_standard == "Arad megye"
replace remained_hu = 1 if county_standard == "Baranya megye"
replace remained_hu = 1 if county_standard == "Bereg megye"
replace remained_hu = 1 if county_standard == "Bihar megye"
replace remained_hu = 1 if county_standard == "Borsod megye"
replace remained_hu = 1 if county_standard == "Bács-Bodrog megye"
replace remained_hu = 1 if county_standard == "Békés megye"
replace remained_hu = 1 if county_standard == "Csanád megye"
replace remained_hu = 1 if county_standard == "Csongrád megye"
replace remained_hu = 1 if county_standard == "Esztergom megye"
replace remained_hu = 1 if county_standard == "Fejér megye"
replace remained_hu = 1 if county_standard == "Győr megye"
replace remained_hu = 1 if county_standard == "Gömör megye"
replace remained_hu = 1 if county_standard == "Heves és Külső-Szolnok megye"
replace remained_hu = 1 if county_standard == "Hont megye"
replace remained_hu = 1 if county_standard == "Komárom megye"
replace remained_hu = 1 if county_standard == "Moson megye"
replace remained_hu = 1 if county_standard == "Nógrád megye"
replace remained_hu = 1 if county_standard == "Pest megye"
replace remained_hu = 1 if county_standard == "Pozsony megye"
replace remained_hu = 1 if county_standard == "Somogy megye"
replace remained_hu = 1 if county_standard == "Sopron megye"
replace remained_hu = 1 if county_standard == "Szabolcs megye"
replace remained_hu = 1 if county_standard == "Szatmár megye"
replace remained_hu = 1 if county_standard == "Tolna megye"
replace remained_hu = 1 if county_standard == "Torna"
replace remained_hu = 1 if county_standard == "Ugocsa megye"
replace remained_hu = 1 if county_standard == "Ung megye"
replace remained_hu = 1 if county_standard == "Vas megye"
replace remained_hu = 1 if county_standard == "Veszprém megye"
replace remained_hu = 1 if county_standard == "Zala megye"
replace remained_hu = 1 if county_standard == "Zaránd megye"
replace remained_hu = 1 if county_standard == "Zemplén megye"

keep if remained_hu == 1

do accents.do lastname
drop nobility

do create_name_groups.do

gen year = 1720
gen y5 = 1720
gen y10 = 1720
save "../data/census1720/namelist_1720_groups_alternative.dta", replace


preserve
	do collapse_withweight count year
	save ../data/pop_y1720_year.dta , replace
restore, preserve
	do collapse_withweight count y5
	save ../data/pop_y1720_y5.dta , replace
restore, preserve
	do collapse_withweight count y10
	save ../data/pop_y1720_y10.dta , replace
