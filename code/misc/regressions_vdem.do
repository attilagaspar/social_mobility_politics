



la var v2x_clphy "Fizikai erőszak hiánya"
la var v2xcl_acjst "Jogérvényesítés elérhetősége"
la var v2xcl_prpty "Tulajdonjogok stabilitása"
la var v2x_frassoc_thick "Egyesülési szabadság"  
la var v2x_rul "Kiszámítható jogalkalmazás"

*local righthand = "v2x_rul v2xcl_prpty v2x_clphy v2x_frassoc_thick v2xcl_acjst  "
local righthand = " v2x_frassoc_thick v2x_clphy v2x_rul v2xcl_prpty  "
twoway line `righthand' year if year<2020, legend(pos(6) row(2) col(3)) xlabel(1870 " " 1880 1900 1920 1940 1960 1980 2000 2020) xline(1917.4 1919.5 1944.5 1948.5 1989.5) xtitle(" ") ytitle("VDEM Index") title("VDEM indexek értékei a különböző politikai rendszerek alatt")  /// lcolor(red green)
text( 0.95  1893 "Dualizmus", color(gray)) ///
text( 0.95  1932 "Horthy", color(gray)) ///
text( 0.95  1969 "Kommunizmus", color(gray)) ///
text( 0.5  2005 "Köztársaság", color(gray))  ///
lwidth(thick  thick thick thick) ///
lcolor(blue red purple lime orange) ///
lpattern(solid dash longdash short-dash-dot)




graph export ../figures/vdem.pdf, replace


la var v2x_clphy "Lack of violence"
la var v2xcl_acjst "Rule of Law"
la var v2xcl_prpty "Stability of Property Rights"
la var v2x_frassoc_thick "Freedom of Association"  
la var v2x_rul "Rule of Law"

*local righthand = "v2x_rul v2xcl_prpty v2x_clphy v2x_frassoc_thick v2xcl_acjst  "
local righthand = " v2x_frassoc_thick v2x_clphy v2x_rul v2xcl_prpty  "
twoway line `righthand' year if year<2020, legend(pos(6) row(2) col(3)) xlabel(1870 " " 1880 1900 1920 1940 1960 1980 2000 2020) xline(1917.4 1919.5 1944.5 1948.5 1989.5) xtitle(" ") ytitle("VDEM Index") title("Values of some VDEM indices under different regimes")  /// lcolor(red green)
text( 0.95  1893 "Austria-Hungary", color(gray)) ///
text( 0.95  1932 "Horthy", color(gray)) ///
text( 0.95  1969 "Communism", color(gray)) ///
text( 0.5  2005 "Republic", color(gray))  ///
lwidth(thick  thick thick thick) ///
lcolor(blue red purple lime orange) ///
lpattern(solid dash longdash short-dash-dot)




graph export ../figures/vdem_en.pdf, replace

dsdsddsd

 eststo clear
*foreach v of varlist M_noble_dr M_noble_law M_noble_bus M_noble_reps {

foreach v of varlist M_log_rr_noble_dr_smooth M_log_rr_noble_law_smooth M_log_rr_noble_bus_smooth M_log_rr_noble_reps_smooth {
	disp "`v'"
	reg `v' `righthand'   , rob
	local r2 = round(e(r2),.01)
	local theo = round(_b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] , 0.01)

	
	newey `v'  `righthand', lag(3)
	eststo
	estadd local ideal `theo'
	estadd local rsq `r2'
		test _b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] = 0
			local pv =  round(r(p),0.01)
	estadd local pval  `pv'
		
}

esttab  using "../tables/regimes_ynames.tex",   main( b %6.2f)   aux(se %6.3f)  replace label nonotes    mtitle( "Orvosok"  "Jogászok" "Igazgatók" "Képviselők" )   scalars( "pval \$H_{0}: \sum (\beta_i) = 0\$ " "rsq OLS R2"  "N Megfigyelések"   )  star(* 0.10 ** 0.05 *** 0.01)	 



 eststo clear
foreach v of varlist M_log_rr_top20_dr_smooth M_log_rr_top20_law_smooth M_log_rr_top20_bus_smooth M_log_rr_top20_reps_smooth {
	disp "`v'"
	reg `v'  `righthand'  , rob
	local r2 = round(e(r2),.01)
	local theo = round(_b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc], 0.01)

	
	newey `v' `righthand' , lag(3)
	eststo
	estadd local ideal `theo'
	estadd local rsq `r2'
	
		test _b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] = 0
	local pv =  round(r(p),0.01)
	estadd local pval  `pv'	
	
		*test _b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] + _b[v2xcl_acjst] = 0
}

esttab  using "../tables/regimes_top20.tex",   main( b %6.2f)   aux(se %6.3f)  replace label nonotes    mtitle( "Orvosok"  "Jogászok" "Igazgatók" "Képviselők" )   scalars( "pval \$H_{0}: \sum (\beta_i) = 0\$ " "rsq OLS R2"  "N Megfigyelések"   ) star(* 0.10 ** 0.05 *** 0.01)	 
/*

local righthand = "v2x_rul v2xcl_prpty v2x_clphy v2x_frassoc_thick v2xcl_acjst  "

 eststo clear
*foreach v of varlist M_noble_dr M_noble_law M_noble_bus M_noble_reps {

foreach v of varlist M_noble_dr M_noble_law M_noble_bus M_noble_reps {
	disp "`v'"
	reg `v' `righthand'   , rob
	local r2 = round(e(r2),.01)
	*local theo = round(_b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] + _b[v2xcl_acjst], 0.01)

	
	*newey `v'  `righthand', lag(3)
	eststo
	estadd local ideal `theo'
	estadd local rsq `r2'
	*	test _b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] + _b[v2xcl_acjst] = 0
}

