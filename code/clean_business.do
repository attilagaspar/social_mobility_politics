/* this script calculates:

 -y, -i, top20 share in CEOs and other businesspeople


*/
/*

import delimited "../data/raw/compass1.csv", varnames(1) clear

do clean_compass_names.do

save ../data/processed/processed_compass1.dta, replace
*/



use "$business_raw_dir/processed_compass1.dta", clear

do clean_compass_titles.do

keep lastname year role_CEO 

gen n_person = 1
collapse (sum) n_person, by(lastname year role_CEO)

preserve
	keep if role_CEO==0
	save $business_raw_dir/compass_nonceo.dta, replace
restore

keep if role_CEO==1

gen source = "compass"

tempfile compass
save `compass'


/*
	
	feleségekkel nem csináltam még semmit

import delimited "../data/raw/opten_surnames.csv", varnames(1) clear

append using `compass'
keep if decade>=1980
collapse (sum) n_person , by(decade own_family)

rename own_family lastname 
rename decade year


import delimited "../data/raw/vezeteknevek.csv", varnames(1) clear
keep if rt=="true"

keep if decade>=1950
collapse (sum) n_person , by(decade own_family)
rename own_family lastname 
rename decade year
*/


import delimited "$opten_raw_dir/vezeteknevek.csv", varnames(1) clear

keep if rt=="true"
rename own_family_name1 lastname

collapse (sum) n_person, by(lastname year)

gen source="opten"


append using `compass'

do create_name_groups.do

gen y10=floor(year/10)*10 

replace y10 = 1875 if y10==1870
replace y10 = 1875 if y10==1880

replace y10 = 1945 if source=="opten"&y10==1940&year>1943

*figure to justify to use this as a single time series
*binscatter nobility y10, by(source) linetype(connect) rd(1944) xlabel(1875 "1870-'80s" 1890 "90s" 1910 "1910s" 1930 "30s" 1950 "50s" 1970 "70s" 1990 "90s" 2010 "2010s" 2020 " ") ///
*xtitle("Decade") ytitle("Share of -y names") legend(order(1 "Compass" 2 "Opten")) 

*graph export ../figures/merge_justification.pdf, replace


drop if source=="opten"&year<1944 // avoid double counting 

* re-create y10 to conform
replace y10 = floor(year/10)*10 


rename n_person count 

foreach collapsevar of varlist  y10 year   {  //y5 year periods

	preserve
	
	
	collapse (mean) german_share_in_bus = german slavic_share_in_bus = slavic romanian_share_in_bus = romanian ///
		 cjewishname_share_in_bus = commonjewishname   ///
		 noble_share_in_bus = nobility top20_share_in_bus = top20 roma_share_in_bus = roma endsi_share_in_bus = endsi  ///
		 hunref_share_in_bus = hun_ref ///
		 (semean) sd_top20_in_bus = top20 ///
		 sd_noble_in_bus = nobility ///
		 (sum)  business_count = count business_noble_count = nobility [w=count]  , by(`collapsevar')
		 
		save "$intermediate_data_dir/business_`collapsevar'.dta", replace

	restore

}

