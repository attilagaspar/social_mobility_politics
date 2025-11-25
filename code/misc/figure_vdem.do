clear
cap cd "C:\Users\agaspar\Dropbox\research\social_mobility_long20\code\"
cap cd "/Users/pawelbukowski/Dropbox/Social Mobility HUN/social_mobility_long20/code/"
use "../../social mobility (1)/data/final_data/anal_doctor_year_assumption


merge 1:1 year using  "../../social mobility (1)/data/final_data/anal_law_year_assumption", gen(merge_law)
merge 1:1 year using  "../../social mobility (1)/data/final_data/anal_officers_year_assumption", gen(merge_army)
merge 1:1 year using  "../data/processed/relprep_year.dta", gen(merge_business)
merge 1:1 year using  "../../social mobility (1)/data/final_data/anal_reps_year_assumption", gen(merge_reps)


keep year ///
var_lnrr* ///
relative_rep_noble_dr  ///
relative_rep_noble_law  ///
relative_rep_noble_bus  ///
relative_rep_noble_reps  ///
relative_rep_top20_dr  ///
relative_rep_top20_law  ///
relative_rep_top20_bus  ///
relative_rep_top20_reps

merge 1:1 year using "../data/raw/vdem/V-Dem-CY-Core-v14_HUN.dta", gen(merge_vdem)
drop *_codelow *_codehigh *_sd
keep if merge_vdem==3



tsset year


replace relative_rep_noble_reps = l.relative_rep_noble_reps if relative_rep_noble_reps==.
replace relative_rep_noble_reps = l.relative_rep_noble_reps if relative_rep_noble_reps==.
replace relative_rep_noble_reps = l.relative_rep_noble_reps if relative_rep_noble_reps==.
replace relative_rep_noble_reps = l.relative_rep_noble_reps if relative_rep_noble_reps==.
replace relative_rep_noble_reps = l.relative_rep_noble_reps if relative_rep_noble_reps==.


replace relative_rep_top20_reps = l.relative_rep_top20_reps if relative_rep_top20_reps==.
replace relative_rep_top20_reps = l.relative_rep_top20_reps if relative_rep_top20_reps==.
replace relative_rep_top20_reps = l.relative_rep_top20_reps if relative_rep_top20_reps==.
replace relative_rep_top20_reps = l.relative_rep_top20_reps if relative_rep_top20_reps==.
replace relative_rep_top20_reps = l.relative_rep_top20_reps if relative_rep_top20_reps==.


foreach v of varlist ///
relative_rep_noble_dr  ///
relative_rep_noble_law  ///
relative_rep_noble_bus  ///
relative_rep_noble_reps  ///
relative_rep_top20_dr  ///
relative_rep_top20_law  ///
relative_rep_top20_bus  ///
relative_rep_top20_reps {
	
	gen d_`v' = d.`v'/l.`v'
	
	gen `v'_ma  = (l.`v'+f.`v'+`v')/3
    gen d_`v'_ma  = d.`v'_ma

}
*v2x_frassoc_thick v2x_liberal v2xeg_eqdr

gen bigregime = 0 if year<1920
replace bigregime = 1 if year<1944 & bigregime==.
replace bigregime = 2 if year<1990 & bigregime==.
replace bigregime = 3 if year>=1990


