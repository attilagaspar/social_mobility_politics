
use  "$intermediate_data_dir/anal_doctor_year_assumption_to18",clear
merge 1:1 year using  "$intermediate_data_dir/anal_law_year_assumption", gen(merge_law)
merge 1:1 year using  "$intermediate_data_dir/anal_officers_year_assumption", gen(merge_army)
merge 1:1 year using  "$intermediate_data_dir/relprep_year.dta", gen(merge_business)
merge 1:1 year using  "$intermediate_data_dir/anal_reps_year_assumption_to18.dta", gen(merge_reps)


/*
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
*/
merge 1:1 year using "../data/raw/vdem/V-Dem-CY-Core-v14_HUN.dta", gen(merge_vdem)
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

/*

*---------------------------------------------------------------*
* 1. Run PCA on all variables starting with v2
*    (you can choose the number of components)
*---------------------------------------------------------------*

pca v2*, cor components(10)

*---------------------------------------------------------------*
* 2. Extract loading matrix from PCA
*---------------------------------------------------------------*

matrix L = e(L)

*---------------------------------------------------------------*
* 3. Compute communalities = sum of squared loadings for each var
*---------------------------------------------------------------*
mata:
    L = st_matrix("L")      // loadings (variables x components)
    H = rowsum(L:^2)        // sum of squared loadings across PCs
    st_matrix("H", H)       // return to Stata
end

*---------------------------------------------------------------*
* 4. Create dataset with variables and their communality
*---------------------------------------------------------------*

svmat H, names(comm)        // creates variable comm1 with communalities
gen varname = ""            // variable storing variable names

* Fill in variable names corresponding to v2*
local i = 1
foreach v of varlist v2* {
    replace varname = "`v'" in `i'
    local ++i
}

*---------------------------------------------------------------*
* 5. Sort by communality and show the top 4 variables
*---------------------------------------------------------------*
sort comm1
list varname comm1 in -4/l, noobs
*v2xeg_eqaccess  v2x_corr v2csprtcpt
 */
twoway connected  v2x_rule   v2xeg_eqprotec v2x_civlib  v2xcl_prpty year, lcolor(black red green blue orange)  mcolor(black red green  blue orange) ///
legend( col(2) row(2) pos(6)  size(vsmall)) ///
xlabel(1780(10)2019,valuelabel labsize(vsmall) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("VDEM score", size(vsmall)) title("", size(small))  /// 
 graphregion(color(white)) xsize(6.5) xline(1823, lwidth(50) lc(green*0.1) lpattern(solid)) ///
 xline(1892, lwidth(30) lc(red*0.1) lpattern(solid)) ///
 xline(1931.5, lwidth(13.5) lc(green*0.1) lpattern(solid)) ///
  xline(1967, lwidth(24) lc(red*0.1) lpattern(solid)) ///
 xline(2006, lwidth(21) lc(green*0.1) lpattern(solid)) ///
  text( 0.95  1825 "Habsburg Monarchy", color(gray)) ///
 text( 0.95  1893 "Austria-Hungary", color(gray)) ///
text( 0.95  1932 "Horthy-", color(gray)) ///
text( 0.90  1932 "regency", color(gray)) ///
text( 0.95  1967 "Communism", color(gray)) ///
text( 0.5  2006 "III. Republic", color(gray)) 
 
graph export ../figures/vdem.pdf, replace

 /*

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

/*
* BIZTOS KELL SIMÍTANI???

*log_rr_noble_dr  log_rr_noble_law  log_rr_noble_bus   log_rr_top20_reps ///
*log_rr_top20_dr log_rr_top20_law log_rr_top20_bus log_rr_noble_reps ///

twoway line log_rr_noble_dr_smooth  log_rr_noble_law_smooth  log_rr_noble_bus_smooth    log_rr_noble_reps_smooth ///
log_rr_top20_dr_smooth log_rr_top20_law_smooth log_rr_top20_bus_smooth log_rr_top20_reps_smooth  /// 
year if year<2020, legend(pos(6) row(2) col(3)) xlabel(1870 " " 1880 1900 1920 1940 1960 1980 2000 2020) xline(1917.4 1919.5 1944.5 1948.5 1989.5) xtitle(" ") ytitle("Log(RR)") title("Simított éves Log(RR) idősorok") lcolor(red green) ///
text( 1.95  1893 "Dualizmus", color(gray)) ///
text( 1.95  1932 "Horthy", color(gray)) ///
text( 1.95  1969 "Kommunizmus", color(gray)) ///
text( 1.95  2005 "Köztársaság", color(gray)) ///
yline(0) leg(order(1 "Orvosok (-y)" 2 "Jogászok (-y)" 3 "Igazgatók (-y)" 4 "Képviselők (-y)" 5 "(Top20)" 6 "(Top20)" 7 "(Top20)" 8 "(Top20)" )) lcolor(red green black cyan red green black cyan)

graph export ../figures/logrr.pdf, replace



twoway scatter log_rr_noble_dr  log_rr_noble_law  log_rr_noble_bus    log_rr_noble_reps ///
log_rr_top20_dr log_rr_top20_law log_rr_top20_bus log_rr_top20_reps  /// 
year if year<2020, legend(pos(6) row(2) col(3)) xlabel(1870 " " 1880 1900 1920 1940 1960 1980 2000 2020) xline(1917.4 1919.5 1944.5 1948.5 1989.5) xtitle(" ") ytitle("Log(RR)") title("Simított éves Log(RR) idősorok") lcolor(red green) ///
text( 1.95  1893 "Dualizmus", color(gray)) ///
text( 1.95  1932 "Horthy", color(gray)) ///
text( 1.95  1969 "Kommunizmus", color(gray)) ///
text( 1.95  2005 "Köztársaság", color(gray)) ///
yline(0) leg(order(1 "Orvosok (-y)" 2 "Jogászok (-y)" 3 "Igazgatók (-y)" 4 "Képviselők (-y)" 5 "(Top20)" 6 "(Top20)" 7 "(Top20)" 8 "(Top20)" )) mcolor(red green black cyan red green black cyan)

graph export ../figures/logrr_nosmooth.pdf, replace

dsdssd


/* make panel
M_log_rr_noble_bus_smooth 
M_log_rr_top20_bus_smooth 
M_log_rr_noble_dr_smooth 
M_log_rr_top20_dr_smooth 
M_log_rr_noble_law_smooth 
M_log_rr_top20_law_smooth 
M_log_rr_noble_reps_smooth 
M_log_rr_top20_reps_smooth
*/

foreach v of varlist v2x_polyarchy   v2xcl_prpty  v2xcl_rol  v2x_frassoc_thick v2x_corr    {
	
	reg log_rr_noble_dr_smooth `v' i.bigregime
	newey log_rr_noble_dr_smooth `v' i.bigregime, lag(3)
}




foreach v of varlist v2x_polyarchy   v2xcl_prpty  v2xcl_rol  v2x_frassoc_thick v2x_corr    {
	
	reg log_rr_top20_dr_smooth `v' i.bigregime
	newey log_rr_top20_dr_smooth `v' i.bigregime, lag(3)
}


stop


* 2) Reshape wide -> long using @ to mark the j-position
*    This matches vars like: M_log_rr_noble_bus_smooth, M_log_rr_top20_dr_smooth, etc.
reshape long M_log_rr_@_smooth, i(year) j(ge) string

