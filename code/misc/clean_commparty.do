/* this script calculates:

 -y, -i, top20 share in communist party congress 


*/


use "../../social mobility (1)/data/communism/congress/communism_congress_appended.dta", clear

gen year = .
replace year=1962 if strpos(kongresszus, "VIII. KONG")!=0
replace year=1968 if strpos(kongresszus, "IX. kong")!=0
replace year=1970 if strpos(kongresszus, "X. kong")!=0
replace year=1975 if strpos(kongresszus, "XI. kong")!=0
replace year=1980 if strpos(kongresszus, "XII. kong")!=0
replace year=1985 if strpos(kongresszus, "XIII. kong")!=0

rename vezeteknev lastname
keep lastname year 
gen n_person = 1
collapse (sum) n_person, by(lastname year )


gen source = "cp_congress"


do create_name_groups.do

gen y10=floor(year/10)*10 


rename n_person count 

foreach collapsevar of varlist  y10 year   {  //y5 year periods

	preserve
	
	
	collapse (mean) german_share_in_cp = german slavic_share_in_cp = slavic romanian_share_in_cp = romanian ///
		 cjewishname_share_in_cp = commonjewishname   ///
		 noble_share_in_cp = nobility top20_share_in_cp = top20 roma_share_in_cp = roma endsi_share_in_cp = endsi  ///
		 hunref_share_in_cp = hun_ref ///
		 (semean) sd_top20_in_cp = top20 ///
		 sd_noble_in_cp = nobility ///
		 (sum)  business_count = count business_noble_count = nobility  , by(`collapsevar')
		 
	*scatter noble_share top20_share  y, xline(1848 1867 1918 1946 1989)



		save ../data/processed/commparty_`collapsevar'.dta, replace

	restore

}

