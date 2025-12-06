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