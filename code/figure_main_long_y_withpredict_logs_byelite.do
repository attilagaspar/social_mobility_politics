clear
use  "$intermediate_data_dir/anal_doctor_y10_assumption_to18"
merge 1:1 y10 using  "$intermediate_data_dir/anal_law_y10_assumption", gen(merge_law)
merge 1:1 y10 using  "$intermediate_data_dir/anal_officers_y10_assumption", gen(merge_army)
merge 1:1 y10 using  "$intermediate_data_dir/relprep_y10.dta", gen(merge_business)
merge 1:1 y10 using  "$intermediate_data_dir/anal_reps_y10_assumption_to18.dta", gen(merge_reps)


replace y10 = y10+5
keep if y10<=2020&y10>1780

local doctors = "lcolor(black) lwidth(thick) msymbol(diamond) mcolor(black) lpattern(solid)"
local lawyers = "lcolor(red) lwidth(thick) msymbol(diamond) mcolor(red) lpattern(solid)"
local business = "lcolor(blue) lwidth(thick) msymbol(diamond) mcolor(blue) lpattern(solid)"
local mps = "lcolor(gold) lwidth(thick) msymbol(diamond) mcolor(gold) lpattern(solid)"
local officers = "lcolor(lime) lwidth(thick) msymbol(diamond) mcolor(lime) lpattern(solid)"

local line_shade = 20
local marker_shade = 10

local doctors_pred = "lcolor(black%`line_shade') lwidth(thick) msymbol(diamond) mcolor(black%`marker_shade') lpattern(solid)"
local lawyers_pred = "lcolor(red%`line_shade') lwidth(thick) msymbol(diamond) mcolor(red%`marker_shade') lpattern(solid)"
local business_pred = "lcolor(blue%`line_shade') lwidth(thick) msymbol(diamond) mcolor(blue%`marker_shade') lpattern(solid)"
local mps_pred = "lcolor(gold%`line_shade') lwidth(thick) msymbol(diamond) mcolor(gold%`marker_shade') lpattern(solid)"
local officers_pred = "lcolor(lime%`line_shade') lwidth(thick) msymbol(diamond) mcolor(lime%`marker_shade') lpattern(solid)"


/*
local drvar = "relative_rep_noble_dr"
local lawvar = "relative_rep_noble_law"
local officervar = "relative_rep_noble_officers"
local repvar = "relative_rep_noble_reps"
local busvar = "relative_rep_noble_bus"
*/

foreach v of varlist relative_rep_noble_dr ///
relative_rep_noble_law ///
relative_rep_noble_officers ///
relative_rep_noble_reps ///
relative_rep_noble_bus {
	
	gen log_`v' = log(`v')
	
}

local drvar = "log_relative_rep_noble_dr"
local lawvar = "log_relative_rep_noble_law"
local officervar = "log_relative_rep_noble_officers"
local repvar = "log_relative_rep_noble_reps"
local busvar = "log_relative_rep_noble_bus"


