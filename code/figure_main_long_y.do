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
local business = "lcolor(ltblue) lwidth(thick) msymbol(diamond) mcolor(ltblue) lpattern(solid)"
local mps = "lcolor(gold) lwidth(thick) msymbol(diamond) mcolor(gold) lpattern(solid)"
local officers = "lcolor(lime) lwidth(thick) msymbol(diamond) mcolor(lime) lpattern(solid)"

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

local drvar = "relative_rep_noble_dr"
local lawvar = "relative_rep_noble_law"
local officervar = "relative_rep_noble_officers"
local repvar = "relative_rep_noble_reps"
local busvar = "relative_rep_noble_bus"



* HABSBURG
twoway 	(connected `drvar' y10 if y10<1870, `doctors' ) ///
					(connected `repvar' y10 if y10==1855|y10==1865, `mps' ) ///
			(connected `repvar' y10 if y10==1845, `mps' ) ///
			    (connected `repvar' y10 if y10<1840, `mps' ) ///
				(connected `officervar' y10 if y10<1870, `officers' ) ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.9 1933 "Horthy", place(c) size(small)) text(0.5 1933 "regency", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
	    text(0.5 1830 "Habsburg Empire", place(c) size(small))  ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(1780 "1780" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
xline(1867 1919 1944 1989)


graph export `1'_step1.pdf, replace
graph export `1'_step1.png, replace



* AUSTRIA-HUNGARY
twoway 	(connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925&y10>=1870, `lawyers'  ) ///
        (connected `busvar' y10 if y10<1925&y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
					(connected `drvar' y10 if y10==1855|y10==1865, `doctors' ) ///
					(connected `repvar' y10 if y10==1855|y10==1865, `mps' ) ///
			(connected `drvar' y10 if y10==1845, `doctors' ) ///
			(connected `repvar' y10 if y10==1845, `mps' ) ///
				(connected `drvar' y10 if y10<1840, `doctors' ) ///
			    (connected `repvar' y10 if y10<1840, `mps' ) ///
				(connected `officervar' y10 if y10<1870, `officers' ) ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.9 1933 "Horthy", place(c) size(small)) text(0.5 1933 "regency", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
	    text(0.5 1830 "Habsburg Empire", place(c) size(small))  ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(1780 "1780" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
xline(1867 1919 1944 1989)


graph export `1'_step2.pdf, replace
graph export `1'_step2.png, replace


* HORTHY


twoway 	(connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925&y10>=1870, `lawyers'  ) ///
        (connected `busvar' y10 if y10<1925&y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
					(connected `drvar' y10 if y10==1855|y10==1865, `doctors' ) ///
					(connected `repvar' y10 if y10==1855|y10==1865, `mps' ) ///
			(connected `drvar' y10 if y10==1845, `doctors' ) ///
			(connected `repvar' y10 if y10==1845, `mps' ) ///
				(connected `drvar' y10 if y10<1840, `doctors' ) ///
			    (connected `repvar' y10 if y10<1840, `mps' ) ///
				(connected `officervar' y10 if y10<1870, `officers' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected `busvar' y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected `repvar' y10  if y10==1925|y10==1935, `mps') ///
					(connected `officervar' y10 if y10==1925|y10==1935, `officers' ) ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.9 1933 "Horthy", place(c) size(small)) text(0.5 1933 "regency", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
	    text(0.5 1830 "Habsburg Empire", place(c) size(small))  ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(1780 "1780" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
xline(1867 1919 1944 1989)



graph export `1'_step3.pdf, replace
graph export `1'_step3.png, replace

* COMMUNISM



twoway 	(connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925&y10>=1870, `lawyers'  ) ///
        (connected `busvar' y10 if y10<1925&y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
					(connected `drvar' y10 if y10==1855|y10==1865, `doctors' ) ///
					(connected `repvar' y10 if y10==1855|y10==1865, `mps' ) ///
			(connected `drvar' y10 if y10==1845, `doctors' ) ///
			(connected `repvar' y10 if y10==1845, `mps' ) ///
				(connected `drvar' y10 if y10<1840, `doctors' ) ///
			    (connected `repvar' y10 if y10<1840, `mps' ) ///
				(connected `officervar' y10 if y10<1870, `officers' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected `busvar' y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected `repvar' y10  if y10==1925|y10==1935, `mps') ///
					(connected `officervar' y10 if y10==1925|y10==1935, `officers' ) ///
        (scatter `repvar' y10 if y10==1945, `mps') ///
        (connected `drvar' y10 if y10>1945&y10<1995, `doctors') ///
        (connected `lawvar'  y10  if y10>1945&y10<1995, `lawyers' ) ///
        (connected `busvar' y10  if y10>1945&y10<1995, `business') ///
        (connected `repvar' y10  if y10>1945&y10<1995, `mps') ///
				(connected `officervar' y10 if  y10>1945&y10<1995, `officers' ) ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.9 1933 "Horthy", place(c) size(small)) text(0.5 1933 "regency", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
	    text(0.5 1830 "Habsburg Empire", place(c) size(small))  ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(1780 "1780" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
xline(1867 1919 1944 1989)


graph export `1'_step4.pdf, replace
graph export `1'_step4.png, replace

***************

twoway 	(connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925&y10>=1870, `lawyers'  ) ///
        (connected `busvar' y10 if y10<1925&y10>=1870, `business' ) ///
        (connected `repvar' y10 if y10<1925&y10>=1870, `mps' ) ///
		(connected `officervar' y10 if y10<1925&y10>=1870, `officers' ) ///
					(connected `drvar' y10 if y10==1855|y10==1865, `doctors' ) ///
					(connected `repvar' y10 if y10==1855|y10==1865, `mps' ) ///
			(connected `drvar' y10 if y10==1845, `doctors' ) ///
			(connected `repvar' y10 if y10==1845, `mps' ) ///
				(connected `drvar' y10 if y10<1840, `doctors' ) ///
			    (connected `repvar' y10 if y10<1840, `mps' ) ///
				(connected `officervar' y10 if y10<1870, `officers' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected `busvar' y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected `repvar' y10  if y10==1925|y10==1935, `mps') ///
					(connected `officervar' y10 if y10==1925|y10==1935, `officers' ) ///
        (scatter `repvar' y10 if y10==1945, `mps') ///
        (connected `drvar' y10 if y10>1945&y10<1995, `doctors') ///
        (connected `lawvar'  y10  if y10>1945&y10<1995, `lawyers' ) ///
        (connected `busvar' y10  if y10>1945&y10<1995, `business') ///
        (connected `repvar' y10  if y10>1945&y10<1995, `mps') ///
				(connected `officervar' y10 if  y10>1945&y10<1995, `officers' ) ///
        (connected `drvar' y10 if y10>=1995, `doctors') ///
        (connected `lawvar'  y10  if y10>=1995, `lawyers' ) ///
        (connected `busvar' y10  if y10>=1995, `business') ///
        (connected `repvar' y10  if y10>=1995, `mps') ///
					(connected `officervar' y10 if y10>=1995, `officers' ) ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.9 1933 "Horthy", place(c) size(small)) text(0.5 1933 "regency", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
	    text(0.5 1830 "Habsburg Empire", place(c) size(small))  ///
	text(9 1865 "Absolutism", place(c) size(small)) text(4.5 1845 "Revolution", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament" 5 "Army Officers") pos(6) row(2) col(3)) ///
xlabel(1780 "1780" 1790 "90" 1800 "1800" 1810 "10" 1820 "20" 1830 "30" 1840 "40" 1850 "50" 1860 "60"   1870 "70"  1880 "80"  1890 "90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade") ///
xline(1867 1919 1944 1989)


graph export `1'.pdf, replace
graph export `1'.png, replace