esttab  using "../tables/regimes_ynames_nosmooth.tex",   main( b %6.2f)   aux(se %6.3f)  replace label nonotes    mtitle( "Orvosok"  "Jogászok" "Igazgatók" "Képviselők" )   scalars( "ideal Ideális mobilitás" "rsq OLS R2"  "N Megfigyelések"   ) star(* 0.10 ** 0.05 *** 0.01)	 



 eststo clear
foreach v of varlist M_top20_dr M_top20_law M_top20_bus M_top20_reps {
	disp "`v'"
	reg `v'  `righthand'  , rob
	local r2 = round(e(r2),.01)
	local theo = round(_b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] + _b[v2xcl_acjst], 0.01)
	test _b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] + _b[v2xcl_acjst] = 0
	
	*newey `v' `righthand' , lag(3)
	eststo
	estadd local ideal `theo'
	estadd local rsq `r2'
		test _b[_cons] + _b[v2x_rul] + _b[v2xcl_prpty] +_b[v2x_clphy] +_b[v2x_frassoc] + _b[v2xcl_acjst] = 0
}

esttab  using "../tables/regimes_top20_nosmooth.tex",   main( b %6.2f)   aux(se %6.3f)  replace label nonotes    mtitle( "Orvosok"  "Jogászok" "Igazgatók" "Képviselők" )   scalars( "ideal Ideális mobilitás" "rsq OLS R2"  "N Megfigyelések"   ) star(* 0.10 ** 0.05 *** 0.01)	 

/*
dsdssdsds

local all_indices = "v2x_EDcomp_thick v2x_accountability v2x_accountability_osp v2x_api v2x_civlib v2x_clphy v2x_clpol v2x_clpriv v2x_corr v2x_cspart v2x_delibdem v2x_diagacc v2x_diagacc_osp v2x_divparctrl v2x_egal v2x_egaldem v2x_elecoff v2x_elecreg v2x_ex_confidence v2x_ex_direlect v2x_ex_hereditary v2x_ex_military v2x_ex_party v2x_execorr v2x_feduni v2x_frassoc_thick v2x_freexp v2x_freexp_altinf v2x_gencl v2x_gencs v2x_gender v2x_genpp v2x_horacc v2x_horacc_osp v2x_hosabort v2x_hosinter v2x_jucon v2x_legabort v2x_libdem v2x_liberal v2x_mpi v2x_neopat v2x_partip v2x_partipdem v2x_polyarchy v2x_pubcorr v2x_regime v2x_regime_amb v2x_rule v2x_suffr v2x_veracc v2x_veracc_osp v2xca_academ v2xcl_acjst v2xcl_disc v2xcl_dmove v2xcl_prpty v2xcl_rol v2xcl_slave v2xcs_ccsi v2xdd_cic v2xdd_dd v2xdd_i_ci v2xdd_i_or v2xdd_i_pl v2xdd_i_rf v2xdd_toc v2xdl_delib v2xeg_eqaccess v2xeg_eqdr v2xeg_eqprotec v2xel_elecparl v2xel_elecpres v2xel_frefair v2xel_locelec v2xel_regelec v2xex_elecleg v2xex_elecreg v2xlg_elecreg v2xlg_legcon v2xlg_leginter v2xme_altinf v2xnp_client v2xnp_pres v2xnp_regcorr v2xpe_exlecon v2xpe_exlgender v2xpe_exlgeo v2xpe_exlpol v2xpe_exlsocgr v2xps_party"

lasso linear M_log_rr_noble_bus_smooth `all_indices' , selection(cv, folds(10) )
lassocoef, display(nonzero)          // shows selected variables (nonzero betas)
predict yhat_lasso, xb               // fitted values from the lasso model