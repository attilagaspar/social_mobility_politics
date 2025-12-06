/*

	ynames feudalism figure

*/

*use   "$population_control_data_dir/$population_control_file", clear

* nobility 1720 .05347824
* top20 1720 .16347936

* nobility 1895 .03365152
* top20 1895 .15976453
clear
use  "$intermediate_data_dir/anal_doctor_y10_assumption_to18"
merge 1:1 y10 using  "$intermediate_data_dir/anal_law_y10_assumption", gen(merge_law)
merge 1:1 y10 using  "$intermediate_data_dir/anal_officers_y10_assumption", gen(merge_army)
merge 1:1 y10 using  "$intermediate_data_dir/relprep_y10.dta", gen(merge_business)
merge 1:1 y10 using  "$intermediate_data_dir/anal_reps_y10_assumption_to18.dta", gen(merge_reps)


replace y10 = y10+5
keep if y10<=2020&y10>1770

local doctors = "lcolor(black) lwidth(thick) msymbol(diamond) mcolor(black) lpattern(solid)"
local lawyers = "lcolor(red) lwidth(thick) msymbol(diamond) mcolor(red) lpattern(solid)"
local business = "lcolor(ltblue) lwidth(thick) msymbol(diamond) mcolor(ltblue) lpattern(solid)"
local mps = "lcolor(gold) lwidth(thick) msymbol(diamond) mcolor(gold) lpattern(solid)"
local officers = "lcolor(lime) lwidth(thick) msymbol(diamond) mcolor(lime) lpattern(solid)"



local drvar = "relative_rep_noble_dr"
local lawvar = "relative_rep_noble_law"
local officervar = "relative_rep_noble_officers"
local repvar = "relative_rep_noble_reps"
local busvar = "relative_rep_noble_bus"

gen relrep_noble_land =  0.5249 / .05347824 if y10==1775
replace relrep_noble_land = 0.1825 /  .03365152 if y10 == 1875

gen relrep_top20_land =  0.0233 / .16347936 if y10==1775
replace relrep_top20_land = 0.0406 /  .15976453 if y10 == 1875



* HABSBURG
twoway  (scatter relrep_noble_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(connected `drvar' y10 if y10<1870, `doctors' ) ///
					(connected `repvar' y10 if y10==1855|y10==1865, `mps' msize(large) ) ///
			(connected `repvar' y10 if y10==1845, `mps' msize(large)) ///
			    (connected `repvar' y10 if y10<1840, `mps' ) ///
				(connected `officervar' y10 if y10<1870, `officers' ) ///
,  text(9 1775 "1767", place(c) size(small)) text(4.5 1875 "1895", place(c) size(small)) ///  
  text(8.4 1775 "(52%)", place(c) size(small)) text(3.9 1875 "(18%)", place(c) size(small)) ///  
text(10 1865 "Pre-Compromise Diets", place(c) size(small)) text(4.5 1845 "Revolutionary Diets", place(c) size(small)) ///
legend(order(1 "Land owned" 2 "Medical students" 3 "Members of Diet" 6 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(1770 " " 1780 "1780" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade") 