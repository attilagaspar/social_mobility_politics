


use "$intermediate_data_dir/anal_doctor_periods_assumption_to18.dta", clear


merge 1:1 periods using  "$intermediate_data_dir/anal_law_periods_assumption.dta", gen(merge_law)
merge 1:1 periods using  "$intermediate_data_dir/anal_officers_periods_assumption.dta", gen(merge_army)
merge 1:1 periods using  "$intermediate_data_dir/anal_reps_periods_assumption_to18.dta", gen(merge_reps)
merge 1:1 periods using  "$intermediate_data_dir/anal_bus_periods_assumption.dta", gen(merge_bus)
merge 1:1 periods using  "$intermediate_data_dir/anal_hschool_periods_assumption.dta", gen(merge_hs)

drop if periods == . 



label define periods -7 "1780-89" -6 "1790-99" -5 "1800-09" -4 "1810-19" -3 "1820-29" -2 "1830-39" -1 "1840-48" 0 "1849-66" 1 "1867-79" 2 "1880-89" 3 "1890-99" 4 "1900-09" 5 "1910-18" 6 "1919-33" 7 "1934-45" 8 "1946-56" 9 "1957-69" 10 "1970-80" 11 "1980-89" 12 "1990-99" 13 "2000-09" 14 "2010-18", replace
label values periods periods


* RELATIVE REPRESENTATION of Y-SURNAMES



twoway connected relative_rep_noble_dr relative_rep_noble_law relative_rep_noble_bus  periods, lcolor(black red green blue orange)  mcolor(black red green blue orange)  ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Medical students" 2 "Law students" 3 "CEOs") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45) nogrid) ylabel(0(1)10, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("-y names: average over a period", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_relrep_y_periods_part1.png, replace


twoway connected relative_rep_noble_dr relative_rep_noble_law relative_rep_noble_bus relative_rep_noble_officers relative_rep_noble_reps   periods, lcolor(black%15 red%15 green%15 blue orange)  mcolor(black%15 red%15 green%15  blue orange) ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Medical students" 2 "Law students" 3 "CEOs" 4 "Military officers" 5 "Members of Parliament") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45) nogrid) ylabel(0(1)10, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("-y names: average over a period", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_relrep_y_periods_part2.png, replace


* POPULATION SHARES



