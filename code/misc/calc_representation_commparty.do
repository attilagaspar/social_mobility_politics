

/* this dofile prepares name group specific variables in DOCTOR data */

*use  ../data/population_control_ipolated.dta, clear
use  "../../social mobility (1)/data_forpublication/intermediate/population_control_ipolated_2024_noverlap.dta", clear

gen y5=floor(year/5)*5
gen y10=floor(year/10)*10

collapse (mean) *_ip, by(`1')
local collapsevar = "`1'"


* name shares in business
merge 1:1 `1' using ../data/processed/commparty_`1' , gen (merge_cp)


rename nobility_ip noble_ip

foreach s in "noble"  "top20" {
	
	cap drop x
	ipolate `s'_ip `1', epolate gen(x)
	drop `s'_ip 
	rename x `s'_ip 
	
	
}



* calculate relative rep
foreach s in "noble" "top20"  {

	gen relative_rep_`s'_hun = ( `s'_share_in_cp / `s'_ip ) / ( hunref_share_in_cp  / hunref_ip )

}
  
  

gen relative_rep_jewish_ip = cjewishname_share_in_cp / commonjewishname_ip


foreach s in "noble"  "top20"   {

	gen relative_rep_`s' = ( `s'_share_in_cp / `s'_ip ) 

}

* gen rr_variances
* var(ln(rr)) ~= var(share) / share2

gen var_lnrr_top20_cp = sd_top20_in_cp^2 / top20_share_in_cp^2
gen var_lnrr_noble_cp = sd_noble_in_cp^2 / noble_share_in_cp^2


preserve 
	keep  `1'  relative_* 	 *_share_in_* var_lnrr*
	foreach v of varlist relative_*  {
			rename `v' `v'_cp
			
			}
	save ../data/processed/relrep_commparty_`1'.dta, replace
restore

