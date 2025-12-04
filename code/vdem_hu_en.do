
use  "$intermediate_data_dir/anal_doctor_year_assumption_to18",clear
merge 1:1 year using  "$intermediate_data_dir/anal_law_year_assumption", gen(merge_law)
merge 1:1 year using  "$intermediate_data_dir/anal_officers_year_assumption", gen(merge_army)
merge 1:1 year using  "$intermediate_data_dir/relprep_year.dta", gen(merge_business)
merge 1:1 year using  "$intermediate_data_dir/anal_reps_year_assumption_to18.dta", gen(merge_reps)


merge 1:m year using "../data/raw/vdem/V-Dem-CY-Core-v14_HUN_UK.dta", gen(merge_vdem)

drop *_codelow *_codehigh *_sd
keep if merge_vdem==3


foreach v of varlist v2* {
	
	if (year==1789&`v'==.) {
		disp "dropped `v'"
		drop `v'
		
	}
	
	
}

drop *_osp 
drop *_mean
drop *_nr 
drop *_ord 

preserve


keep if country_name=="Hungary"
tsset  year 

twoway connected  v2x_rule   v2xeg_eqprotec v2x_civlib  v2xcl_prpty year, lcolor(black red green blue orange)  mcolor(black red green  blue orange) ///
xlabel(1780(30)2020,valuelabel labsize(vsmall) nogrid) ylabel(,  nogrid) ///
xtitle("") ytitle("VDEM score", )  /// 
 graphregion(color(white)) xsize(6.5) xline(1867, lpattern(solid)  lcolor(gray%50) lwidth(thick) ) ///
 xline(1919,  lpattern(solid) lcolor(gray%50) lwidth(thick) ) ///
 xline(1945,  lpattern(solid) lcolor(gray%50) lwidth(thick) ) ///
  xline(1989,  lpattern(solid) lcolor(gray%50) lwidth(thick) ) ///
  text( 0.95  1825 "Habsburg", color(gray)  ) ///
    text( 0.90  1825 "Monarchy", color(gray) ) ///
 text( 0.95  1893 "Austria-", color(gray)  ) ///
  text( 0.90  1893 "-Hungary", color(gray)  ) ///
text( 0.2  1932 "Horthy-regency", color(gray) orient(vertical) ) ///
text( 0.720  1967 "Communism", color(gray)  orient(vertical) ) ///
text( 0.40  2006 "III. Republic", color(gray)  orient(vertical)) ///
name(p1, replace) title("Hungary" , size(large)) ///
leg(row(1) col(4) size(small))

restore, preserve


keep if country_name=="United Kingdom"
tsset  year

twoway connected  v2x_rule   v2xeg_eqprotec v2x_civlib  v2xcl_prpty year, lcolor(black red green blue orange)  mcolor(black red green  blue orange) ///
legend( col(2) row(2) pos(6)  size(vsmall)) ///
xlabel(1780(30)2020,valuelabel  nogrid) ylabel(,  nogrid) ///
xtitle("") ytitle("VDEM score", ) /// 
 graphregion(color(white)) ///
name(p2, replace) title("United Kingdom", size(large)) ///
xline(1867, lpattern(solid)  lcolor(gray%25) lwidth(thick) ) ///
 xline(1919,  lpattern(solid) lcolor(gray%25) lwidth(thick) ) ///
 xline(1945,  lpattern(solid) lcolor(gray%25) lwidth(thick) ) ///
  xline(1989,  lpattern(solid) lcolor(gray%25) lwidth(thick) ) ///
  text( 0.95  1825 "Habsburg", color(gray%25)  ) ///
    text( 0.90  1825 "Monarchy", color(gray%25) ) ///
 text( 0.95  1893 "Austria-", color(gray%25)  ) ///
  text( 0.90  1893 "-Hungary", color(gray%25)  ) ///
text( 0.2  1932 "Horthy-regency", color(gray%25) orient(vertical) ) ///
text( 0.720  1967 "Communism", color(gray%25)  orient(vertical) ) ///
text( 0.40  2006 "III. Republic", color(gray%25)  orient(vertical)) 

grc1leg p1 p2, col(2) row(1) xsize(2) ysize(1) 
