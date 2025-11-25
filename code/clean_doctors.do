/* this script calculates:

1. doctor share in society
2. -y, -i, top20 share in doctors

*/


local collapsevar = "`1'"
/* Rita data: Modern day doctor registries */
/* Pawel data: Historical records of Semmelweis */

* Rita
use "$doctors_raw_dir/list_of_doctors/consistent_list_of_doctors_20180228.dta", clear
rename year_of_g year
destring year, force replace
rename type_of type // harmonize variable names across datasets

rename countx grads 
tempfile modern
save `modern'

* Pawel
use  "$doctors_raw_dir/consistent_doctors_1746_1991.dta", clear



/* 
  - Drop all present year data because it is bad - he dropped observation count variable
  - Drop birth year data because it is just grad year - 25 
*/

drop if source=="Doctor registries"


*drop year_birth


/* clean graduation year */
split year_grad, parse("/") gen(y)   // when academical year is given, use later part
destring y1 y2, force replace
replace y2 = y2+y1-mod(y1,100)       // convert 1895/96 -->   1895/1896
gen year = y1						
replace year = y2 if y2!=.			 // replace with second part
drop y1 y2 year_grad 							 // cleanup

*
replace year = year_birth + 26 if year==.&year_birth!=.  // this was an error previously

/* these are unique observations for family names, unlike the modern data, so
a count variable needs to be created */
gen grads = 1 
* harmonize variable data with the other data set
drop type
gen type = 1 // everyone is a "doctor" in this data set


append using `modern'
replace source = "Doctor registries" if source==""

* this is an assumption
gen age = 26

tempfile graduates
save `graduates'



/* load official graduate count data */
import excel "$doctors_cohort_size/doctors official stats.xlsx", sheet("graduates") firstrow clear
ipolate total_doc year, gen(total_doc_ip)
tempfile official
save `official'

/* prepare cohort data on the 25 year old population */

import excel "$doctors_cohort_size/doctors official stats.xlsx", sheet("cohort") firstrow clear
gen total_cohort = man_+wmn_
drop previous after

local n=_N+1
set obs `n'
replace year = 1746 if year==.
tsset year
tsfill
gen log_coh = log(total_cohort)
reg log_coh year if year<1939
predict log_coh_pre1939 if year<1939
gen cohort_imputed = total_cohort
replace cohort_imputed = exp(log_coh_pre1939) if cohort_imputed==.

la var cohort_imputed "Imputed"
la var total_cohort "Observed"

tempfile cohort
save `cohort'


/* go back to graduate data to create the population share of doctors */
use `graduates', clear


* we start from yearly data, regardless of the collapse var
collapse (sum) grads, by(year)

sort year
keep if year<=2016


merge 1:1 year using `official', gen(merge_official_data)
merge 1:1 year using `cohort', gen(merge_cohort)

tsset year


gen doctors_imputed = grads
replace doctors_imputed = total_doc_ip if total_doc_ip!=.&total_doc>grads

gen graduates_ma5 = 1/5*(l2.grads+l.grads+grads+f.grads + f2.grads)
gen graduates_ma7 = 1/7*(l3.doctors_imputed+l2.doctors_imputed+l.doctors_imputed+doctors_imputed+f.doctors_imputed + f2.doctors_imputed+f3.doctors_imputed)

la var doctors_imputed "number of graduates"
la var graduates_ma7 "7-year moving average"
*twoway line doctors_imputed graduates_ma7 year, title("Number of medical school graduates") graphregion(color(white))
*graph export "../figures/descriptives/medschool.png", replace


gen doctor_popshare_ma = graduates_ma7 / cohort_imputed
gen doctor_popshare = doctors_imputed / cohort_imputed


tempfile popshare 
save `popshare'
save "$intermediate_data_dir/doctor_popshare_year", replace

