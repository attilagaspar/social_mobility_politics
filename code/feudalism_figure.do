/*

	ynames feudalism figure

*/

*use   "$population_control_data_dir/$population_control_file", clear

* nobility 1720 .05347824
* top20 1720 .16347936

* nobility 1895 .03365152
* top20 1895 .15976453

use "$intermediate_data_dir/anal_reps_year_assumption_to18.dta", clear

gen y10 = floor(year/10)*10

tempfile reps
save `reps'

clear
use  "$intermediate_data_dir/anal_doctor_y10_assumption_to18"
merge 1:1 y10 using  "$intermediate_data_dir/anal_law_y10_assumption", gen(merge_law)
merge 1:1 y10 using  "$intermediate_data_dir/anal_officers_y10_assumption", gen(merge_army)
merge 1:1 y10 using  "$intermediate_data_dir/relprep_y10.dta", gen(merge_business)
merge 1:m y10 using  `reps', gen(merge_reps)


replace y10 = y10+5
keep if y10<=2020&y10>1760

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

gen relrep_noble_land =  0.5249 / .05347824 if y10==1765
replace relrep_noble_land = 0.1825 /  .03365152 if y10 == 1875

gen relrep_top20_land =  0.0233 / .16347936 if y10==1765
replace relrep_top20_land = 0.0406 /  .15976453 if y10 == 1875

replace y10 = 1767 if y10==1765