twoway connected noble_ip top20_ip commonjewishname_ip german_ip periods, lcolor(black red green blue)  mcolor(black red green blue) ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Noble Names" 2 "Top 20 Common Names" 3 "Jewish Names" 4 "German Names") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45)) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Share in population", size(vsmall)) title("Population Shares", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
*graph export ../figures/paper2_groups_ip.png, replace


twoway connected noble_ip top20_ip gerjewsla_ip periods, lcolor(black red green blue)  mcolor(black red green blue) ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Noble Names" 2 "Top 20 Common Names" 3 "German/Jewish/Slavic Names") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45)) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Share in population", size(vsmall)) title("Population Shares", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_groups_ip.png, replace


* HIGH-SCHOOL STUDENTS


twoway connected relative_rep_noble_hs relative_rep_top20_hs relative_rep_jewish_ip_hs relative_rep_german_ip_hs periods if inrange(periods,0,7), lcolor(black red green blue orange)  mcolor(black red green blue orange)  ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Noble" 2 "Top 20" 3 "Jewish" 4 "German") size(vsmall)) ///
xlabel(0(1)7,valuelabel labsize(vsmall) nogrid) ylabel(0(1)4, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("High School Graduates: average over a period", size(small)) ///
xline(6.3, lwidth(29) lc(green*0.1) lpattern(solid))  xline(2.7, lwidth(100) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
*graph export ../figures/paper2_relrep_hs_periods.png, replace


twoway connected relative_rep_noble_hs relative_rep_top20_hs relative_rep_gjs_ip_hs periods if inrange(periods,0,7), lcolor(black red green blue orange)  mcolor(black red green blue orange)  ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Noble" 2 "Top 20" 3 "German/Jewish/Slavic Names") size(vsmall)) ///
xlabel(0(1)7,valuelabel labsize(vsmall) nogrid) ylabel(0(1)4, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("High School Graduates: average over a period", size(small)) ///
xline(6.3, lwidth(29) lc(green*0.1) lpattern(solid))  xline(2.7, lwidth(100) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_relrep_hs_periods.png, replace


* RELATIVE REPRESENTATION of TOP 20


twoway connected relative_rep_top20_dr relative_rep_top20_law relative_rep_top20_bus relative_rep_top20_officers relative_rep_top20_reps  periods, lcolor(black red green blue orange)  mcolor(black red green blue orange)  ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Medical students" 2 "Law students" 3 "CEOs" 4 "Officers" 5 "Members of Parliament") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("Top 20 names: average over a period", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_relrep_top20_periods.png, replace


* RELATIVE REPRESENTATION of JEWS (incomplete list of surnames)

twoway connected relative_rep_jewish_ip_dr relative_rep_jewish_ip_law relative_rep_jewish_ip_bus relative_rep_jewish_ip_officers relative_rep_jewish_ip_reps  periods, lcolor(black red green blue orange)  mcolor(black red green blue orange)  ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Medical students" 2 "Law students" 3 "Managers" 4 "Officers" 5 "Members of Parliament") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("Jewish names: average over a period", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_relrep_Jewish_periods.png, replace


* RELATIVE REPRESENTATION of GERMANS (incomplete list of surnames)

twoway connected relative_rep_german_ip_dr relative_rep_german_ip_law relative_rep_german_ip_bus relative_rep_german_ip_officers relative_rep_german_ip_reps  periods, lcolor(black red green blue orange)  mcolor(black red green blue orange)  ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Medical students" 2 "Law students" 3 "Managers" 4 "Officers" 5 "Members of Parliament") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45) nogrid)ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("German names: average over a period", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_relrep_German_periods.png, replace


* RELATIVE REPRESENTATION of GERMANS/JEWS/SLAVS (complete list of surnames)

twoway connected relative_rep_gjs_ip_dr relative_rep_gjs_ip_law relative_rep_gjs_ip_bus relative_rep_gjs_ip_officers relative_rep_gjs_ip_reps  periods, lcolor(black red green blue orange)  mcolor(black red green blue orange)  ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Medical students" 2 "Law students" 3 "Managers" 4 "Officers" 5 "Members of Parliament") size(vsmall)) ///
xlabel(-7(1)14,valuelabel labsize(2) angle(45) nogrid)ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(vsmall)) title("German/Jewish/Slavic names: average over a period", size(small))  /// 
xline(12.85, lwidth(17) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(25) lc(red*0.1) lpattern(solid)) xline(6.3, lwidth(13) lc(green*0.1) lpattern(solid))  xline(-1, lwidth(75) lc(grey*0.1) lpattern(solid)) graphregion(color(white)) xsize(6.5)
graph export ../figures/paper2_relrep_gerjewsla_periods.png, replace



 
* Contributions 

tsset periods 

/*

}
*/

gen x=gerjewsla_ip/noble_ip if periods==3
egen pop1890_gjs=min(x)
drop x 


foreach v in dr rep law officers bus {

gen contr_y_t20_l_`v'=top20_ip/noble_ip*(1-relative_rep_top20_`v')
gen contr_y_gjs_l_`v'=gerjewsla_ip/noble_ip*(1-relative_rep_gjs_ip_`v')
gen contr_y_other_l_`v'=relative_rep_noble_`v'-contr_y_t20_l_`v'-contr_y_gjs_l_`v'-1
gen contr_y_hunnony_l_`v'=contr_y_t20_l_`v'+contr_y_other_l_`v'

gen test_`v'=1+contr_y_t20_l_`v'+contr_y_gjs_l_`v'+contr_y_other_l_`v'

gen altpop_contr_y_gjs_l_`v'=pop1890_gjs*(1-relative_rep_gjs_ip_`v')

gen alt_y_gjs_`v'=1+altpop_contr_y_gjs_l_`v'+contr_y_t20_l_`v'+contr_y_other_l_`v'
gen alt_y_noethnic_`v'=1+contr_y_t20_l_`v'+contr_y_other_l_`v'
gen alt_y_noethnicT20_`v'=1+contr_y_other_l_`v'
gen alt_y_noethnicother_`v'=1+contr_y_t20_l_`v'
gen alt_y_noT20_`v'=1+contr_y_gjs_l_`v'+contr_y_other_l_`v'
gen alt_y_noother_`v'=1+contr_y_gjs_l_`v'+contr_y_t20_l_`v'

replace alt_y_noethnic_`v'=0 if alt_y_noethnic_`v'<0
replace alt_y_noethnicT20_`v'=0 if alt_y_noethnicT20_`v'<0

gen contr_y_t20_c_`v'=D.contr_y_t20_l_`v'
gen contr_y_gjs_c_`v'=D.contr_y_gjs_l_`v'
gen contr_y_other_c_`v'=D.contr_y_other_l_`v'

gen contr_y_hunnony_c_`v'=contr_y_t20_c_`v'+contr_y_other_c_`v'

gen xxx_contr_y_t20_l_`v'=contr_y_t20_l_`v' if periods==0
gen xxx_contr_y_gjs_l_`v'=contr_y_gjs_l_`v' if periods==0
gen xxx_contr_y_other_l_`v'=contr_y_other_l_`v' if periods==0

egen yyy_contr_y_t20_l_`v'=min(xxx_contr_y_t20_l_`v')
egen yyy_contr_y_gjs_l_`v'=min(xxx_contr_y_gjs_l_`v')
egen yyy_contr_y_other_l_`v'=min(xxx_contr_y_other_l_`v')

gen contr_y_t20_bc_`v'=contr_y_t20_l_`v'-yyy_contr_y_t20_l_`v'
gen contr_y_gjs_bc_`v'=contr_y_gjs_l_`v'-yyy_contr_y_gjs_l_`v'
gen contr_y_other_bc_`v'=contr_y_other_l_`v'-yyy_contr_y_other_l_`v'

gen contr_y_hunnony_bc_`v'=contr_y_t20_bc_`v'+contr_y_other_bc_`v'

}



drop xxx_* yyy_*



graph twoway (connected relative_rep_noble_dr periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_gjs_dr periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_dr periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew/Slav fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew/Slav") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)9, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Medical Doctors", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_dr_ethnic.png, replace

graph twoway (connected relative_rep_noble_law periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_gjs_law periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_law periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew/Slav fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew/Slav") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)8, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Lawyers", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_law_ethnic.png, replace


graph twoway (connected relative_rep_noble_bus periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_gjs_bus periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_bus periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew/Slav fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew/Slav") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)7, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; CEOs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_bus_ethnic.png, replace


graph twoway (connected relative_rep_noble_rep periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_gjs_rep periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_rep periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew/Slav fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew/Slav") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)11, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; MPs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_rep_ethnic.png, replace


graph twoway (connected relative_rep_noble_officers periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_gjs_officers periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_officers periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew/Slav fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew/Slav") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)11, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Military Officers", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_officers_ethnic.png, replace





graph twoway (connected alt_y_noethnic_dr periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_dr periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_dr periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew/Slav" 2 "No dis/advantage of Germ/Jew/Slav and Top 20" 3 "No dis/advantage of Germ/Jew/Slav and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)9, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Medical Doctors", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_dr_class.png, replace


graph twoway (connected alt_y_noethnic_law periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_law periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_law periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew/Slav" 2 "No dis/advantage of Germ/Jew/Slav and Top 20" 3 "No dis/advantage of Germ/Jew/Slav and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)8, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Lawyers", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_law_class.png, replace


graph twoway (connected alt_y_noethnic_bus periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_bus periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_bus periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew/Slav" 2 "No dis/advantage of Germ/Jew/Slav and Top 20" 3 "No dis/advantage of Germ/Jew/Slav and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)7, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; CEOs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_bus_class.png, replace


graph twoway (connected alt_y_noethnic_rep periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_rep periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_rep periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew/Slav" 2 "No dis/advantage of Germ/Jew/Slav and Top 20" 3 "No dis/advantage of Germ/Jew/Slav and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)9, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; MPs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_rep_class.png, replace


graph twoway (connected alt_y_noethnic_officers periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_officers periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_officers periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew/Slav" 2 "No dis/advantage of Germ/Jew/Slav and Top 20" 3 "No dis/advantage of Germ/Jew/Slav and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)9, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Officers", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_officers_class.png, replace


****

/*

gen x=german_ip/noble_ip if periods==0
gen y=commonjewishname_ip/noble_ip if periods==0
egen pop1890_german=min(x)
egen pop1890_jewish=min(y)   // THE VARIABLES IS CALLED 1890, BUT ACTUALLY THE FIXING REFERS to "1849-66" (PERIOD = 0)
drop x y

foreach v in dr rep law officers bus {

gen contr_y_t20_l_`v'=top20_ip/noble_ip*(1-relative_rep_top20_hun_`v')
gen contr_y_german_l_`v'=german_ip/noble_ip*(1-relative_rep_german_ip_`v')
gen contr_y_jewish_l_`v'=commonjewishname_ip/noble_ip*(1-relative_rep_jewish_ip_`v')
gen contr_y_other_l_`v'=relative_rep_noble_`v'-contr_y_t20_l_`v'-contr_y_german_l_`v'-contr_y_jewish_l_`v'-1
gen contr_y_ethnic_l_`v'=contr_y_german_l_`v'+contr_y_jewish_l_`v'
gen contr_y_hunnony_l_`v'=contr_y_t20_l_`v'+contr_y_other_l_`v'

gen test_`v'=1+contr_y_t20_l_`v'+contr_y_ethnic_l_`v'+contr_y_other_l_`v'

gen altpop_contr_y_german_l_`v'=pop1890_german*(1-relative_rep_german_ip_`v')
gen altpop_contr_y_jewish_l_`v'=pop1890_jewish*(1-relative_rep_jewish_ip_`v')
gen altpop_contr_y_ethnic_l_`v'=altpop_contr_y_german_l_`v'+altpop_contr_y_jewish_l_`v'

gen alt_y_ethnicpop_`v'=1+altpop_contr_y_ethnic_l_`v'+contr_y_t20_l_`v'+contr_y_other_l_`v'
gen alt_y_noethnic_`v'=1+contr_y_t20_l_`v'+contr_y_other_l_`v'
gen alt_y_noethnicT20_`v'=1+contr_y_other_l_`v'
gen alt_y_noethnicother_`v'=1+contr_y_t20_l_`v'
gen alt_y_noT20_`v'=1+contr_y_ethnic_l_`v'+contr_y_other_l_`v'
gen alt_y_noother_`v'=1+contr_y_ethnic_l_`v'+contr_y_t20_l_`v'

replace alt_y_noethnic_`v'=0 if alt_y_noethnic_`v'<0
replace alt_y_noethnicT20_`v'=0 if alt_y_noethnicT20_`v'<0

gen contr_y_t20_c_`v'=D.contr_y_t20_l_`v'
gen contr_y_german_c_`v'=D.contr_y_german_l_`v'
gen contr_y_jewish_c_`v'=D.contr_y_jewish_l_`v'
gen contr_y_other_c_`v'=D.contr_y_other_l_`v'

gen contr_y_ethnic_c_`v'=contr_y_german_c_`v'+contr_y_jewish_c_`v'
gen contr_y_hunnony_c_`v'=contr_y_t20_c_`v'+contr_y_other_c_`v'

gen xxx_contr_y_t20_l_`v'=contr_y_t20_l_`v' if periods==3
gen xxx_contr_y_german_l_`v'=contr_y_german_l_`v' if periods==3
gen xxx_contr_y_jewish_l_`v'=contr_y_jewish_l_`v' if periods==3
gen xxx_contr_y_other_l_`v'=contr_y_other_l_`v' if periods==3

egen yyy_contr_y_t20_l_`v'=min(xxx_contr_y_t20_l_`v')
egen yyy_contr_y_german_l_`v'=min(xxx_contr_y_german_l_`v')
egen yyy_contr_y_jewish_l_`v'=min(xxx_contr_y_jewish_l_`v')
egen yyy_contr_y_other_l_`v'=min(xxx_contr_y_other_l_`v')

gen contr_y_t20_bc_`v'=contr_y_t20_l_`v'-yyy_contr_y_t20_l_`v'
gen contr_y_german_bc_`v'=contr_y_german_l_`v'-yyy_contr_y_german_l_`v'
gen contr_y_jewish_bc_`v'=contr_y_jewish_l_`v'-yyy_contr_y_jewish_l_`v'
gen contr_y_other_bc_`v'=contr_y_other_l_`v'-yyy_contr_y_other_l_`v'

gen contr_y_ethnic_bc_`v'=contr_y_german_bc_`v'+contr_y_jewish_bc_`v'
gen contr_y_hunnony_bc_`v'=contr_y_t20_bc_`v'+contr_y_other_bc_`v'

}
drop xxx_* yyy_*


graph twoway (connected relative_rep_noble_dr periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_ethnicpop_dr periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_dr periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew fixed population share 1849-66" 3 "No dis/advantage of Germ/Jew") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)10, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Medical Doctors", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_dr_ethnic.png, replace

graph twoway (connected relative_rep_noble_law periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_ethnicpop_law periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_law periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)10, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Lawyers", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_law_ethnic.png, replace


graph twoway (connected relative_rep_noble_bus periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_ethnicpop_bus periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_bus periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)7, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; CEOs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_bus_ethnic.png, replace


graph twoway (connected relative_rep_noble_rep periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_ethnicpop_rep periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_rep periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)11, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; MPs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_rep_ethnic.png, replace


graph twoway (connected relative_rep_noble_officers periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_ethnicpop_officers periods if periods>-1, lcolor(black) mcolor(black) lpattern(dash)) ///
			 (connected alt_y_noethnic_officers periods if periods>-1, lcolor(blue) mcolor(blue) lpattern(dash)), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "Actual" 2 "Germ/Jew fixed population share 1890-99" 3 "No dis/advantage of Germ/Jew") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(0(1)11, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Military Officers", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_officers_ethnic.png, replace





graph twoway (connected alt_y_noethnic_dr periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_dr periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_dr periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew" 2 "No dis/advantage of Germ/Jew and Top 20" 3 "No dis/advantage of Germ/Jew and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Medical Doctors", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_dr_class.png, replace


graph twoway (connected alt_y_noethnic_law periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_law periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_law periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew" 2 "No dis/advantage of Germ/Jew and Top 20" 3 "No dis/advantage of Germ/Jew and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; Lawyers", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_law_class.png, replace


graph twoway (connected alt_y_noethnic_bus periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_bus periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_bus periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew" 2 "No dis/advantage of Germ/Jew and Top 20" 3 "No dis/advantage of Germ/Jew and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; CEOs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_bus_class.png, replace


graph twoway (connected alt_y_noethnic_rep periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_rep periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_rep periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew" 2 "No dis/advantage of Germ/Jew and Top 20" 3 "No dis/advantage of Germ/Jew and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; MPs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_rep_class.png, replace


graph twoway (connected alt_y_noethnic_officers periods if periods>-1, lcolor(black) mcolor(black) ) ///
			 (connected alt_y_noethnicT20_officers periods if periods>-1, lcolor(red) mcolor(red) lpattern(dash)) ///
             (connected alt_y_noethnicother_officers periods if periods>-1,lcolor(green) mcolor(green) lpattern(dash) ), ///
yline(1)  legend( col(2) row(2) pos(6) order(1 "No dis/advantage of Germ/Jew" 2 "No dis/advantage of Germ/Jew and Top 20" 3 "No dis/advantage of Germ/Jew and Others") size(small)) xlabel(0(1)14,valuelabel labsize(vsmall) nogrid) ylabel(, labsize(vsmall) nogrid) ///
xtitle("") ytitle("Relative representation", size(small)) title("-y names: average over a period; MPs", size(small))  /// 
xline(12.3, lwidth(39) lc(green*0.1) lpattern(solid)) xline(9.5, lwidth(42) lc(red*0.1) lpattern(solid)) xline(6.4, lwidth(23) lc(green*0.1) lpattern(solid))  xline(2.6, lwidth(58) lc(grey*0.1) lpattern(solid)) 
graph export ../figures/paper2_counterfact_y_officers_class.png, replace