foreach s in "dr" "law" "bus" "reps" {
	
	foreach ss in "noble" "top20" {
		
			gen log_rr_`ss'_`s'=log(relative_rep_`ss'_`s')  // distance from parity (rr=1 if this is 0)
			gen abs_log_rr_`ss'_`s'=abs(log(relative_rep_`ss'_`s'))  // absolute distance from parity (rr=1 if this is 0)
			* change in abs_long_rr* is positive if moving away from parity, negative if moving close so let's take minus d
			gen M_`ss'_`s'=-(d.abs_log_rr_`ss'_`s')
			*gen y_`ss'_`s'=log_rr_`ss'_`s'-l.log_rr_`ss'_`s'
			*gen M_`ss'_`s'=-abs(y_`ss'_`s')
	}
	
}


*weights

gen w_noble_bus  =  1/var_lnrr_noble
gen w_top20_bus  =  1/var_lnrr_top20

* poly smooths
lpoly log_rr_noble_bus year [aweight=w_noble_bus], degree(2) bwidth(8) gen(log_rr_noble_bus_smooth) at(year) nograph // xline(1920 1945 1989 1958)
lpoly log_rr_top20_bus year [aweight=w_top20_bus], degree(2) bwidth(8) gen(log_rr_top20_bus_smooth) at(year) nograph // xline(1920 1945 1989 1958)

* smoothing with no weights yet
foreach s in "dr" "law" "reps" {
	
	foreach ss in "noble" "top20" {
		
			lpoly log_rr_`ss'_`s' year , degree(2) bwidth(8) gen(log_rr_`ss'_`s'_smooth) at(year)   nograph

	}
	
}



replace log_rr_top20_bus_smooth=. if year<1874
replace log_rr_noble_bus_smooth=. if year<1874




foreach v of varlist *_smooth {
	
	gen abs_`v' = abs(`v')
	gen M_`v' = -(d.abs_`v')
}

replace M_log_rr_noble_law_smooth=. if year>2000
replace M_log_rr_top20_law_smooth=. if year>2000

replace log_rr_noble_law_smooth=. if year>2000
replace log_rr_top20_law_smooth=. if year>2000




foreach v of varlist M*smooth {
	
	replace `v' = . if year<1880
	
}



twoway line log_rr_noble_dr_smooth  log_rr_noble_law_smooth  log_rr_noble_bus_smooth    log_rr_noble_reps_smooth ///
log_rr_top20_dr_smooth log_rr_top20_law_smooth log_rr_top20_bus_smooth log_rr_top20_reps_smooth  /// 
year if year<2020, legend(pos(6) row(2) col(3)) xlabel(1870 " " 1880 1900 1920 1940 1960 1980 2000 2020) xline(1917.4 1919.5 1944.5 1948.5 1989.5) xtitle(" ") ytitle("Log(RR)") title("Smoothed Log(RR) time series") lcolor(red green) ///
text( 1.95  1893 "Austria-Hungary", color(gray)) ///
text( 1.95  1932 "Horthy", color(gray)) ///
text( 1.95  1969 "Communism", color(gray)) ///
text( 1.95  2005 "Republic", color(gray)) ///
yline(0) leg(order(1 "MD (-y)" 2 "JD (-y)" 3 "CEO (-y)" 4 "MP (-y)" 5 "(Top20)" 6 "(Top20)" 7 "(Top20)" 8 "(Top20)" )) lcolor(red green black cyan red green black cyan)

graph export ../figures/logrr_en.pdf, replace



twoway scatter log_rr_noble_dr  log_rr_noble_law  log_rr_noble_bus    log_rr_noble_reps ///
log_rr_top20_dr log_rr_top20_law log_rr_top20_bus log_rr_top20_reps  /// 
year if year<2020, legend(pos(6) row(2) col(3)) xlabel(1870 " " 1880 1900 1920 1940 1960 1980 2000 2020) xline(1917.4 1919.5 1944.5 1948.5 1989.5) xtitle(" ") ytitle("Log(RR)") title("Raw Log(RR) time series") lcolor(red green) ///
text( 1.95  1893 "Austria-Hungary", color(gray)) ///
text( 1.95  1932 "Horthy", color(gray)) ///
text( 1.95  1969 "Communism", color(gray)) ///
text( 1.95  2005 "Republic", color(gray)) ///
yline(0) leg(order(1 "MD (-y)" 2 "JD (-y)" 3 "CEO (-y)" 4 "MP (-y)" 5 "(Top20)" 6 "(Top20)" 7 "(Top20)" 8 "(Top20)" )) lcolor(red green black cyan red green black cyan)

graph export ../figures/logrr_en_nosmooth.pdf, replace
