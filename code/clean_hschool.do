
use "$hschool_raw_dir/consistent_all_names_in_database.dta", clear


gen year=kalkszulev1+17
keep firstname lastname year


gen y10 = round(year/10)*10 
gen y5 = round(year/5)*5 

do Periods_definition.do

***************************
do create_name_groups.do
***************************


gen count = 1


foreach collapsevar of varlist  y10 y5 year periods {

preserve

collapse (mean) grmn_share_in_hs = german slv_share_in_hs = slavic rmn_share_in_hs = romanian ///
	 cjn_share_in_hs = commonjewishname grmn_broad_share_in_hs = german_broad  ///
	 slv_broad_share_in_hs = slavic_broad rmn_broad_share_in_hs = romanian_broad  ///
	 noble_share_in_hs = nobility top20_share_in_hs = top20 roma_share_in_hs = roma endsi_share_in_hs = endsi  ///
	 hunref_share_in_hs = hun_ref ///
	 roma2_share_in_hs = roma2 ///
	 gerjewsla_share_in_hs = gerjewsla ///
	 (sum)  hs_count = count law_noble_count = nobility  , by(`collapsevar')
	 

	save "$intermediate_data_dir/hshool_`collapsevar'.dta", replace

restore

}