* 3) Clean up: rename the long variable and split j into group & elite
rename M_log_rr__smooth M_log_rr_smooth
split ge, parse("_") gen(ge_)
rename ge_1 group    // "noble" or "top20"
rename ge_2 elite    // "bus", "dr", "law", "reps"
*drop ge
order  year group elite M_log_rr_smooth


reg  M_log_rr_smooth c.v2x_egaldem##i.g bigregime##g, rob

areg M_log_rr_smooth v2x_libdem , rob 


/*
newey M_log_rr_top20_bus_smooth v2x_libdem , lag(3) 
reg M_log_rr_top20_bus_smooth v2x_libdem , rob

newey M_log_rr_noble_bus_smooth v2x_libdem , lag(3) 
reg M_log_rr_noble_bus_smooth v2x_libdem , rob

foreach v of varlist ///
	v2x_polyarchy /// Electoral Democracy Index (Polyarchy)
	v2x_libdem ///  Liberal Democracy Index
	v2x_egaldem ///  Egalitarian Democracy Index
	v2x_freexp ///  Freedom of expression & alternative sources of information
	v2x_rule ///  Rule of Law
	v2x_corr ///  Political Corruption Index
	v2x_jucon ///  Judicial constraints on the executive
{
	
	
	newey M_log_rr_noble_bus_smooth `v' , lag(3) 

	
}

/*


foreach v of varlist  v2x_libdem   {
	
	disp "******** Y *************"
			foreach r of varlist ///
					relative_rep_noble_dr  ///
					relative_rep_noble_law  ///
					relative_rep_noble_bus  ///
					relative_rep_noble_reps  ///
					 {
						
						*reg `r' `v', rob 
			
					*reg `r'  `v' i.bigregime, rob
					reg  d_`r'_ma   `v' i.bigregime, rob
					
		}
		
		disp "********* TOP20 *********"
		foreach r of varlist ///
					relative_rep_top20_dr  ///
					relative_rep_top20_law  ///
					relative_rep_top20_bus  ///
					relative_rep_top20_reps ///
					 {
						
						*reg `r' `v', rob 
			
					*reg `r'  `v' i.bigregime, rob
					reg d_`r'_ma  `v' i.bigregime, rob
		}
	
	
}