/*

twoway 	(lfit `drvar' y10 if y10<1925&y10>=1870, `doctors_pred' range(1870 1940) ) ///
        (lfit `lawvar'  y10 if y10<1925&y10>=1870, `lawyers_pred'  range(1870 1990)) ///
        (lfit `busvar' y10 if y10<1925&y10>=1870, `business_pred' range(1870 2010)) ///
        (lfit `repvar' y10 if y10<1925&y10>=1870, `mps_pred' range(1870 2020)) ///
		(lfit `officervar' y10 if y10<1925&y10>=1870, `officers_pred' range(1870 1990) ) ///
		(connected `drvar' y10 if y10<1925&y10>=1870, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925&y10>=1870, `lawyers'  ) ///
        (connected `busvar' y10 if y10<1925&y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
,     text(-.69 1895 "Austria-Hungary", place(c) size(small)) text(-0.54 1933 "Horthy", place(c) size(small)) text(-.69 1933 "regency", place(c) size(small)) ///
    text(-.69 1967 "Communism", place(c) size(small)) text(-.69 2005 "3rd Republic", place(c) size(small)) ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
 xline(1919 1944 1989)

graph export ../figures/ynames_stepwise_1.pdf, replace
graph export ../figures/ynames_stepwise_1.png, replace

twoway 	(lfit `drvar' y10 if y10<1925&y10>=1870, `doctors_pred' range(1870 1940) ) ///
        (lfit `lawvar'  y10 if y10<1925&y10>=1870, `lawyers_pred'  range(1870 1990)) ///
        (lfit `busvar' y10 if y10<1925&y10>=1870, `business_pred' range(1870 2010)) ///
        (lfit `repvar' y10 if y10<1925&y10>=1870, `mps_pred' range(1870 2020)) ///
		(lfit `officervar' y10 if y10<1925&y10>=1870, `officers_pred' range(1870 1990) ) ///
		(connected `drvar' y10 if y10>=1870, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925&y10>=1870, `lawyers'  ) ///
        (connected `busvar' y10 if y10<1925&y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
,     text(-.69 1895 "Austria-Hungary", place(c) size(small)) text(-0.54 1933 "Horthy", place(c) size(small)) text(-.69 1933 "regency", place(c) size(small)) ///
    text(-.69 1967 "Communism", place(c) size(small)) text(-.69 2005 "3rd Republic", place(c) size(small)) ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
 xline(1919 1944 1989)

 graph export ../figures/ynames_stepwise_2.pdf, replace
graph export ../figures/ynames_stepwise_2.png, replace
 
twoway 	(lfit `drvar' y10 if y10<1925&y10>=1870, `doctors_pred' range(1870 1940) ) ///
        (lfit `lawvar'  y10 if y10<1925&y10>=1870, `lawyers_pred'  range(1870 1990)) ///
        (lfit `busvar' y10 if y10<1925&y10>=1870, `business_pred' range(1870 2010)) ///
        (lfit `repvar' y10 if y10<1925&y10>=1870, `mps_pred' range(1870 2020)) ///
		(lfit `officervar' y10 if y10<1925&y10>=1870, `officers_pred' range(1870 1990) ) ///
		(connected `drvar' y10 if y10>=1870, `doctors_pred' ) ///
        (connected `lawvar'  y10 if y10>=1870, `lawyers'  ) ///
        (connected `busvar' y10 if y10<1925&y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
,     text(-.69 1895 "Austria-Hungary", place(c) size(small)) text(-0.54 1933 "Horthy", place(c) size(small)) text(-.69 1933 "regency", place(c) size(small)) ///
    text(-.69 1967 "Communism", place(c) size(small)) text(-.69 2005 "3rd Republic", place(c) size(small)) ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
 xline(1919 1944 1989)

graph export ../figures/ynames_stepwise_3.pdf, replace
graph export ../figures/ynames_stepwise_3.png, replace
  
twoway 	(lfit `drvar' y10 if y10<1925&y10>=1870, `doctors_pred' range(1870 1940) ) ///
        (lfit `lawvar'  y10 if y10<1925&y10>=1870, `lawyers_pred'  range(1870 1990)) ///
        (lfit `busvar' y10 if y10<1925&y10>=1870, `business_pred' range(1870 2010)) ///
        (lfit `repvar' y10 if y10<1925&y10>=1870, `mps_pred' range(1870 2020)) ///
		(lfit `officervar' y10 if y10<1925&y10>=1870, `officers_pred' range(1870 1990) ) ///
		(connected `drvar' y10 if y10>=1870, `doctors_pred' ) ///
        (connected `lawvar'  y10 if y10>=1870, `lawyers_pred'  ) ///
        (connected `busvar' y10 if y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
,     text(-.69 1895 "Austria-Hungary", place(c) size(small)) text(-0.54 1933 "Horthy", place(c) size(small)) text(-.69 1933 "regency", place(c) size(small)) ///
    text(-.69 1967 "Communism", place(c) size(small)) text(-.69 2005 "3rd Republic", place(c) size(small)) ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
 xline(1919 1944 1989)

graph export ../figures/ynames_stepwise_4.pdf, replace
graph export ../figures/ynames_stepwise_4.png, replace
   
twoway 	(lfit `drvar' y10 if y10<1925&y10>=1870, `doctors_pred' range(1870 1940) ) ///
        (lfit `lawvar'  y10 if y10<1925&y10>=1870, `lawyers_pred'  range(1870 1990)) ///
        (lfit `busvar' y10 if y10<1925&y10>=1870, `business_pred' range(1870 2010)) ///
        (lfit `repvar' y10 if y10<1925&y10>=1870, `mps_pred' range(1870 2020)) ///
		(lfit `officervar' y10 if y10<1925&y10>=1870, `officers_pred' range(1870 1990) ) ///
		(connected `drvar' y10 if y10>=1870, `doctors_pred' ) ///
        (connected `lawvar'  y10 if y10>=1870, `lawyers_pred'  ) ///
        (connected `busvar' y10 if y10>=1870, `business_pred' ) ///
        (connected `repvar' y10 if y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
,     text(-.69 1895 "Austria-Hungary", place(c) size(small)) text(-0.54 1933 "Horthy", place(c) size(small)) text(-.69 1933 "regency", place(c) size(small)) ///
    text(-.69 1967 "Communism", place(c) size(small)) text(-.69 2005 "3rd Republic", place(c) size(small)) ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
 xline(1919 1944 1989)

 
 graph export ../figures/ynames_stepwise_5.pdf, replace
graph export ../figures/ynames_stepwise_5.png, replace

twoway 	(lfit `drvar' y10 if y10<1925&y10>=1870, `doctors_pred' range(1870 1940) ) ///
        (lfit `lawvar'  y10 if y10<1925&y10>=1870, `lawyers_pred'  range(1870 1990)) ///
        (lfit `busvar' y10 if y10<1925&y10>=1870, `business_pred' range(1870 2010)) ///
        (lfit `repvar' y10 if y10<1925&y10>=1870, `mps_pred' range(1870 2020)) ///
		(lfit `officervar' y10 if y10<1925&y10>=1870, `officers_pred' range(1870 1990) ) ///
		(connected `drvar' y10 if y10>=1870, `doctors_pred' ) ///
        (connected `lawvar'  y10 if y10>=1870, `lawyers_pred'  ) ///
        (connected `busvar' y10 if y10>=1870, `business_pred' ) ///
        (connected `repvar' y10 if y10>=1870, `mps_pred' ) ///
		(connected `officervar' y10 if y10>=1870, `officers' ) ///
,     text(-.69 1895 "Austria-Hungary", place(c) size(small)) text(-0.54 1933 "Horthy", place(c) size(small)) text(-.69 1933 "regency", place(c) size(small)) ///
    text(-.69 1967 "Communism", place(c) size(small)) text(-.69 2005 "3rd Republic", place(c) size(small)) ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
 xline(1919 1944 1989)

graph export ../figures/ynames_stepwise_6.pdf, replace
graph export ../figures/ynames_stepwise_6.png, replace
 */


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


