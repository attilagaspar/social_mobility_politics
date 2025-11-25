* generate year var
split path, parse("/") gen(pth)
gen year = substr(pth1, 7,4)
destring year, force replace

* clean names
replace name=strtrim(name)
gen has_dot = 0
replace has_dot = 1 if strpos(name,".")!=0

gen starts_lower = regexm(name, "^(?-i:[a-záéíóöőúüű])")


split name, gen("nm")
gen not_name=""
foreach v of varlist nm* {
	
	replace not_name = not_name+" "+`v' if ustrregexm(ustrtrim(`v'), "^\p{Ll}")|strpos(`v',".")!=0
	replace `v' = "" if ustrregexm(ustrtrim(`v'), "^\p{Ll}")|strpos(`v',".")!=0
	
}
egen name_clean = concat(nm*), p(" ")
replace not_name = strtrim(not_name)


drop nm*
split name_clean, gen("nm")
rename nm1 lastname
drop nm*

drop pth1 pth2 pth3 pth4 has_dot starts_lower
compress