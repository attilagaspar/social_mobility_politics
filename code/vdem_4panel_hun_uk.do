
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



tsset country_id year

local v2x_rule_color = "black"
local v2xeg_eqprotec_color = "red"
local v2x_civlib_color = "blue"
local v2xcl_prpty_color = "green" 

local title1 = "Rule of Law"
local title2 = "Equal protection"
local title3 = "Civil liberties"
local title4 = "Property rights"

local i = 1  
foreach v of varlist v2x_rule v2xeg_eqprotec v2x_civlib v2xcl_prpty {

    twoway   (connected `v' year if country_name=="Hungary",   lwidth(vthick)   lcolor(``v'_color') mcolor(``v'_color') legend(off) ) ///
        (connected `v' year if country_name=="United Kingdom", lwidth(vthick) lcolor(``v'_color'%20) mcolor(``v'_color'%5) mlcolor(``v'_color'%5) legend(off)  ) ///
		, ///
		 xlabel(1780(30)2020, valuelabel nogrid) ///
        ylabel(, nogrid) ///
        xtitle("") ytitle("VDEM score") ///
        graphregion(color(white)) ///
        xline(1867, lpattern(solid) lcolor(gray%50) lwidth(thick)) ///
        xline(1919, lpattern(solid) lcolor(gray%50) lwidth(thick)) ///
        xline(1945, lpattern(solid) lcolor(gray%50) lwidth(thick)) ///
        xline(1989, lpattern(solid) lcolor(gray%50) lwidth(thick)) ///
        text(0.95 1825 "Habsburg",       color(gray)) ///
        text(0.90 1825 "Monarchy",       color(gray)) ///
        text(0.95 1893 "Austria-",       color(gray)) ///
        text(0.90 1893 "-Hungary",       color(gray)) ///
        text(0.23 1932 "Horthy-regency", color(gray) orient(vertical)) ///
        text(0.72 1967 "Communism",      color(gray) orient(vertical)) ///
        text(0.40 2006 "III. Republic",  color(gray) orient(vertical)) ///
		ylabel(0 0.2 0.4 0.6 0.8 1) ///
		name(panel`i', replace) leg(off) ///
		title("`title`i''") 
		
		 local i = `i'+1
		
}

graph combine panel1 panel2 panel3 panel4, ///
    col(2) row(2) xsize(10) ysize(8) 

graph export ../figures/vdem.pdf, replace
	