local doctors_pred = "lcolor(blue) lwidth(thick) msymbol(diamond) mcolor(blue) lpattern(solid)"
local mps_pred = "lcolor(red) lwidth(thick) msymbol(diamond) mcolor(red) lpattern(solid)"


twoway 	(connected log_UK_oxbridge y10  , `doctors_pred'  ) ///
        (connected log_UK_MP y10 , `mps_pred' ) ///
		,   ///
legend(order(1 "Oxbridge students" 2 "British MPs"  ) pos(6) row(1) col(2)) ///
xlabel(1780 "1780" 1790 "90"  1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60" 1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("Eliteness of rare British surnames (Clark et al. 2015)") xtitle("Decade") 
 
graph export ../figures/uk.pdf, replace


twoway 	(connected log_UK_oxbridge y10  , `doctors_pred'  ) ///
        (connected log_UK_MP y10 , `mps_pred' ) ///
		(connected `drvar' y10 , `doctors' ) ///
        (connected `repvar' y10 , `mps' ) ///
		,     text(-.69 1825 "Habsburg Empire", place(c) size(small))  ///
   text(-.69 1895 "Austria-Hungary", place(c) size(small)) text(-0.54 1933 "Horthy", place(c) size(small)) text(-.69 1933 "regency", place(c) size(small)) ///
    text(-.69 1967 "Communism", place(c) size(small)) text(-.69 2005 "3rd Republic", place(c) size(small)) ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Oxbridge students" 2 "British MPs" 3 "Hungarian medical students" 4 "Hungarian MPs" ) pos(6) row(1) col(4)) ///
xlabel(1780 "1780" 1790 "90"  1800 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60" 1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(-.68 " " -.69 "0.5" 0"1" .69 "2" 1.39 "4" 2.08 "8" 2.77 "16")  ///
ytitle("Relative representation" "(log scale)") title("Eliteness of rare British surnames (UK) vs -y names (HU)")  xtitle("Decade") ///
 xline(1867 1919 1944 1989)
 
 
graph export ../figures/uk_vs_hun.pdf, replace