egen t = tag(y10)
/*
twoway  (scatter relrep_noble_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(scatter `drvar' year if y10<1870&t==1, mcolor(white) ) ///
,  text(9 1767 "1767", place(c) size(small)) text(4.5 1875 "1895", place(c) size(small)) ///  
  text(8.4 1767 "(52%)", place(c) size(small)) text(3.9 1875 "(18%)", place(c) size(small)) ///  
legend(order(1 "Land owned" ) pos(6) ) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 2 4 6 8 10 12)  ///
ytitle("Relative representation") title("-y names")   xtitle("Decade") 

graph export ../figures/ynames_feudalism_step1.pdf, replace

twoway  (scatter relrep_noble_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
(scatter `repvar' year if year<1868, `mps' msize(large) ) ///
				(lfit `repvar' year if year<1868&year!=1848, `mps' msize(large) lpattern(dash) ) ///
,  text(9 1767 "1767", place(c) size(small)) text(4.5 1875 "1895", place(c) size(small)) ///  
  text(8.4 1767 "(52%)", place(c) size(small)) text(3.9 1875 "(18%)", place(c) size(small)) ///  
  text(1.2 1848 "Revolutionary Diet", place(c) size(small)) ///
legend(order(1 "Land owned" 2 "Members of Diet" ) pos(6) row(1)) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 2 4 6 8 10 12)  ///
ytitle("Relative representation") title("-y names")   xtitle("Decade") 

graph export ../figures/ynames_feudalism_step2.pdf, replace

twoway  (scatter relrep_noble_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
(scatter `repvar' year if year<1868, `mps' msize(large) ) ///
				(lfit `repvar' year if year<1868&year!=1848, `mps' msize(large) lpattern(dash) ) ///
					(connected `drvar' year if y10<1870&t==1, `doctors' ) ///
													(lfit `drvar' year if year<1868, `doctors' lpattern(dash) msize(large) ) ///
,  text(9 1767 "1767", place(c) size(small)) text(4.5 1875 "1895", place(c) size(small)) ///  
  text(8.4 1767 "(52%)", place(c) size(small)) text(3.9 1875 "(18%)", place(c) size(small)) ///  
  text(1.2 1848 "Revolutionary Diet", place(c) size(small)) ///
legend(order(1 "Land owned" 2 "Members of Diet" 4 "Medical students") pos(6) row(1) col(3)) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 2 4 6 8 10 12)  ///
ytitle("Relative representation") title("-y names")   xtitle("Decade") 

graph export ../figures/ynames_feudalism_step3.pdf, replace

twoway  (scatter relrep_noble_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(connected `drvar' year if y10<1870&t==1, `doctors' ) ///
					(scatter `repvar' year if year<1868, `mps' msize(large) ) ///
				(connected `officervar' y10 if y10<1870&t==1, `officers' ) ///
				(lfit `repvar' year if year<1868&year!=1848, `mps' msize(large) lpattern(dash) ) ///
								(lfit `drvar' year if year<1868, `doctors' lpattern(dash) msize(large) ) ///
,  text(9 1767 "1767", place(c) size(small)) text(4.5 1875 "1895", place(c) size(small)) ///  
  text(8.4 1767 "(52%)", place(c) size(small)) text(3.9 1875 "(18%)", place(c) size(small)) ///  
 text(1.2 1848 "Revolutionary Diet", place(c) size(small)) ///
legend(order(1 "Land owned" 2 "Medical students" 3 "Members of Diet" 4 "Army Officers") pos(6) row(1) ) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 2 4 6 8 10 12)  ///
ytitle("Relative representation") title("-y names")   xtitle("Decade") 


graph export ../figures/ynames_feudalism_step4.pdf, replace



local drvar = "relative_rep_top20_dr"
local lawvar = "relative_rep_top20_law"
local officervar = "relative_rep_top20_officers"
local repvar = "relative_rep_top20_reps"
local busvar = "relative_rep_top20_bus"


twoway  (scatter relrep_top20_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(scatter `drvar' year if y10<1870&t==1, mcolor(white) ) ///
,  text(0.08 1767 "1767", place(c) size(small)) text(0.2 1875 "1895", place(c) size(small)) ///  
  text(0.04 1767 "(2.3%)", place(c) size(small)) text(0.16 1875 "(4%)", place(c) size(small)) ///  
legend(order(1 "Land owned" ) pos(6) ) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 .2 .4 .6 .8 1 ) ///
ytitle("Relative representation") title("Top20 names")   xtitle("Decade") 

graph export ../figures/top20_feudalism_step1.pdf, replace


twoway  (scatter relrep_top20_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(scatter `drvar' year if y10<1870&t==1, mcolor(white) ) ///
	(scatter `repvar' year if year<1868, `mps' msize(large) ) ///
				(lfit `repvar' year if year<1868&year!=1848, `mps' msize(large) lpattern(dash) ) ///
,  text(0.08 1767 "1767", place(c) size(small)) text(0.2 1875 "1895", place(c) size(small)) ///  
  text(0.04 1767 "(2.3%)", place(c) size(small)) text(0.16 1875 "(4%)", place(c) size(small)) ///  
  text(.7 1848 "Revolutionary Diet", place(c) size(small)) ///
legend(order(1 "Land owned" 3 "Members of Diet"  ) pos(6) row(1) ) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 .2 .4 .6 .8 1 ) ///
ytitle("Relative representation") title("Top20 names")   xtitle("Decade") 

graph export ../figures/top20_feudalism_step2.pdf, replace

twoway  (scatter relrep_top20_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(scatter `drvar' year if y10<1870&t==1, mcolor(white) ) ///
	(scatter `repvar' year if year<1868, `mps' msize(large) ) ///
				(lfit `repvar' year if year<1868&year!=1848, `mps' msize(large) lpattern(dash) ) ///
				(connected `drvar' year if y10<1880&t==1, `doctors' ) ///
													(lfit `drvar' year if year<1868, `doctors' lpattern(dash) msize(large) ) ///
,  text(0.08 1767 "1767", place(c) size(small)) text(0.2 1875 "1895", place(c) size(small)) ///  
  text(0.04 1767 "(2.3%)", place(c) size(small)) text(0.16 1875 "(4%)", place(c) size(small)) ///  
  text(.7 1848 "Revolutionary Diet", place(c) size(small)) ///
legend(order(1 "Land owned" 3  "Members of Diet" 5 "Medical students") pos(6) row(1) col(3)) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 .2 .4 .6 .8 1 ) ///
ytitle("Relative representation") title("Top20 names")   xtitle("Decade") 

graph export ../figures/top20_feudalism_step3.pdf, replace

twoway  (scatter relrep_top20_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(scatter `drvar' year if y10<1870&t==1, mcolor(white) ) ///
	(scatter `repvar' year if year<1868, `mps' msize(large) ) ///
				(lfit `repvar' year if year<1868&year!=1848, `mps' msize(large) lpattern(dash) ) ///
				(connected `drvar' year if y10<1880&t==1, `doctors' ) ///
													(lfit `drvar' year if year<1868, `doctors' lpattern(dash) msize(large) ) ///
																	(connected `officervar' y10 if y10<1870&t==1, `officers' ) ///
,  text(0.08 1767 "1767", place(c) size(small)) text(0.2 1875 "1895", place(c) size(small)) ///  
  text(0.04 1767 "(2.3%)", place(c) size(small)) text(0.16 1875 "(4%)", place(c) size(small)) ///  
  text(.7 1848 "Revolutionary Diet", place(c) size(small)) ///
legend(order(1 "Land owned" 3  "Members of Diet" 5 "Medical students" 7 "Army Officers" ) pos(6) row(1) col(4)) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 .2 .4 .6 .8 1 ) ///
ytitle("Relative representation") title("Top20 names")   xtitle("Decade") 

graph export ../figures/top20_feudalism_step4.pdf, replace

*/

