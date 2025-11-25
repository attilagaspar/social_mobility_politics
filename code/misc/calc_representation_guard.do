


use "../../social mobility (1)/data/population_control_ipolated_to18thcentury.dta", clear
gen y10=floor(year/20)*20+10
local collapsevar = "`1'"
collapse (mean) *_ip, by(`1')

merge 1:1 `1' using "../data/processed/guard_`collapsevar'.dta" , gen (merge_guard)



tsset `1'

rename nobility_ip noble_ip

foreach s in "noble" "top20"   ///
	"endsi" "roma"  "hunref"  {

	gen relative_rep_`s' = ( `s'_share_in_guard / `s'_ip ) 

}


preserve 
	keep  `1'  relative_*	 *_share_in_*
			
	foreach v of varlist relative_*   {
			rename `v' `v'_guard
			
			}
	save ../data/anal_guard_`1'_to18.dta, replace
restore