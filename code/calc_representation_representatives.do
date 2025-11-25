

/* this dofile prepares name group specific variables in REPRESENTATIVES data */


use "$population_control_data_dir/$population_control_file", clear

gen y5=floor(year/5)*5
gen y10=floor(year/10)*10

collapse (mean) *_ip, by(`1')
local collapsevar = "`1'"

* name shares in reps
merge 1:1 `1' using "$intermediate_data_dir/reps_groups_`1'.dta" , gen (merge_reps)


merge 1:1 `1' using  "$roma_cohort_size/roma_share_`1'.dta",  gen(merge_roma_share)

replace roma_share_predicted = .01149176 if roma_share_predicted ==. & `1'<=2018

* GREG SAYS: LET'S ASSUME ELITENESS OF OFFICERS IS 2%
*gen reps_popshare = .005 // ez volt a b calculatorban, én 0.01-gyel dolgoztam

if ("`2'"=="assumption") {

	gen reps_popshare  = .005 

}

if ("`2'"=="calculation") {

	/*
	
		eliteness is 1% when the Parliament was the smallest in the post-war era (elections of 1953);
		after that it is relative to this amount.
	
	*/
	
	gen reps_popshare  = .
	replace reps_popshare = 0.01/2*reps_avg/298 if reps_avg!=.


}


tsset `1'


rename nobility_ip noble_ip


* calculate relative rep
foreach s in "noble" "roma2"  "top20"  {

	gen relative_rep_`s'_hun = ( `s'_share_in_reps / `s'_ip ) / ( hunref_share_in_reps  / hunref_ip )

}



foreach s in "noble" "roma2"  "top20"  "hunref"  {

	gen relative_rep_`s' = ( `s'_share_in_reps / `s'_ip ) 

}

foreach s in "noble" "roma2"  "top20" "hunref"   {

	gen relative_rep_`s'_nr = ( `s'_share_in_reps / `s'_ip ) * (1-roma_share_predicted)

}



foreach s in "noble" "roma2" "top20" "hunref" {

	gen reps_share_`s' = ( relative_rep_`s'*reps_popshare ) 

}

foreach s in "noble" "roma2"   "top20" "hunref"   {

	gen reps_share_`s'_nr = ( relative_rep_`s'_nr*reps_popshare ) 

}


* calculate latent status means vis-a-vis whole population

gen x_elite = invnormal(1-reps_share_noble) // elite mean, really y_bar - x_pop
gen x_pop = invnormal(1-reps_popshare) // pop mean   // but this is really y_bar -x_pop

gen x_elite_nr = invnormal(1-reps_share_noble_nr) // elite mean, really y_bar - x_pop

foreach s in "noble" "roma2"   "top20" "hunref"  {

	gen x_`s' = invnormal( 1-reps_share_`s' ) 

}
foreach s in "noble" "roma2"  "top20" "hunref"  {

	gen x_`s'_nr = invnormal( 1-reps_share_`s'_nr ) 

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
			rename `v' `v'_reps
			
			}
	save "$intermediate_data_dir/anal_reps_`1'_`2'_to18.dta", replace
restore

