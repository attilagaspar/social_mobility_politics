

/* this dofile prepares name group specific variables in DOCTOR data */


use "$population_control_data_dir/$population_control_file", clear

gen y5=floor(year/5)*5
gen y10=floor(year/10)*10
do Periods_definition.do

collapse (mean) *_ip, by(`1')
local collapsevar = "`1'"

* name shares in doctors
merge 1:1 `1' using "$intermediate_data_dir/doctor_groups_`1'.dta" , gen (merge_doctors)
* doctor share in population
merge 1:1 `1' using  "$intermediate_data_dir/doctor_popshare_`1'.dta", gen(merge_cohort2)


merge 1:1 `1' using  "$doctor_domestic_cohort_size/domestic_share_of_medical_graduates_`1'.dta",  gen(merge_domestic_share)

replace domestic_share_actual = 1 if domestic_share_actual ==. & `1'<2018

merge 1:1 `1' using  "$roma_cohort_size/roma_share_`1'.dta",  gen(merge_roma_share)

replace roma_share_predicted = .01149176 if roma_share_predicted ==. & `1'<2018


* GREG SAYS: LET'S ASSUME ELITENESS OF OFFICERS IS 2%
if ("`2'"=="assumption") {
	replace doctor_popshare_ma = .005  // ez volt a b calculatorban, én 0.01-gyel dolgoztam

}
*replace doctor_popshare_ma = grad_ip if `2' == "" 

tsset `1'


* these variables are not used, and their names are too long
*drop german_share_in_doctors slavic_share_in_doctors romanian_share_in_doctors 			///
cjewishname_share_in_doctors grmn_broad_share_in_doctors slv_broad_share_in_doctors 		///
rmn_broad_share_in_doctors  cjewishname_share_in_doctors_ip  ///
grmn_broad_share_in_doctors_ip slv_broad_share_in_doctors_ip rmn_broad_share_in_doctors_ip 

*roma2_ip noble_share_in_doctors_ip hunref_share_in_doctors_ip top20_share_in_doctors_ip endsi_share_in_doctors_ip roma2_share_in_doctors_ip roma_share_in_doctors_ip ueduc500_share_in_doctors_ip ueduc1000
foreach v of varlist *_share_in_doctors_ip   {

	* moving averaging because of uncertainty in exact year of graduation
	*gen `v'_ma= ( l.`v'+l2.`v'+`v'+f.`v'+f2.`v' ) /5
	rename `v' `v'_ma

}


* correct for foreign doctor share 

/**/
foreach v of varlist  *_share_in_doctors* {
 disp "`v'"
 replace `v'=`v'/domestic_share_actual

}


gen relative_rep_jewish_ip = cjn_share_in_doctors / commonjewishname_ip
gen relative_rep_german_ip =  grmn_share_in_doctors/ german_ip
gen relative_rep_gjs_ip = gerjewsla_share_in_doctors / gerjewsla_ip



rename nobility_ip noble_ip

foreach s in "noble" "roma2"  "top20"  ///
	  {

	gen relative_rep_`s'_hun = ( `s'_share_in_doctors_ip_ma / `s'_ip ) / ( hunref_share_in_doctors_ip_ma  / hunref_ip )

}


* same vis-a-vis whole population


foreach s in "noble" "roma2"  "top20"   ///
	"endsi" "roma"  "hunref"  {

	gen relative_rep_`s' = ( `s'_share_in_doctors_ip_ma / `s'_ip ) 

}



foreach s in "noble" "roma2"  "top20"   ///
	"endsi" "roma"   "hunref" {

	gen relative_rep_`s'_nr = ( `s'_share_in_doctors_ip_ma / `s'_ip ) * (1-roma_share_predicted)

}


foreach s in "noble" "roma2"  "top20"   ///
	"endsi" "roma""hunref"   {

	gen doctor_share_`s' = ( relative_rep_`s'*doctor_popshare_ma ) 

}

foreach s in "noble" "roma2" "top20"   ///
	"endsi" "roma" "hunref"   {

	gen doctor_share_`s'_nr = ( relative_rep_`s'_nr*doctor_popshare_ma ) 

}


* calculate latent status means vis-a-vis whole population

gen x_elite = invnormal(1-doctor_share_noble) // elite mean, really y_bar - x_pop
gen x_pop = invnormal(1-doctor_popshare_ma) // pop mean   // but this is really y_bar -x_pop

gen x_elite_nr = invnormal(1-doctor_share_noble_nr) // elite mean, really y_bar - x_pop
*gen x_pop = invnormal(1-doctor_popshare_ma) // pop mean   // but this is really y_bar -x_pop - ez ugyanaz, mert ez a z score cutoff


