

use "$reps_raw_dir/reps.dta", clear

drop n3
split fullname, gen(n)
rename n1 lastname



* correct for maiden names where possible - put back maidenname
gen married_woman = 0
replace married_woman = 1 if substr(n2,-3,3)=="né"&n3!=""
replace lastname=n3 if substr(n2,-3,3)=="né"&n3!=""
replace married_woman = 1 if substr(lastname,-3,3)=="né"
replace lastname=n2 if substr(lastname,-3,3)=="né"
replace married_woman = 1 if substr(n3,-3,3)=="né"


***************************
do create_name_groups.do
***************************


gen y10 = floor(year/10)*10
gen y5 = floor(year/5)*5 


gen count=1

do Periods_definition.do



foreach collapsevar of varlist year y10 y5 periods {
	
	preserve
		
		disp "collapsing reps by `collapsevar'"
		collapse (mean)  ///
		top20_share_in_reps = top20      ///
		noble_share_in_reps = nobility 	///
		roma2_share_in_reps = roma2      ///
		hunref_share_in_reps = hun_ref      ///
		jewishname_share_in_reps = commonjewishname   ///
		german_share_in_reps = german  ///
		german_broad_share_in_reps = german_broad  ///
		reps_avg =  count ///
		(sum) reps_count = count 	 	///
		, by(`collapsevar')
	
		save "$intermediate_data_dir/reps_groups_`collapsevar'.dta", replace
	
	restore
}

