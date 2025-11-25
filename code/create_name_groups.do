/* this script takes a single "lastname" variable as input, and create
   all name groups for the elite data */

* merge female names
/*
merge m:1 firstname using "../data_forpublication/women_firstnames.dta", gen(merge_womanname)
drop if merge_womanname==2
replace woman=0 if woman==.
replace woman=1 if married_woman==1&woman==0
*/
  
* remove accents
do accents.do lastname

* collape for different variations of same basic names (eg kovach/kovats/kocacs)
do "collapse_pop_control_name_variants_AUX"
drop is_* variant_*
replace lastname=name_simplified
drop if lastname==""

* top 20 most frequent - top20 is defined as "ever on the top20 most frequent names",
* so there are more than 20 names in the top20 list
gen top20=0
foreach s in "nagy" "kovac" "tot"  "szabo" "horvat" "varga" "kis" ///
	"molnar" "nemet" "farkas" "balog" "pap" "takac" "juhasz" "lakatos" "meszaros" ///
	"olah" "simon" "racz" "fekete" "szilagyi" "torok" "feher" {
	
* 
	replace top20=1 if lastname=="`s'"

	
	}

* names ifentified as associated with the Romani minority by the Hungarian Encyclopedia of Family Names
gen roma=0
	foreach s in  "berki" "kalo"  "kallo"  "kanalas" "kanalos"  "kalanyos"  ///
	"kolompar"  "kolumpar"  "lakatos"  "lole" "lolle" "more" "moreh"   "orsos"  ///
	"pusoma"  "pussoma"   "rezmuves"   "rostas"  "restas"  "zambo"   {
	
		replace roma = 1 if lastname=="`s'"
	}

* create ..y ending variable
do do_nobles.do

* find names in the grouo that grew the fastest between 1998 and 2018 in population
* - also associated with Romani minority more closely than the rest
do find_fastgrowth_names.do

* find other minority name origins, based on the Encyclopedia and additional
* data sources
gen ln=""
replace ln = proper(lastname)
do name_origins_on_simplified_no_overlap.do ln
drop ln

* create reference group : Everyone - nobles - Slavs - Germans - Jewisn names - Romanians - Roma
egen nonref = rowmax(german_broad slavic_broad romanian_broad commonjewishname nobility roma roma2 )
gen hun_ref = 1-nonref

* alternative ending: ..i (not exclusive)
gen endsi=0	
replace endsi = 1 if substr(lastname, -1, 1)=="i"



/* DOCTORS have a high share of foreign students starting
from year 1980s, so we have to account for this 
when identifying name groups.
First: remove Arabic and Persian names form the ..i names */
egen g = group(lastname)



egen c = count(g), by(g)
replace endsi=0 if substr(lastname,1,2)=="al"&c==1
replace endsi=0 if lastname=="ali"|lastname=="almutairi"|lastname=="alkhaldi"|lastname=="alotaibi"
replace endsi=0 if substr(lastname,1,2)=="el"&endsi==1
replace endsi=0 if endsi==1&strpos(lastname,"ani")!=0&c==1
replace endsi=0 if lastname=="attariani"|lastname=="katziani"|lastname=="bahadorani"|lastname=="vahdani"|lastname=="taybani"|lastname=="rahmani"|lastname=="zamani"|lastname=="dehghani"
replace endsi=0 if endsi==1&substr(lastname,-2,2)=="ni"&c==1
replace endsi=0 if strpos(lastname,"sharabi")!=0

