

/* this dofile prepares name group specific variables in data */

use   "$population_control_data_dir/$population_control_file", clear

gen y5=floor(year/5)*5
gen y10=floor(year/10)*10
do Periods_definition.do

collapse (mean) *_ip, by(`1')
local collapsevar = "`1'"


* name shares in high school
merge 1:1 `1' using "$intermediate_data_dir/hshool_`1'.dta" , gen (merge_hs)


rename nobility_ip noble_ip

foreach s in "noble" "roma2"  "top20" {
	
	cap drop x
	ipolate `s'_ip `1', epolate gen(x)
	drop `s'_ip 
	rename x `s'_ip 
	
	
}

*merge 1:1 `1' using  "../data_forpublication/intermediate/roma_share_`1'.dta",  gen(merge_roma_share)


tsset `1'


* calculate relative rep
foreach s in "noble" "roma2" "top20"  {

	gen relative_rep_`s'_hun = ( `s'_share_in_hs / `s'_ip ) / ( hunref_share_in_hs  / hunref_ip )

}
  

gen relative_rep_jewish_ip = cjn_share_in_hs / commonjewishname_ip
*gen relative_rep_german_broad_ip = grmn_broad_share_in_hs / german_broad_ip
gen relative_rep_german_ip = grmn_share_in_hs / german_ip
gen relative_rep_gjs_ip = gerjewsla_share_in_hs / gerjewsla_ip


foreach s in "noble" "roma2"  "top20"  "hunref"  {

	gen relative_rep_`s' = ( `s'_share_in_hs / `s'_ip ) 

}




preserve 
	keep  `1'  relative_*  *_share_in_* *_ip
	foreach v of varlist relative_*  {
			cap rename `v' `v'_hs
			
			}
	save "$intermediate_data_dir/anal_hschool_`1'_`2'.dta", replace
restore

