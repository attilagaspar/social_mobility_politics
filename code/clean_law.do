use "$law_raw_dir/elte_raw1.1.dta", clear

keep if faculty == "law"
keep if year>=1849


gen y10 = round(year/10)*10 
gen y5 = round(year/5)*5 

*gen y10 = floor(year/10)*10
*gen y5 = floor(year/5)*5

do Periods_definition.do

drop name_simplified top20 roma nobility fastgrow roma2 german slavic romanian commonjewishname german_broad slavic_broad romanian_broad nonref hun_ref endsi

do create_name_groups.do


gen count = 1


foreach collapsevar of varlist  y10 y5 year periods {

preserve

collapse (mean) grmn_share_in_law = german slv_share_in_law = slavic rmn_share_in_law = romanian ///
	 cjn_share_in_law = commonjewishname grmn_broad_share_in_law = german_broad  ///
	 slv_broad_share_in_law = slavic_broad rmn_broad_share_in_law = romanian_broad  ///
	 noble_share_in_law = nobility top20_share_in_law = top20 roma_share_in_law = roma endsi_share_in_law = endsi  ///
	 hunref_share_in_law = hun_ref ///
	 roma2_share_in_law = roma2 ///
	 iw_hs_share_in_law = iw_hs ///
	 iw_ls_share_in_law = iw_ls ///
	 lowstat_share_in_law = lowstat ///
	 highstat_share_in_law = highstat ///
	 doc50_share_in_law = doc50 ///
	 gerjewsla_share_in_law = gerjewsla ///
	 (sum)  law_count = count law_noble_count = nobility  , by(`collapsevar')
	 

	save "$intermediate_data_dir/law_`collapsevar'.dta", replace

restore

}

