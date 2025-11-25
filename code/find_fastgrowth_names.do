/* * had az least as many occurrences in 1998 as the least common Roma name (774) 
* and achieve a double digit population growth (roma is 17%) */

	
gen lastname2 = lastname 
foreach k in `c(alpha)' {
        disp "`k'"
		replace lastname2 = subinstr(lastname2, "`k'`k'", "`k'",.)
}


gen fastgrow = 0
* fast growth but it is in other groups as well: "nemet"  "balog" "horvat"
foreach s in "pintye" "mathe" "csoka" "urmos" "vadasz" "otvos" "piroska" "varadi"  ///
"szajko" "zsakai" "botos" "onodi" "radics" "koszta" "jaroka" "rusznyak" "burka"  ///
"bango" "hanko" "gabor" "simo" "ruzsa"  "bogdan" "maka" "bader" "haga" ///
 "andras" "jonas" "szathmari" "szocs" "incze" "csiki" "lazok" "tyukodi" "putnoki" ///
 "hamza" "mata" "vidak" "ajtai" "orgovan" "bari" "serban" "burai" "vadaszi"  ///
 "pongo" "csemer" "ronto" "suki" "galyas" "joni" "puporka" "sztojka" "dano" "duka"  ///
 "mocsar" "raduly" "suha" "ruszo" "kotai" "milak" "beri" "rafael" "turo" "glonczi" ///
 "goman" "moldovan" "harkaly" "makula" "lazi" "maga"  {
 
 replace fastgrow = 1 if lastname2=="`s'"
 
 }

drop lastname2
egen roma2 = rowmax(roma fastgrow)