/*
gen  x_hunref = invnormal(1-doctor_share_hun) // pop mean   // but this is really y_bar -x_pop
gen x_top20 = invnormal(1-doctor_share_top20) // ref group mean 1
gen x_endsi = invnormal(1-doctor_share_endsi) // ref group mean 1
gen x_roma = invnormal(1-doctor_share_roma)
gen x_roma2 = invnormal(1-doctor_share_roma2)
gen x_ueduc500 = invnormal(1-doctor_share_ueduc500)
gen x_ueduc1000 = invnormal(1-doctor_share_ueduc1000)
gen x_iw_hs = invnormal(1-doctor_share_iw_hs)
gen x_iw_ls = invnormal(1-doctor_share_iw_ls)
*/
foreach s in "noble" "roma2"   "top20" ///
	"endsi" "roma" "hunref"  {

	gen x_`s' = invnormal( 1-doctor_share_`s' ) 

}
foreach s in "noble" "roma2"   "top20" ///
	"endsi" "roma"  "hunref"  {

	gen x_`s'_nr = invnormal( 1-doctor_share_`s'_nr ) 

}


* calculate latent status means vis-a-vis other name groups
gen noble_mean_pop = x_pop-x_elite   // elite mean - population mean    -- EZ KI VOLT KOMMENTELVE, DE MIÉRT?
gen noble_mean_top20 = x_top20-x_elite	 // elite mean - reference group mean
gen noble_mean_endsi = x_endsi-x_elite	 // elite mean - reference group mean
gen noble_mean_pop_nr = x_pop-x_elite_nr   // elite mean - population mean    -- EZ KI VOLT KOMMENTELVE, DE MIÉRT?

gen roma2_mean_hun =  x_hunref - x_roma2
*gen ueduc500_mean_hun =  x_hunref-x_ueduc500
gen noble_mean_hun =  x_hunref - x_elite
gen top20_mean_hun =  x_hunref - x_top20

*gen ls18th_mean_hun =  x_hunref - x_ls18th

gen roma_mean_pop = x_pop-x_roma
gen roma2_mean_pop = x_pop-x_roma2
*gen ueduc500_mean_pop = x_pop-x_ueduc500
*gen ueduc1000_mean_pop = x_pop-x_ueduc1000
gen hun_mean_pop = x_pop - x_hunref
gen top20_mean_pop = x_pop - x_top20
*gen ls18th_mean_pop = x_pop - x_ls18th



gen roma_mean_pop_nr = x_pop-x_roma
gen roma2_mean_pop_nr = x_pop-x_roma2_nr
*gen ueduc500_mean_pop_nr = x_pop-x_ueduc500_nr
*gen ueduc1000_mean_pop_nr = x_pop-x_ueduc1000_nr
gen hun_mean_pop_nr = x_pop - x_hunref_nr
gen top20_mean_pop_nr = x_pop - x_top20_nr
*gen ls18th_mean_pop_nr = x_pop - x_ls18th_nr


*gen ueduc500_mean_top20 = x_top20-x_ueduc500
gen roma2_mean_top20 = x_top20-x_roma2



* create log status advantages
gen log_noble_mean_pop = log(x_pop-x_elite)   // elite mean - population mean
gen log_noble_mean_top20 = log(x_top20-x_elite)	 // elite mean - reference group mean
gen log_noble_mean_endsi = log(x_endsi-x_elite)	 // elite mean - reference group mean
gen log_noble_mean_hun = log( x_hunref - x_elite)

*log_iw_hs_mean_pop_nr_dr 
gen log_noble_mean_pop_nr = log(x_pop-x_elite_nr)   // elite mean - population mean
gen log_top20_mean_pop_nr = log( x_top20_nr - x_pop)
gen log_top20_mean_pop = log( x_top20 - x_pop)

/* makes no sense - X is the distance from the mean to the cutoff, so a bigger X means actually a 
* more disadvantaged group*/
gen log_roma_mean_pop = log(x_roma)
gen log_roma2_mean_pop = log(x_roma2)

*gen log_ueduc500_mean_pop = log(x_ueduc500)
*gen log_ueduc1000_mean_pop = log(x_ueduc1000)




/*
* attach labels
la var roma_mean_pop "Roma names"
la var ueduc500_mean_pop "Frequent (500)"
la var ueduc1000_mean_pop "Frequent (1000)"
la var log_roma_mean_pop "Roma names"
la var log_ueduc500_mean_pop "Frequent (500) low status names"
la var log_ueduc1000_mean_pop "Frequent (1000) low status names"
la var log_noble_mean_pop  "mean status of -y names in log(sd.) units over whole pop."
la var log_noble_mean_top20 "mean status of -y names in log(sd.) units over top20."
la var log_noble_mean_endsi "mean status of -y names in log(sd.) units over -i names"
*/

/* data for final analysis*/

preserve 
	keep  `1'  relative_* *_mean_* 	 *_share_in_*
			
	foreach v of varlist relative_* *_mean_*  {
			rename `v' `v'_dr
			
			}
	save "$intermediate_data_dir/anal_doctor_`1'_`2'_to18.dta", replace
restore

