replace lastname = strtrim(lastname)

foreach s in "nagy" "kovac" "tot"  "szabo" "horvat" "varga" "kis" ///
	"molnar" "nemet" "farkas" "balog" "pap" "takac" "juhasz" "lakatos" "meszaros" ///
	"olah" "simon" "racz" "fekete" "szilagyi" "torok" "feher" {
	
	
	gen variant_`s' = 0
	gen is_`s' = 0
	replace variant_`s'=1 if strpos(lastname, "`s'")!=0
	replace is_`s'=1 if strpos(lastname, " ")!=0&variant_`s'==1
	replace is_`s'=1 if strpos(lastname, "-")!=0&variant_`s'==1
	replace is_`s'=1 if lastname=="`s'"

	
	}



	
	
foreach s in "nagy"	"anagy"	"bmnagy"	"bnagy"	"csnagy"	"dnagy"	"enagy"	 /// 
	"fnagy"	"gnagy"	"hnagy"	"inagy"	"jnagy"	"knagy"	"lnagy"	"mnagy"	"nynagy"  /// 
	"onagy"	"pnagy"	"rnagy"	"snagy"	"sznagy"	"tnagy"	"unagy"	"vnagy"	"znagy" "nagyne"  /// 
	"zsnagy"		{
	
	replace is_nagy=1 if lastname=="`s'"
	
	}

foreach s in "akovacs"	"bkovacs"	"bukovacz"	"cskovacs"	"dkovacs"	 /// 
	"fkovacs"	"gkovacs"	"gyorgykovacs"	"ikovacs"	"kkovacs"	"kovac"	"kovach" /// 
	"mkovacs"	"rkovacs"	"skovacs"	"szkovacs"	"zkovács"	"kovacs" "kovats" "kovacsne"	{
	
	replace is_kovac=1 if lastname=="`s'"
	
	}

foreach s in "btoth"	"csetot"	"cstoth"	"dtoth"	"ftoth"	"gtoth"	"htoth"	 /// 
	"kistot"	"kistoth"	"ktoth"	"ltoth"	"mtoth"	"otott"	"ptoth"	"rtoth"	"stoth"  /// 
	"toth"	"vtoth"	"ztoth" "tot" "toth"	"tothne" "totth"	{
	
	replace is_tot=1 if lastname=="`s'"
	
	}

foreach s in "bszabo"	"csszabo"	"dszabo"	"gszabo"	"gyszabo"	"hszabo"  /// 
	"kszabo"	"kunszabo"	"mszabo"	"nagyszabo"	"nszabo"	"palszabo"	 /// 
	"peterszabo"	"pszabo"	"rszabo"	"szabo"	"szszabo"	"szurszabo" "szabone"  /// 
	"vszabo"	"zszabo"		{
	
	
	replace is_szabo=1 if lastname=="`s'"
	
	}

foreach s in "horvat" "horvath" "bhorvath"	"chorvat"	"chorvath"	"khorvath"	"ohorvath" "horvathne"	{																						

replace is_horvat=1 if lastname=="`s'"

}

foreach s in "csvarga"	"cvarga"	"kvarga"	"lvarga"	"nvarga"	"varga"	"vargane" "vargha" {	

replace is_varga=1 if lastname=="`s'"

}																				

foreach s in "kis" "kiss" "akiss"	"bkis"	"bkiss"	"akiss"	"bkis"	"bkiss"	"akiss"	"bkis"	 ///  
	"bkiss"	"akiss"	"bkis"	"bkiss"	"akiss"	"bkis"	"bkiss"	"gykis"	"hkiss"	"kis"  /// 
	"kkiss"	"lkis"	"lkiss"	"pkis"	"pkiss"	"skiss"	"szkiss"	"tkiss"	"vkiss"	"zkis" "kissne" "kisne" {
	
replace is_kis=1 if lastname=="`s'"
	
	}

foreach s in "molnar" "csmolnar"	"dmolnar"	"gmolnar"	"kmolnar"	"molnar"	"szmolnar" "molnarne"	{																					

replace is_molnar=1 if lastname=="`s'"

}

foreach s in "dnemet" "nemeth" "nemet"	"lnemeth" "nemetne" "nemethne"		{	

replace is_nemet=1 if lastname=="`s'"

}			 																				

foreach s in "gfarkas"	"farkas" "farkash" "farkas" "farkasne" "farkass" 	{				

replace is_farkas=1 if lastname=="`s'"

}																					

foreach s in "bbalogh"	"tbalog"	"tbalogh"	"balogh"	"baloghne" {		

replace is_balog=1 if lastname=="`s'"

}																					

foreach s in "cspapp"	"kpapp"	"lpapp"	"mpapp"	"pap"	"papp"	"pappp"	"zpap"	"zpapp"	"papne" "pappne"	{		

replace is_pap=1 if lastname=="`s'"

}													

foreach s in "takach" "takacs"	"takacsne"  "takats" {	

replace is_takac=1 if lastname=="`s'"

}																									
																											
foreach s in "dmeszaros" "meszaros" "meszarosne" {


replace is_meszaros=1 if lastname=="`s'"

}


gen name_simplified = lastname

foreach s in "nagy" "kovac" "tot"  "szabo" "horvat" "varga" "kis" ///
	"molnar" "nemet" "farkas" "balog" "pap" "takac" "juhasz" "lakatos" "meszaros" ///
	"olah" "simon" "racz" "fekete" "szilagyi" "torok" "feher" {

	replace name_simplified = "`s'" if is_`s'==1
	*&variant_`s'==1 - ez mi az istennek van itt?!?!?! 05/20/20
	
}