replace endsi=0 if lastname=="hadari"|lastname=="ferrari"|lastname=="zolfaghari"		///
	|lastname=="bidzsari"|lastname=="martits-chalangari"|lastname=="ghaffari"|		///
	lastname=="bakhtiari"|lastname=="zafari"|lastname=="zborovari"|lastname=="heydari"		///
	|lastname=="ghari"|lastname=="hajighanbari"|lastname=="yari"|lastname=="ashtari"		///
	|lastname=="szadvari"|lastname=="ghamari"|lastname=="ben-ari"|lastname=="kahari"		///
	|lastname=="szathinari"|lastname=="khodayari"|lastname=="jafari"|		///
	lastname=="smizansky-bari"|lastname=="kazari"|lastname=="cristofari"		///
	|lastname=="daftari"|lastname=="steger-kovari"|lastname=="abhari"|lastname=="biliari"		///
	|lastname=="jaberansari"|lastname=="entessari"|lastname=="chalangari"|		///
	lastname=="hakimshoushtari"|lastname=="damari"|lastname=="hawwari"|		///
	lastname=="fischer-szatmari"|lastname=="khalatbari"|lastname=="taghipourasghari"|		///
	lastname=="asnaashari"|lastname=="ghanbari"|lastname=="mozafari"|lastname=="chaudhari"|		///
	lastname=="memari"|lastname=="esfandiari"		

replace endsi=0 if endsi==1&strpos(lastname,"imi")!=0
replace endsi=0 if endsi==1&strpos(lastname,"w")!=0

replace endsi=0 if  lastname=="nazari-khanmiri"|lastname=="talkhabi"|lastname=="akhlaghi"|		///
lastname=="khademi"|lastname=="dakhlaoui"|lastname=="golkhorshidi"|		///
lastname=="batrekhi"|lastname=="dankhazi"|lastname=="khazei"|lastname=="khangyi"|		///
lastname=="khezri"|lastname=="ezimokhai"|lastname=="khosravi"|lastname=="khedmati"|		///
lastname=="khazaeiheravi"|lastname=="chikhi"|lastname=="khanmohammadbeigi"|		///
lastname=="khodaei"|lastname=="khouri"|lastname=="khodadadi"
replace endsi=0 if  lastname=="bayazi"|lastname=="shahbazi"|lastname=="pourvaziri"
replace endsi = 0 if strpos(lastname,"semi")!=0&lastname!="csemi"
* what has been removed from the ..i names, shall be removed from the reference 
* hungarian names as well
replace hun_ref = 0 if endsi==0&substr(lastname,-1,1)=="i"
* some Eastern names remain
replace hun_ref = 0 if lastname=="mohannad"|lastname=="mohamad"|lastname=="mohammad"
replace hun_ref = 0 if strpos(lastname,"oo")!=0&c==1
replace hun_ref = 0 if strpos(lastname,"sh")!=0&strpos(lastname,"honti")==0&strpos(lastname,"hegyi")==0&strpos(lastname,"hazi")==0   // except: -honti, -hazi, -hegyi
replace hun_ref = 0 if strpos(lastname,"q")!=0
replace hun_ref = 0 if substr(lastname,-2,2)=="et"&lastname!="nemet"
replace hun_ref = 0 if substr(lastname,-2,2)=="ah"&lastname!="olah"
replace hun_ref = 0 if substr(lastname,-2,2)=="eh"&lastname!="cseh"&lastname!="czeh"&lastname!="imreh"
replace hun_ref = 0 if strpos(lastname,"semi")!=0&lastname!="csemi"

* German and Scandinavian names
replace hun_ref = 0 if strpos(lastname,"burg")!=0
replace hun_ref = 0 if strpos(lastname,"sch")!=0
replace hun_ref = 0 if strpos(lastname,"dottir")!=0
replace hun_ref = 0 if strpos(lastname,"dorf")!=0
replace hun_ref = 0 if strpos(lastname,"w")!=0&lastname!="warga"
replace hun_ref = 0 if substr(lastname,-3,3)=="son"&lastname!="karacson"&lastname!="karatson"&lastname!="samson"   // except: karacson, samson, tuzson, karatson
replace hun_ref = 0 if substr(lastname,-3,3)=="sen"
replace hun_ref = 0 if substr(lastname,-2,2)=="dt"

*replace hun_ref = 0 if strpos(lastname,"oo")!=0
drop g c
