

/* this dofile prepares name group specific variables in BUSINESS data */

use   "$population_control_data_dir/$population_control_file", clear

gen y5=floor(year/5)*5
gen y10=floor(year/10)*10
do Periods_definition.do

collapse (mean) *_ip, by(`1')
local collapsevar = "`1'"


* name shares in business
merge 1:1 `1' using "$intermediate_data_dir/business_`1'" , gen (merge_bus)


rename nobility_ip noble_ip

foreach s in "noble" "top20" {
	
	cap drop x
	ipolate `s'_ip `1', epolate gen(x)
	drop `s'_ip 
	rename x `s'_ip 
	
	
}



* calculate relative rep
foreach s in "noble" "top20"  {

	gen relative_rep_`s'_hun = ( `s'_share_in_bus / `s'_ip ) / ( hunref_share_in_bus  / hunref_ip )

}
  
  

gen relative_rep_jewish_ip = cjn_share_in_bus / commonjewishname_ip
*gen relative_rep_german_broad_ip = grmn_broad_share_in_bus / german_broad_ip
gen relative_rep_german_ip = grmn_share_in_bus / german_ip
gen relative_rep_gjs_ip = gerjewsla_share_in_bus / gerjewsla_ip




foreach s in "noble"  "top20"   {

	gen relative_rep_`s' = ( `s'_share_in_bus / `s'_ip ) 

}

* gen rr_variances
* var(ln(rr)) ~= var(share) / share2

gen var_lnrr_top20_bus = sd_top20_in_bus^2 / top20_share_in_bus^2
gen var_lnrr_noble_bus = sd_noble_in_bus^2 / noble_share_in_bus^2


preserve 
	keep  `1'  relative_* 	 *_share_in_* var_lnrr*
	foreach v of varlist relative_*  {
			rename `v' `v'_bus
			
			}
	save "$intermediate_data_dir/relprep_`1'.dta", replace
	save "$intermediate_data_dir/anal_bus_`1'_`2'.dta", replace
	
restore

