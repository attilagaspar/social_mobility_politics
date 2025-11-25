

* normalize to lowercase
gen strL title_clean = lower(title)
replace title_clean = strtrim(title_clean)

/* ellenőrzőkód

egen t = tag(title_clean)
egen c = count(title_clean), by(title_clean)
replace c = -c
sort c
replace c = -c

*/

* CEO / General Manager
gen role_CEO = regexm(title_clean, "ügyvezető igazgató|vezérigazgató|cégvezető")
replace role_CEO = 1 if title_clean=="igazgató"
replace role_CEO = 1 if strpos(title_clean,"cégjegyzésre jo")!=0
replace role_CEO = 1 if strpos(title_clean,"chief executive")!=0
replace role_CEO = 1 if strpos(title_clean,"executive director")!=0
replace role_CEO = 1 if strpos(title_clean,"director")!=0&strpos(title_clean,"board of directors")==0
replace role_CEO = 1 if strpos(title_clean,"igazgató")!=0&strpos(title_clean,"igazgatóság")==0&strpos(title_clean,"helyettes")==0
* Company Manager (treat as CEO/General Manager)
replace role_CEO          = 1 if regexm(title_clean, "company manager")

* Director / Board of Directors
*gen role_director = (regexm(title_clean, "igazgató")&title_clean!="igazgató") | regexm(title_clean, "igazgatóság") | ///
*                    regexm(title_clean, "director")

* Supervisory Board
gen role_supervisory = regexm(title_clean, "felügyelő")   // captures all variants:
* felügyelőbizottsági, felügyelő bizottsági, felügyelő-bizottsági, etc.

* Chair / President
gen role_chair = regexm(title_clean, "elnök")   // also covers alelnök

* Bookkeeper / Finance
gen role_bookkeeper = regexm(title_clean, "könyvelő")

* Liquidator / Administrator
gen role_liquidator = regexm(title_clean, "felszámoló")

* Member / Staff (generic 'tag')
gen role_member = regexm(title_clean, "tag")

* Manager / Department Head
gen role_manager = regexm(title_clean, "vezető")

* Honorifics / Name fragments (not true roles)
gen role_honorific = regexm(title_clean, "dr|özvegy|vitéz")



				  * --- English / extra variants for the listed rare titles --------------------

* Board of Directors (Board Member variants)
replace role_member     = 1 if regexm(title_clean, "board member|member of the board")

* Supervisory Board (English variants)
replace role_supervisory  = 1 if regexm(title_clean, "member of (the )?supervisory board|supervisory board( member)?")

* Chairman
replace role_chair        = 1 if regexm(title_clean, "chairman")



* Manager / Supervisor (English words)
replace role_manager      = 1 if regexm(title_clean, "(^|[[:space:]])manager($|[[:space:]])|supervisor")

* Chief Accountant
replace role_bookkeeper   = 1 if regexm(title_clean, "chief accountant")

* Cashier / Treasurer
replace role_bookkeeper   = 1 if regexm(title_clean, "p.nzt.rnok|p.nzt.ros|f.p.nzt.rnok")   // pénztárnok/pénztáros/főpénztárnok (accent-agnostic)
replace role_bookkeeper   = 1 if regexm(title_clean, "k.nyvel.|f.k.nyvel.")                  // könyvelő/főkönyvelő

* Engineer / Chief Engineer
replace role_manager      = 1 if regexm(title_clean, "f.m.rn.k|m.rn.k")                      // főmérnök/mérnök

* Inspector / Controller
replace role_supervisory  = 1 if regexm(title_clean, "ellen.r")                              // ellenőr
replace role_supervisory  = 1 if regexm(title_clean, "member of supervisory board")          // safety net

* Office/Dept heads / "vezető"-like roles
replace role_manager      = 1 if regexm(title_clean, "irodaf.n.k|oszt.lyf.n.k|int.z.|vezet.") // irodafőnök/osztályfőnök/intéző/vezető

* Clerical / Staff / Members
replace role_member       = 1 if regexm(title_clean, "member|tag|tisztvisel.|hivatalnok|irodatiszt|levelez.|gondnok|rakt.rnok") 
                                                                                               // member/tag/tisztviselő/hivatalnok/irodatiszt/levelező/gondnok/raktárnok
* Liquidator (English)
replace role_liquidator   = 1 if regexm(title_clean, "liquidator")

* Chair / President (Hungarian)
replace role_chair        = 1 if regexm(title_clean, "eln.k|aleln.k")                        // elnök/alelnök

* Board of Directors (Hungarian)
*replace role_director     = 1 if regexm(title_clean, "igazgat.s.g|igazgat.s.gi tag") // igazgatóság/igazgatósági tag/igazgató

* Supervisory Board (Hungarian variants, already broadly covered by felügyelő*)
replace role_supervisory  = 1 if regexm(title_clean, "fel.gyel.")                            // catch-all: felügyelő-...
                                                                                              
* Honorifics / Social titles (not roles)
replace role_honorific    = 1 if regexm(title_clean, "doktor|doctor|b.r.|gr.f|lovag|.zv\\.|.zvegy|vitez|vitéz") 

* Legal / Owners / Founders → keep as OTHER (don't set a role to preserve 10-category scheme)
* (These will fall into role_other by construction)
*   cégjegyző|jegyző|prokur.tor|jogtan.csos|.gy.v.d|.gy.sz|founder|owner|tulajdonos|partner|r.szv.nyes|k.pvisel.
* If you prefer, you could tag them as role_member=1, but leaving them to 'Other' matches your setup.

* OPTIONAL: after adding new rules, you may want to recompute 'role_other' so these updates are respected:
* drop role_other
* gen role_other = (role_CEO==0 & role_director==0 & role_supervisory==0 & ///
*                   role_chair==0 & role_bookkeeper==0 & role_liquidator==0 & ///
*                   role_member==0 & role_manager==0 & role_honorific==0)

				  
				  
label var role_CEO        "CEO / General Manager"
*label var role_director   "Director / Board of Directors"
label var role_supervisory "Supervisory Board"
label var role_chair      "Chair / President"
label var role_bookkeeper "Bookkeeper / Finance"
label var role_liquidator "Liquidator / Administrator"
label var role_member     "Member / Staff"
label var role_manager    "Manager / Dept Head"
label var role_honorific  "Honorific / Name fragment"

gen role_owner = 0
replace role_owner= 1 if strpos(title, "tulajd")!=0
replace role_owner= 1 if strpos(title, "owner")!=0
replace role_owner= 1 if strpos(title, "részvényes")!=0

label var role_owner "Owner / Shareholder"

cap drop role_other
* Other = none of the above
gen role_other = (role_CEO==0 &  role_supervisory==0 & /// role_director==0 &
                  role_chair==0 & role_bookkeeper==0 & role_liquidator==0 & ///
                  role_member==0 & role_manager==0 & role_honorific==0 )
label var role_other      "Other"