* if we collapse by decade
preserve
	cap gen y10=floor(year/10)*10
	collapse (sum) graduates_ma7 doctors_imputed cohort_imputed, by(y10)
	gen doctor_popshare_ma = graduates_ma7 / cohort_imputed
	gen doctor_popshare = doctors_imputed / cohort_imputed
	save "$intermediate_data_dir/doctor_popshare_y10", replace
restore

* if we collapse by periods
preserve

do Periods_definition.do

	collapse (sum) graduates_ma7 doctors_imputed cohort_imputed, by(periods)
	gen doctor_popshare_ma = graduates_ma7 / cohort_imputed
	gen doctor_popshare = doctors_imputed / cohort_imputed
	save "$intermediate_data_dir/doctor_popshare_periods", replace
restore






/* we don't use this anymore
* collapse by half decade
preserve
	cap gen y5=floor(year/5)*5

	collapse (sum) graduates_ma7 doctors_imputed cohort_imputed, by(y5)
	gen doctor_popshare_ma = graduates_ma7 / cohort_imputed
	gen doctor_popshare = doctors_imputed / cohort_imputed
	save ../data/repro/doctor_popshare_y5, replace
restore
*/


/***************/
/* do analysis */
/***************/

use `graduates', clear


rename family_name lastname

/*
* remove non-maiden names (these end in "-ne")
gen ln = strreverse(lastname)
replace ln = subinstr(ln, "en","",1) if substr(lastname,-2,2)=="ne"&lastname!="bene"
replace lastname=strreverse(ln) if substr(lastname,-2,2)=="ne"&lastname!="bene"
drop ln
*/
***************************
do create_name_groups.do
***************************

*drop if length(lastname)<3 // added on 02/03/2021
/*
 DON'T DROP NAMES - WE KNOW THESE ARE ACTUAL PEOPLE NOT EMPTY LINES
 DROPPING THEM CHANGES THE DENOMINATOR IN THE GROUP SHARES
*/

gen y10=.
forvalues i=0/26 {
	local s= 1750 + `i'*10
	local e= 1759 + `i'*10
	replace y10=`s' if inrange(year, `s',`e')
}	
drop if y10==.
gen y5 = floor(year/5)*5

gen count = 1

do Periods_definition.do


/*

	frequency table

*/
*estpost tab y10 [w=grads] if y10>=`1'
*eststo


foreach collapsevar of varlist y10 y5 year periods {
preserve
	disp "collapsing by `collapsevar'"

*		 ueduc500_share_in_doctors = ueduc500 ueduc1000_share_in_doctors = ueduc1000 ///
*		 ls18th_share_in_doctors = ls18th ///*
*		 voc_share_in_doctors = voc ///


	collapse (mean) german_share_in_doctors = german slavic_share_in_doctors = slavic romanian_share_in_doctors = romanian ///
		 cjewishname_share_in_doctors = commonjewishname german_broad_share_in_doctors = german_broad  ///
		 slavic_broad_share_in_doctors = slavic_broad romanian_broad_share_in_doctors = romanian_broad  ///
		 noble_share_in_doctors = nobility top20_share_in_doctors = top20 roma_share_in_doctors = roma endsi_share_in_doctors = endsi  ///
		 hunref_share_in_doctors = hun_ref ///
		 roma2_share_in_doctors = roma2 ///
		 (sum)  doctor_count = count doctor_noble_count = nobility [weight = grads] , by(`collapsevar')
		 
		 
	rename romanian_broad_share_in_doctors rmn_broad_share_in_doctors
	rename german_broad_share_in_doctors grmn_broad_share_in_doctors
	rename slavic_broad_share_in_doctors slv_broad_share_in_doctors

	* this is because 1945 and 1946 data are not reliable
	*drop if year == 1946
	*drop if year == 1945 




	foreach v of varlist *_share_in_doctors {
		
		*gen `v'_ci1 = `v'+1.96*`v'_se
		*gen `v'_ci2 = `v'-1.96*`v'_se
		ipolate `v' `collapsevar', gen(`v'_ip)

	}




	save "$intermediate_data_dir/doctor_groups_`collapsevar'.dta", replace

restore

}