* Create generation-year variable if not present

twoway  (scatter relrep_noble_land y10 if y10<1880, mcolor(red) msymbol(X) msize(huge) ) /// 
	(connected `drvar' year if y10<1870&t==1, `doctors' ) ///
					(scatter `repvar' year if year<1868, `mps' msize(large) ) ///
				(connected `officervar' y10 if y10<1870&t==1, `officers' ) ///
				(lfit `repvar' year if year<1868&year!=1848, `mps' msize(large) lpattern(dash) ) ///
								(lfit `drvar' year if year<1868, `doctors' lpattern(dash) msize(large) ) ///
,  text(9 1767 "1767", place(c) size(small)) text(4.5 1875 "1895", place(c) size(small)) ///  
  text(8.4 1767 "(52%)", place(c) size(small)) text(3.9 1875 "(18%)", place(c) size(small)) ///  
 text(1.2 1848 "Revolutionary Diet", place(c) size(small)) ///
legend(order(1 "Land owned" 2 "Medical students" 3 "Members of Diet" 4 "Army Officers") pos(6) row(1) ) ///
xlabel(1765 " " 1770 "1770" 1780 "80" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70" 1880 " ") ylabel(0 2 4 6 8 10 12)  ///
ytitle("Relative representation") title("-y names")   xtitle("Decade") 



* Fill in UK_oxbridge (Series A from Figure 1)
gen UK_oxbridge = .
replace UK_oxbridge = 18   if y10 == 1805
replace UK_oxbridge = 12   if y10 == 1835
replace UK_oxbridge = 8    if y10 == 1865
replace UK_oxbridge = 5    if y10 == 1895
replace UK_oxbridge = 3.5  if y10 == 1925
replace UK_oxbridge = 2    if y10 == 1955
replace UK_oxbridge = 1.5  if y10 == 1985
replace UK_oxbridge = 1.3  if y10 == 2015

* Fill in UK_MP (Series B from Figure 2)
gen UK_MP = .
replace UK_MP = 16   if y10 == 1835
replace UK_MP = 12   if y10 == 1865
replace UK_MP = 9    if y10 == 1895
replace UK_MP = 6    if y10 == 1925
replace UK_MP = 3.5  if y10 == 1955
replace UK_MP = 3    if y10 == 1985
replace UK_MP = 2    if y10 == 2015

gen log_UK_MP = log(UK_MP)
gen log_UK_oxbridge = log(UK_oxbridge)
