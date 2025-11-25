/* this script calculates:

 -y, -i, top20 share in guard members


*/

use "../../social mobility (1)/data/magyar_testorseg\guard.dta", clear


split fullname, gen(fn)
rename fn1 lastname

do create_name_groups.do


gen y10=floor(year/20)*20 +10
tab y10

foreach collapsevar of varlist  y10 year   {  //y5 year periods

	preserve
	
	gen count = 1
	
	collapse (mean) german_share_in_guard = german slavic_share_in_guard = slavic romanian_share_in_guard = romanian ///
		 cjewishname_share_in_guard = commonjewishname   ///
		 noble_share_in_guard = nobility top20_share_in_guard = top20 roma_share_in_guard = roma endsi_share_in_guard = endsi  ///
		 hunref_share_in_guard = hun_ref ///
		 (semean) sd_top20_in_guard = top20 ///
		 sd_noble_in_guard = nobility ///
		 (sum)  guard_count = count guard_noble_count = nobility  , by(`collapsevar')
		 
	*scatter noble_share top20_share  y, xline(1848 1867 1918 1946 1989)



		save ../data/processed/guard_`collapsevar'.dta, replace

	restore

}
