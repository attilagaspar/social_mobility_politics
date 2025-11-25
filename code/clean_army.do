/* this script calculates:

 -y, -i, top20 share in OFFICERS


*/


use "$army_raw_dir/zrinyi/kivaloak.dta", clear 

split fullname, gen(nm)
rename nm1 lastname
drop nm2 nm3


tempfile comm
save `comm'

***********************************
* LUDOVIKA
**********************************



import excel "$army_raw_dir/ludovika_hungarianarmedforces_com.xlsx", sheet("Sheet1") clear
drop if A=="?"
drop if A=="? ?"


gen ind=0
replace ind=1 if regexm(A, "^([A-ZÁÉŐŰÓÚÍÜÖ][A-ZÁÉŐŰÓÚÍÜÖ])")

/*
gen lasttag=""
gen x15=""

forvalues n = 2/14 {


	local next = `n'+1
	replace lasttag=x`n' if x`n'!="" & x`next'==""
	


}
*/

gen inst = H
replace inst=G if inst==""
replace inst=F if inst==""

gen graddate = G if G!=inst
replace graddate=F if graddate=="" &  F!=inst & F!=""
replace graddate=E if graddate=="" &  E!=inst & E!=""

gen spec = F if F!=inst&F!=graddate
replace spec = E if spec=="" & E!=inst&E!=graddate
replace spec = D if spec=="" & D!=inst&D!=graddate


gen fname = E if E!=inst&E!=graddate&E!=spec
replace fname = D if fname=="" & D!=inst&D!=graddate&D!=spec
replace fname = C if fname=="" & C!=inst&C!=graddate&C!=spec


gen lname2 = D if D!=inst&D!=graddate&D!=spec&D!=fname
replace lname2 = C if lname2=="" & C!=inst&C!=graddate&C!=spec&C!=fname
replace lname2 = B if lname2=="" & B!=inst&B!=graddate&B!=spec&B!=fname

gen lname1 = C if C!=inst&C!=graddate&C!=spec&C!=fname&C!=lname2
replace lname1 = B if lname1=="" & B!=inst&B!=graddate&B!=spec&B!=fname&C!=lname2
replace lname1 = A if lname1=="" & A!=inst&A!=graddate&A!=spec&A!=fname&C!=lname2

order lname1 lname2

replace lname1 = A if lname1==lname2 & ind==1

replace lname1 = "" if ind==0&lname1==lname2

replace lname2 = lname1 if lname2=="" & lname1!=""
replace lname1 = "" if lname1==lname2

gen title=A if ind==0
*rename lname2 main_lastname

keep title lname2 lname1 inst graddate spec fname title

gen gradyear=substr(graddate,1,4)
drop if gradyear==""

destring gradyear, force replace

rename lname1 lastname1
rename lname2 lastname2
rename fname firstname
gen birth_year = gradyear-21


foreach v of varlist lastname* firstname {

	do accents.do `v'

}


gen data="ludovika"

tempfile ludo
save `ludo'


use "$army_raw_dir/schematismus/hussars.dta", clear

tempfile hussars
save `hussars'


use "$army_other_raw_dir/army_consistent.dta", clear

/* data cleaning */

replace birth_date=. if birth_date>1899|birth_date<1800

keep if birth_date!=.

duplicates drop firstname lastname1 mother birth_date, force

/* GENERATE RANK */
/* we are only interested in actual officers, not doctors etc */

split fullname, 	 gen(x)

gen lasttag=""
gen x15=""

forvalues n = 2/14 {


	local next = `n'+1
	replace lasttag=x`n' if x`n'!="" & x`next'==""
	


}
drop x*
rename lasttag rank

gen tokeep=0

foreach s in "orgy" "onagy" "ezds" "hdgy"  "dgy" "szds" "szd" "szazados" "ezd" ///
 "tabornagy" "altbgy" "altbngy" "alez" "alezd" {
 
 replace tokeep=1 if strpos(rank,"`s'")!=0
 
}

replace tokeep=0 if strpos(rank,"orvos")!=0
replace tokeep=0 if strpos(rank,"lelk")!=0
replace tokeep=0 if strpos(rank,"Gyorgy")!=0
replace tokeep=0 if strpos(rank,"tart")!=0
replace tokeep=0 if strpos(rank,"alhdgy")!=0  // az alhadnagyok nem tiszek
drop if tokeep==0
drop tokeep

gen leut = 0
replace leut = 1 if strpos(rank, "hdgy")!=0
replace leut = 0 if strpos(rank, "fhdgy")!=0

*replace leut = 1 if strpos(rank, "szds")!=0
*replace leut = 1 if strpos(rank, "szazados")!=0

keep if leut==1
drop leut

gen data="archive"
rename birth_date birth_year

append using `ludo'


* pre-cleaning last names
gen lastname = lastname1 if data=="archive"
replace lastname = lastname2 if data=="ludovika"
drop lastname1 lastname2

* inferring graduation years from birth years
gen year = birth_year + 21 if data == "ludovika"
replace year = birth_year + 23 if data =="archive" & birth_year<=1890 

* 1891-1899 cohort must be allocated to war years 1914-1919

replace year = 1914 if birth_year==1891
replace year = 1914 if birth_year==1892
replace year = 1915 if birth_year==1893
replace year = 1915 if birth_year==1894
replace year = 1916 if birth_year==1895
replace year = 1916 if birth_year==1896
replace year = 1917 if birth_year==1897
replace year = 1918 if birth_year==1898
replace year = 1919 if birth_year==1899&data=="archive"


append using `comm'


keep if year>=1867 
append using `hussars'



local collapsevar = "y5"

do create_name_groups.do


gen y10 = floor(year/10)*10
gen y5 = floor(year/5)*5

do Periods_definition.do


gen count = 1


// keep if there are at least 30 observarions


foreach collapsevar of varlist  y10 y5 year periods {

preserve

collapse (mean) german_share_in_officers = german slavic_share_in_officers = slavic romanian_share_in_officers = romanian ///
	 cjewishname_share_in_officers = commonjewishname german_broad_share_in_officers = german_broad  ///
	 slavic_broad_share_in_officers = slavic_broad romanian_broad_share_in_officers = romanian_broad  ///
	 noble_share_in_officers = nobility top20_share_in_officers = top20 roma_share_in_officers = roma endsi_share_in_officers = endsi  ///
	 hunref_share_in_officers = hun_ref ///
	 roma2_share_in_officers = roma2 ///
	 (sum)  officer_count = count officer_noble_count = nobility  , by(`collapsevar')
	

	save "$intermediate_data_dir/officers_`collapsevar'.dta", replace

restore

}
