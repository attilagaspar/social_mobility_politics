/*

	generate name origin data

*/

use "../../deny_thy_father/data/macse_all_case_1870_1932.dta", clear

gen lastname = famname_new
gen year = year_change
cd social_mobility_long20
cd code
do create_name_groups.do
gen y10 = floor(year/10)*10
binscatterhist top20 endsi y10 , discrete linetype(connect) xline(1898) xtitle("Decade") legend(pos(6) order(1 "Top20" 2 "i")) ytitle("Top20 (blue) and ..i ending (red) share in new names") hist(y10)   xhistbarheight(1000) 
graph export ../figures/top20_in_changers.png, replace






hist year, freq yline(5000 10000 15000 20000) ylabel(0 5000 "5000" 10000 "10000" 15000 "15000" 20000 "20000") xtitle("Approved name changes (153k cases in total)")