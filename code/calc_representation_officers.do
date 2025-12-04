

/* this dofile prepares name group specific variables in OFFICER data */

use  "$population_control_data_dir/$population_control_file", clear

gen y5=floor(year/5)*5
gen y10=floor(year/10)*10
do Periods_definition.do

collapse (mean) *_ip, by(`1')
local collapsevar = "`1'"


* name shares in officers
merge 1:1 `1' using "$intermediate_data_dir/officers_`1'.dta" , gen (merge_officers)


merge 1:1 `1' using  "$roma_cohort_size/roma_share_`1'.dta",  gen(merge_roma_share)

replace roma_share_predicted = .01149176 if roma_share_predicted ==. & `1'<2018

* GREG SAYS: LET'S ASSUME ELITENESS OF OFFICERS IS 2%
*gen officers_popshare = .005 // ez volt a b calculatorban, én 0.01-gyel dolgoztam


	gen officers_popshare  = .005 


rename nobility_ip noble_ip

foreach s in "noble" "roma2"  "top20" {
	
	cap drop x
	ipolate `s'_ip `1', epolate gen(x)
	drop `s'_ip 
	rename x `s'_ip 
	
	
}

tsset `1'




* calculate relative rep




gen relative_rep_jewish_ip = cjn_share_in_officers / commonjewishname_ip
gen relative_rep_german_ip = grmn_share_in_officers / german_ip
*gen relative_rep_german_broad = grmn_broad_share_in_officers / german_broad
gen relative_rep_gjs_ip = gerjewsla_share_in_officers / gerjewsla_ip




foreach s in "noble" "roma2"   "top20"  {

	gen relative_rep_`s'_hun = ( `s'_share_in_officers / `s'_ip ) / ( hunref_share_in_officers  / hunref_ip )

}



foreach s in "noble" "roma2"   "top20"  "hunref"  {

	gen relative_rep_`s' = ( `s'_share_in_officers / `s'_ip ) 

}

foreach s in "noble" "roma2"   "top20" "hunref"  {

	gen relative_rep_`s'_nr = ( `s'_share_in_officers / `s'_ip ) * (1-roma_share_predicted)

}



foreach s in "noble" "roma2"   "top20" "hunref" {

	gen officers_share_`s' = ( relative_rep_`s'*officers_popshare ) 

}

foreach s in "noble" "roma2"  "top20" "hunref"   {

	gen officers_share_`s'_nr = ( relative_rep_`s'_nr*officers_popshare ) 

}


* calculate latent status means vis-a-vis whole population

gen x_elite = invnormal(1-officers_share_noble) // elite mean, really y_bar - x_pop
gen x_pop = invnormal(1-officers_popshare) // pop mean   // but this is really y_bar -x_pop

gen x_elite_nr = invnormal(1-officers_share_noble_nr) // elite mean, really y_bar - x_pop

foreach s in "noble" "roma2"   "top20" "hunref"  {

	gen x_`s' = invnormal( 1-officers_share_`s' ) 

}
foreach s in "noble" "roma2"   "top20" "hunref"  {

	gen x_`s'_nr = invnormal( 1-officers_share_`s'_nr ) 

}


* calculate latent status means vis-a-vis other name groups
gen noble_mean_pop = x_pop-x_elite   // elite mean - population mean    -- EZ KI VOLT KOMMENTELVE, DE MIÉRT?
gen noble_mean_top20 = x_top20-x_elite	 // elite mean - reference group mean
gen noble_mean_pop_nr = x_pop-x_elite_nr   // elite mean - population mean    -- EZ KI VOLT KOMMENTELVE, DE MIÉRT?

gen roma2_mean_hun =  x_hunref - x_roma2
gen noble_mean_hun =  x_hunref - x_elite
gen top20_mean_hun =  x_hunref - x_top20


gen roma2_mean_pop = x_pop-x_roma2
gen hun_mean_pop = x_pop - x_hunref
gen top20_mean_pop = x_pop - x_top20


gen roma2_mean_pop_nr = x_pop-x_roma2_nr
gen hun_mean_pop_nr = x_pop - x_hunref_nr
gen top20_mean_pop_nr = x_pop - x_top20_nr


* create log status advantages
gen log_noble_mean_pop = log(x_pop-x_elite)   // elite mean - population mean
gen log_noble_mean_top20 = log(x_top20-x_elite)	 // elite mean - reference group mean
gen log_noble_mean_hun = log( x_hunref - x_elite)
gen log_noble_mean_pop_nr = log(x_pop-x_elite_nr)   // elite mean - population mean
gen log_top20_mean_pop_nr = log( x_top20_nr - x_pop)


preserve 
	keep  `1'  relative_* *_mean_* 	 *_share_in_*
	foreach v of varlist relative_* *_mean_*  {
			rename `v' `v'_officers
			
			}
	save "$intermediate_data_dir/anal_officers_`1'_`2'.dta", replace
restore

