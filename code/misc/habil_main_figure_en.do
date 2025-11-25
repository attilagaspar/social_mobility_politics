clear

use "../../social mobility (1)/data/final_data/anal_doctor_y10_assumption


merge 1:1 y10 using  "../../social mobility (1)/data/final_data/anal_law_y10_assumption", gen(merge_law)
merge 1:1 y10 using  "../../social mobility (1)/data/final_data/anal_officers_y10_assumption", gen(merge_army)
merge 1:1 y10 using  "../data/processed/relprep_y10.dta", gen(merge_business)
merge 1:1 y10 using  "../../social mobility (1)/data/final_data/anal_reps_y10_assumption", gen(merge_reps)


replace y10 = y10+5
keep if y10>=1870&y10<=2020

local doctors = "lcolor(black) lwidth(thick) msymbol(diamond) mcolor(black) lpattern(solid)"
local lawyers = "lcolor(red) lwidth(thick) msymbol(diamond) mcolor(red) lpattern(solid)"
local business = "lcolor(ltblue) lwidth(thick) msymbol(diamond) mcolor(ltblue) lpattern(solid)"
local mps = "lcolor(lime) lwidth(thick) msymbol(diamond) mcolor(lime) lpattern(solid)"

local drvar = "relative_rep_noble_dr"
local lawvar = "relative_rep_noble_law"

twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_noble_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_noble_reps y10 if y10<1925, `mps' ) ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.5 1933 "Horthy regime", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 2 4 6 8 10) ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade") 

graph export ../figures/habil_ynames1_en.pdf, replace
graph export ../figures/habil_ynames1_en.png, replace




twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_noble_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_noble_reps y10 if y10<1925, `mps' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected relative_rep_noble_bus y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected relative_rep_noble_reps y10  if y10==1925|y10==1935, `mps') ///
        (scatter relative_rep_noble_reps y10 if y10==1945, msymbol(diamond) mcolor(lime)) ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.5 1933 "Horthy regime", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20")  ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade")


graph export ../figures/habil_ynames2_en.pdf, replace
graph export ../figures/habil_ynames2_en.png, replace

twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_noble_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_noble_reps y10 if y10<1925, `mps' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected relative_rep_noble_bus y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected relative_rep_noble_reps y10  if y10==1925|y10==1935, `mps') ///
        (scatter relative_rep_noble_reps y10 if y10==1945, msymbol(diamond) mcolor(lime)) ///
        (connected `drvar' y10 if y10>1945&y10<1995, `doctors') ///
        (connected `lawvar'  y10  if y10>1945&y10<1995, `lawyers' ) ///
        (connected relative_rep_noble_bus y10  if y10>1945&y10<1995, `business') ///
        (connected relative_rep_noble_reps y10  if y10>1945&y10<1995, `mps') ///
        ,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.5 1933 "Horthy regime", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 2 4 6 8 10)  ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade")


graph export ../figures/habil_ynames3_en.pdf, replace
graph export ../figures/habil_ynames3_en.png, replace


twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_noble_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_noble_reps y10 if y10<1925, `mps' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected relative_rep_noble_bus y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected relative_rep_noble_reps y10  if y10==1925|y10==1935, `mps') ///
        (scatter relative_rep_noble_reps y10 if y10==1945, msymbol(diamond) mcolor(lime)) ///
        (connected `drvar' y10 if y10>1945&y10<1995, `doctors') ///
        (connected `lawvar'  y10  if y10>1945&y10<1995, `lawyers' ) ///
        (connected relative_rep_noble_bus y10  if y10>1945&y10<1995, `business') ///
        (connected relative_rep_noble_reps y10  if y10>1945&y10<1995, `mps') ///
        (connected `drvar' y10 if y10>=1995, `doctors') ///
        (connected `lawvar'  y10  if y10>=1995, `lawyers' ) ///
        (connected relative_rep_noble_bus y10  if y10>=1995, `business') ///
        (connected relative_rep_noble_reps y10  if y10>=1995, `mps') ///
,     text(0.5 1895 "Austria-Hungary", place(c) size(small)) text(0.5 1933 "Horthy regime", place(c) size(small)) ///
    text(0.5 1967 "Communism", place(c) size(small)) text(0.5 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ///
ytitle("Relative representation") title("-y names") subtitle("Decade averages")  xtitle("Decade")

graph export ../figures/habil_ynames_en.pdf, replace
graph export ../figures/habil_ynames_en.png, replace


local drvar = "relative_rep_top20_dr"
local lawvar = "relative_rep_top20_law"



twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_top20_hun_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_top20_reps y10 if y10<1925, `mps' ) ///
,     text(0 1895 "Austria-Hungary", place(c) size(small)) text(0 1933 "Horthy regime", place(c) size(small)) ///
    text(0 1967 "Communism", place(c) size(small)) text(0 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 .2 .4 .6 .8 1) ///
ytitle("Relative representation") title("Top20 most frequent names") subtitle("Decade averages")  xtitle("Decade")

graph export ../figures/habil_top20_1_en.pdf, replace
graph export ../figures/habil_top20_1_en.png, replace
        

twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_top20_hun_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_top20_reps y10 if y10<1925, `mps' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected relative_rep_top20_hun_bus y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected relative_rep_top20_reps y10  if y10==1925|y10==1935, `mps') ///
        (scatter relative_rep_top20_reps y10 if y10==1945, msymbol(diamond) mcolor(lime)) ///
,     text(0 1895 "Austria-Hungary", place(c) size(small)) text(0 1933 "Horthy regime", place(c) size(small)) ///
    text(0 1967 "Communism", place(c) size(small)) text(0 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 .2 .4 .6 .8 1) ///
ytitle("Relative representation") title("Top20 most frequent names") subtitle("Decade averages")  xtitle("Decade")

graph export ../figures/habil_top20_2_en.pdf, replace
graph export ../figures/habil_top20_2_en.png, replace
        

twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_top20_hun_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_top20_reps y10 if y10<1925, `mps' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected relative_rep_top20_hun_bus y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected relative_rep_top20_reps y10  if y10==1925|y10==1935, `mps') ///
        (scatter relative_rep_top20_reps y10 if y10==1945, msymbol(diamond) mcolor(lime)) ///
        (connected `drvar' y10 if y10>1945&y10<1995, `doctors') ///
        (connected `lawvar'  y10  if y10>1945&y10<1995, `lawyers' ) ///
        (connected relative_rep_top20_hun_bus y10  if y10>1945&y10<1995, `business') ///
        (connected relative_rep_top20_reps y10  if y10>1945&y10<1995, `mps') ///
,     text(0 1895 "Austria-Hungary", place(c) size(small)) text(0 1933 "Horthy regime", place(c) size(small)) ///
    text(0 1967 "Communism", place(c) size(small)) text(0 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 .2 .4 .6 .8 1) ///
ytitle("Relative representation") title("Top20 most frequent names") subtitle("Decade averages")  xtitle("Decade")


graph export ../figures/habil_top20_3_en.pdf, replace
graph export ../figures/habil_top20_3_en.png, replace


twoway (connected `drvar' y10 if y10<1925, `doctors' ) ///
        (connected `lawvar'  y10 if y10<1925, `lawyers'  ) ///
        (connected relative_rep_top20_hun_bus y10 if y10<1925, `business' ) ///
            (connected relative_rep_top20_reps y10 if y10<1925, `mps' ) ///
(connected `drvar' y10 if y10==1925|y10==1935|y10==1945 , `doctors') ///
        (connected `lawvar'  y10  if y10==1925|y10==1935|y10==1945, `lawyers' ) ///
        (connected relative_rep_top20_hun_bus y10  if y10==1925|y10==1935|y10==1945, `business') ///
        (connected relative_rep_top20_reps y10  if y10==1925|y10==1935, `mps') ///
        (scatter relative_rep_top20_reps y10 if y10==1945, msymbol(diamond) mcolor(lime)) ///
        (connected `drvar' y10 if y10>1945&y10<1995, `doctors') ///
        (connected `lawvar'  y10  if y10>1945&y10<1995, `lawyers' ) ///
        (connected relative_rep_top20_hun_bus y10  if y10>1945&y10<1995, `business') ///
        (connected relative_rep_top20_reps y10  if y10>1945&y10<1995, `mps') ///
        (connected `drvar' y10 if y10>=1995, `doctors') ///
        (connected `lawvar'  y10  if y10>=1995, `lawyers' ) ///
        (connected relative_rep_top20_hun_bus y10  if y10>=1995, `business') ///
        (connected relative_rep_top20_reps y10  if y10>=1995, `mps') ///
,     text(0 1895 "Austria-Hungary", place(c) size(small)) text(0 1933 "Horthy regime", place(c) size(small)) ///
    text(0 1967 "Communism", place(c) size(small)) text(0 2005 "3rd Republic", place(c) size(small)) ///
legend(order(1 "Medical students" 2 "Law students" 3 "Chief Executives" 4 "Members of Parliament") pos(6) row(2) col(2)) ///
xlabel(  1870 "1870"  1880 "80"  1890 "s90" ///
1900 "1900" 1910 "10" 1920 "20" 1930 "30" 1940 "40"  1950 "50"  1960 "60"  1970 "70"  1980 "80"  1990 "90" ///
2000 "2000" 2010 "10" 2020 "20") ylabel(0 .2 .4 .6 .8 1) ///
ytitle("Relative representation") title("Top20 most frequent names") subtitle("Decade averages")  xtitle("Decade")

graph export ../figures/habil_top20_en.pdf, replace
graph export ../figures/habil_top20_en.png, replace
