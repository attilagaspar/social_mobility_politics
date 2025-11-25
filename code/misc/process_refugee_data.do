import excel "../data/raw/trianon_refugees/refugee_list.xlsx", sheet("Sheet1") firstrow clear

gen name = Név
order name
replace name = subinstr(name, "özv. ","",.)
replace name = subinstr(name, "Dr. ","",.)
replace name = subinstr(name, "dr. ","",.)
replace name = subinstr(name, "gr. ","",.)
replace name = subinstr(name, "id. ","",.)
replace name = subinstr(name, "ifj. ","",.)
replace name = subinstr(name, "br. ","",.)
replace name = subinstr(name, "dabasi ","",.)
replace name = subinstr(name, "deési ","",.)
replace name = subinstr(name, "balázsfalvi ","",.)

foreach s in "H." "B." "K." "L." "P." "R." "S." "G." {
	
		replace name = subinstr(name, "`s' ","",.)
	
}



split name, gen(nm)
rename nm1 lastname
drop nm* 
order lastname 

drop if lastname=="kb."
drop if length(lastname)<3

* weight
gen strL wght = ustrregexra(Családtagokˇ , "[^0-9]", "")
destring wght, force replace
replace wght = 0 if wght==.
replace wght = wght+1

replace wght = 6 if wght ==33 // "3 fiával és 3 leányával"
replace wght = 6 if wght >100 // "Helmeczi Ágostonné szül. Horváth Gizella (feleség, 1878-1967), 4 gyermekük: István (1906), Gizella (1908), Márta (1910), Margit (1914)"


do create_name_groups.do

gen total_refugees = 1

collapse (mean) ///
		 noble_share_in_refugees = nobility ///
		 top20_share_in_refugees = top20  ///
		 hunref_share_in_refugees = hun_ref ///
		 german_broad_share_in_refugees = german_broad ///
		 (sum)  ///
		 noble_total_in_refugees = nobility ///
		 top20_total_in_refugees = top20  ///
		 hunref_total_in_refugees = hun_ref ///		 
		 german_broad_total_in_refugees = german_broad ///
		 total_refugees ///
			[w=wght]