
use "../../social mobility (1)/data_forpublication/intermediate/officers_year.dta", clear
..

use "../../social mobility (1)/data/final_data/anal_reps_year_assumption_to18.dta", clear


tempfile rep 
save `rep'

use "../../social mobility (1)/data/final_data/anal_doctor_year_assumption_to18.dta", clear

merge 1:1 year using `rep', gen(merge_rep)
keep if year>=1770


scatter noble_share_in_doctors noble_share_in_reps year, xline(1847.5 1866.5 1919.5 1944.5 1989.5) ///
msymbol(Oh X) msize(medium large) mlwidth(normal thick) ///
ytitle("share ..y named" ) xtitle(year) ///
leg(col(2) order(1 "Doctors" 2 "Representatives") pos(6)) ///
xlabel(1770 1800 1840 1880 1920 1960 2000 2020) name(y, replace) xsize(1) ysize(1)

scatter top20_share_in_doctors top20_share_in_reps year, xline(1847.5 1866.5 1919.5 1944.5 1989.5) ///
msymbol(Oh X) msize(medium large) mlwidth(normal thick) ///
ytitle("share top20" ) xtitle(year) ///
leg(col(2) order(1 "Doctors" 2 "Representatives") pos(6)) /// 
xlabel(1770 1800 1840 1880 1920 1960 2000 2020) name(top20, replace) xsize(1) ysize(1) ylabel(0 .1 .2 .3 .4)

graph combine y top20, xsize(2) ysize(1)

graph export ../figures/longdata_raw.pdf, replace
graph export ../figures/longdata_raw.png, replace
/*
use "../../social mobility (1)\data\final_data\anal_reps_y10_assumption_to18.dta", clear

use "../../social mobility (1)\data\final_data\anal_doctor_y10_assumption_to18.dta", clear

*/

use "../../social mobility (1)/data/final_data/anal_officers_y10_assumption.dta", clear
tempfile army
save `army'

use "../data/anal_guard_y10_to18.dta", clear
tempfile guard
save `guard'


use "../../social mobility (1)/data/final_data/anal_reps_y10_assumption_to18.dta", clear


tempfile rep 
save `rep'

use "../../social mobility (1)/data/final_data/anal_doctor_y10_assumption_to18.dta", clear

merge 1:1 y10 using `rep', gen(merge_rep)
merge 1:1 y10 using `army', gen(merge_army)
merge 1:1 y10 using `guard', gen(merge_guard)
keep if y10>=1760


twoway connected relative_rep_noble_dr relative_rep_noble_reps relative_rep_noble_officers relative_rep_noble_guard y10, xline(1847.5 1866.5 1919.5 1944.5 1989.5) ///
msymbol(Oh X) msize(medium large) mlwidth(normal thick) ///
ytitle("share ..y named" ) xtitle(year) ///
leg(col(2) order(1 "Doctors" 2 "Representatives") pos(6)) ///
xlabel(1770 1800 1840 1880 1920 1960 2000 2020) name(y, replace) xsize(1) ysize(1) ylabel(0 2 4 6 8 10 12) ///
text( 2 1800 "Habsburg empire" , orientation(vertical)) text(  2   1855  "Absolutism" , orientation(vertical))  text(   2   1890 "Constitutional" "Monarchy" , orientation(vertical)) text(  2 1926 "Horthy-regime", orientation(vertical))  ///
text(  2 1950 "Communism", orientation(vertical)) text(  2 2000 "Democracy", orientation(vertical))


twoway connected relative_rep_top20_dr relative_rep_top20_reps y10, xline(1847.5 1866.5 1919.5 1944.5 1989.5) ///
msymbol(Oh X) msize(medium large) mlwidth(normal thick) ///
ytitle("R top20" ) xtitle(year) ///
leg(col(2) order(1 "Doctors" 2 "Representatives") pos(6)) /// 
xlabel(1770 1800 1840 1880 1920 1960 2000 2020) name(top20, replace) xsize(1) ysize(1) ylabel(0 .25 .5 .75 1) ///
text( .16 1800 "Habsburg empire" , orientation(vertical)) text(  .16   1855  "Absolutism" , orientation(vertical))  text(   .16   1890 "Constitutional" "Monarchy" , orientation(vertical)) text(  .16 1926 "Horthy-regime", orientation(vertical))  ///
text(  .16 1950 "Communism", orientation(vertical)) text(  .16 2000 "Democracy", orientation(vertical))

graph combine y top20, xsize(2) ysize(1)
sddssdd
graph export ../figures/longdata_rr.pdf, replace
graph export ../figures/longdata_rr.png, replace