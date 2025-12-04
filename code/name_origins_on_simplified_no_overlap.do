/* this script returns the "name origin" variables for the last names entered.

The basis of name origin variable is from the Hungarian Enciclopedia of family names for 
German and Slavic names. The narrowly defined "german" category is every name 
which is defined as a "German family name" by th Encyclopedia. The narrowly defined
"slavic" category covers every name where the Encyclopedia says "Slavic family
name" or "X and Slavic family name" or "Slovak family name". The "romanian"
category covers every nmae where the Encyclopedia says "Romanian family name". 


The _broad specifications include some name endings that are specific for either
German or Slavic origin. No such specification exists for Romanian names because
the typical name endings cover some very typical Hungarian frequent names, too

The "jewish name" category comes from the most frequent names (and their variants)
occurring in the Holocaust Victims database. "Most frequent" mean the top100
most frequent names (and their variants) among Holocaust victims (disregarding Hungarian names, 
such as Fekete, Farkas stb.). These account for 40% of the victims in the sample.

Overlaps are possible. Most typically between Jewish and German names. But
other examples exist ("Szeman" can be both of German and Slavic origin)

*/

gen german = 0
gen slavic = 0
gen romanian = 0
gen commonjewishname=0
gen magyarisation_list=0


* top100 names of Jewish holocaust victims without Hungarian names 
foreach s in "Weisz" "Weiss" "Veisz" "Weis" "Wais" "Vais" "Veis" "Waisz" "Veiss" "Waiss"  ///
 "Weish" "Vaisz" "Vaiss" "Klein" "Kleinn" "Kllein" "Schwartz" "Schwarcz"   ///
 "Szwarc" "Svarc" "Schvartz" "Schvarcz" "Shvartz" "Shwarcz" "Schwarc" "Shwartz"   ///
 "Schvarc" "Svarcz" "Svartz" "Swartz" "Schwarts" "Shvarc" "Svarts" "Swarc"   ///
 "Schvarts" "Swarcz" "Szwartz" "Shvarts" "Szwarcz" "Swarts" "Shwarc" "Schvartsz"  ///
 "Schwarcs" "Szvarc" "Friedmann" "Fridman" "Friedman" "Fridmann" "Grosz" "Gross"   ///
 "Gros" "Grossz" "Grosz" "Kohn" "Kon" "Konn" "Kohn" "Kochn" "Deutsch" "Deucz"  ///
 "Deutsz" "Deuts" "Deucs" "Deuetsch" "Deutz" "Krausz" "Kraus" "Krauss" "Kraussz"  ///
 "Fischer" "Fisher" "Fiszer" "Fischher" "Fiser" "Fiszher" "Gluck" "Glueck"   ///
 "Gluck" "Gluck" "Gluk" "Gluk" "Steiner" "Szteiner" "Shteiner" "Schteiner"  ///
 "Berger" "Bergher" "Stern" "Sztern" "Schtern" "Shtern" "Roth" "Rott" "Rot"  ///
 "Roth" "Roht" "Fried" "Frid" "Braun" "Brauen" "Goldstein" "Goldshtein"   ///
 "Goldsztein" "Goldschtein" "Rosenberg" "Rosenberg" "Rosenbergh" "Rossenberg"   ///
 "Spitzer" "Shpitzer" "Spicer" "Szpitzer" "Szpicer" "Schpicer" "Spiczer"   ///
 "Schpitzer" "Spietzer" "Shpitser" "Groszmann" "Grossman" "Grossmann"  ///
 "Groszman" "Grosszmann" "Grosman" "Grosszman" "Grosmann" "Polak" "Pollak"   ///
 "Pollak" "Polyak" "Pollack" "Weinberger" "Veinberger" "Weinbergher" "Katz"  ///
 "Kac" "Kacz" "Kats" "Adler" "Adler" "Guttman" "Guttmann" "Gutman" "Gutmann"   ///
 "Ghutman" "Guthmann" "Guttman" "Grunwald" "Gruenwald" "Gruenvald" "Grunwald"   ///
 "Grunvald" "Grunwald" "Grunvald" "Berkovits" "Berkowicz" "Berkowits" "Berkovitz"   ///
 "Berkovics" "Berkowitz" "Berkovicz" "Berkowitsch" "Berkovic" "Berkowics"   ///
 "Berkowic" "Berkovitsch" "Singer" "Szinger" "Ungar" "Ungar" "Neuman" "Neumann"  ///
 "Neuemann" "Grunfeld" "Gruenfeld" "Grunfeld" "Rosenfeld" "Blau" "Blaue" "Hofman"  ///
 "Hoffmann" "Hoffman" "Hofmann" "Herskovics" "Hershkovitz" "Hershkovits"  ///
 "Herskovits" "Herskowits" "Herskovitz" "Herskovic" "Herszkowicz" "Herschkovits"  ///
 "Herskowicz" "Herschkovicz" "Herschkovics" "Herschkowits" "Hershkowicz"  ///
 "Herskowitz" "Hershkowitz" "Herskowitsch" "Herschkowicz" "Herskovicz" "Herschkowitz"   ///
 "Herskowics" "Herschkovitz" "Hershkovicz" "Herszkowic" "Herskovitsch"  ///
 "Herszkovics" "Herschkowic" "Hershkovics" "Herszkovicz" "Herszkowits"   ///
 "Schwarz" "Swarz" "Schvarz" "Szwarz" "Shwarz" "Svarz" "Shvarz" "Engel"  ///
 "Reich" "Reih" "Feldman" "Feldmann" "Schlesinger" "Slesinger" "Shlesinger"   ///
 "Schlessinger" "Schlesinger" "Sleschinger" "Szlesinger" "Markovics" "Markovits"  ///
 "Markovitz" "Markowitz" "Markowicz" "Markovicz" "Markovic" "Markowic"   ///
 "Markowics" "Markowits" "Markowitsch" "Markovitsch" "Goldberger" "Goldbergher"  ///
 "Moskovits" "Moschkowicz" "Moskovics" "Moskowitz" "Moszkowicz" "Moskovic"   ///
 "Moszkovicz" "Moskovitz" "Moskowits" "Moshkovitz" "Moschkovitz" "Moshkowitz"   ///
 "Moshkovits" "Moskovicz" "Moskowicz" "Moskowic" "Moszkowic" "Moszkovitz"   ///
 "Moskowics" "Abeles" "Abelesz" "Gruenbaum" "Grunbaum" "Grunbaum" "Grunbaum"  ///
 "Loewy" "Loevy" "Lefkovits" "Lefkowicz" "Lefkovics" "Lefkovitz" "Lefkowits"  ///
 "Lefkowic" "Lefkovic" "Lefkovicz" "Lefkowitz" "Lefkowics" "Horovitz" "Horowitz"  /// 
 "Horovic" "Horovits" "Horowic" "Horovicz" "Horowicz" "Horowits" "Frish"   ///
 "Frisch" "Friss" "Friesch" "Fris" "Fries" "Frisz" "Breuer" "Breur" "Frank"   ///
 "Franck" "Mueller" "Muller" "Muller" "Muler" "Muller" "Mueler" "Kaufmann"  ///
 "Kaufman" "Kauffmann" "Kauffman" "Frenkel" "Frenckel" "Fleischmann" "Fleisman"   ///
 "Fleischman" "Fleishman" "Fleiszman" "Fleismann" "Fleishmann" "Fleiszmann"   ///
 "Rosenthal" "Roszenthal" "Rosental" "Rosenthall" "Rosenthal" "Gottlieb"  ///
 "Gotlieb" "Gotlib" "Gottlib" "Altman" "Altmann" "Althmann" "Hirsch" "Hirs"   ///
 "Hirsh" "Hirsz" "Chirs" "Winkler" "Winckler" "Vinkler" "Vinckler" "Lusztig"   ///
 "Lustig" "Fuchs" "Fuchsz" "Mandel" "Lowy" "Lovy" "L owy" "Lovy" "Lowy" "L ovy"   ///
 "Lichtmann" "Lichtman" "Littman" "Littmann" "Liechtman" "Lihtman" "Litman" ///
 "Lihtmann" "Beck" "Bek" "Reisz" "Reis" "Reiss" "Reisch" "Stein" "Shtein" ///
 "Sztein" "Spitz" "Spic" "Szpic" "Shpitz" "Schpitz" "Spits" "Szpitz" "Fuerst" ///
 "Furst" "Furszt" "Furst" "Fursth" "Fuerszt" "Heller" "Heler" "Cheller" ///
 "Davidovics" "Dawidovitz" "Davidovits" "Davidovitz" "Dawidowicz" "Dawidowitsch"  ///
 "Davidovic" "Dawidowic" "Davidowits" "Davidovics" "Dawidowits" "Dawidovits"  ///
 "Dawidowitz" "Davidovicz" "Grun" "Grun" "Gruen" "Grun" "Schreiber" "Shreiber"  ///
 "Sreiber" "Szreiber" "Fleischer" "Fleiszer" "Fleiser" "Fleisher" "Frankl" ///
 "Franckl" "Fränkl" "Frankl" "Reiner" "Reinner" "Reichner" "Fisch" "Fisz" "Fish" ///
 "Fis" "Fiesh" "Fiszh" "Loewinger" "Loevinger" "Lebowicz" "Lebovits" "Lebovics"  ///
 "Lebowits" "Lebovicz" "Lebovitz" "Lebowic" "Lebowitz" "Lebovic" "Lebowics" "Abraham" ///
 "Abraham" "Bauer" "Hartman" "Hartmann" "Bleier" "Bleir" "Kohen" "Kochen" "Lang" ///
 "Lang" "Reichmann" "Reichman" "Gruenberger" "Grunberger" "Grunberger" "Grunnberger" ///
 "Grunberger" "Fogel" "Fogel" "Steinberger" "Schteinberger" "Shteinberger"  ///
 "Steinbergher" "Levi" "Lewi" "Levi" "Hermann" "Herman" "Shtark" "Stark"  ///
 "Sztark" "Schtark" "Salamon" "Shalamon" "Schalamon" "Wolf" "Wolff" "Volf"  ///
 "Kellner" "Kelner" "Haas" "Haasz" "Haass" "Shtraus" "Strausz" "Strauss"  ///
 "Schtraus" "Straus" "Strasszer" "Strasser" "Straser" "Shtraser" "Schtraser"  ///
 "Straszer" "Pollacsek" "Polacsek" "Pollatsek" "Polatschek" "Polatsek"  ///
 "Pollatschek" "Polaczek" "Polacek" "Weiner" "Veiner"  {
 
 
		replace commonjewishname=1 if `1'=="`s'"
 
 }



foreach s in "Bader" "Bader" "Bäder" "Pader" "Padar" "Padar" "Padar" /// 
	"Bajor" "Bayor" "Pajor" "Payor" "Payr" "Bajer" "Bayer" "Bajer" "Bayer" "Bejer" /// 
	"Beyer" "Pajer" "Pajjer" "Payer" "Pajer" "Payer" "Paier" "Peyer" "Peier" /// 
	"Bauer" "Bauer" "Bäuer" "Baur" "Baurer" "Pauer" "Paur" /// 
	"Beck" "Bek" "Bekk" "Bek" "Bäck" "Back" /// 
	"Becker" "Bekker" "Bäcker" "Backer" "Becher" "Pecker" "Pekker" /// 
	"Berger" "Bergel" "Bergely" "Belger" "Perger" "Pergel" "Pergely" /// 
	"B ohm" "Bohm" "Bom" "Bom" "Bomh" "Bomh" "Bohn" "Bohm" "Boehm" /// 
	"Braun" "Braum" "Brun" "Brunn" "Brunn" "Brunn" /// 
	"Brunner" "Bruner" "Prunner" "Pruner" "Pruner" "Brunner" "Brunner" /// 
	"Czigler" "Cigler" "Zigler" "Ziegler" "Cziegler" /// 
	"Czimmermann" "Czimmerman" "Czimermann" "Czimerman" "Czimerman" "Cimerman" /// 
	"Cimmerman" "Cimmermann" "Zimmermann" "Zimmerman" "Zimermann" "Zimerman" /// 
	"Ecker" "Eckert" "Ekker" "Ekkert" "Eckhardt" "Eckhardt" "Eckhart" "Eckhard" "Eckardt" /// 
	"Eckart" "Eckard" "Echardt" "Echart" "Eichardt" "Eichardt" /// 
	"Fischer" "Fiser" "Fisher" "Fischel" /// 
	"Fogel" "Fogel" "Fogl" "Fogl" "Vogel" "Vogel" "Vogl" "Vogl" "Wogel" "Fogel" "F ogel" /// 
	"Frank" "Fränk" "Franck" "Franc" "Frang" "Fraenk" "Frenk" /// 
	"Frei" "Frey" "Frej" "Freij" /// 
	"Fricz" "Fric" "Fritz" "Frits" "Fritcz" "Fritz" "Friz" "Firicz" "Firic" /// 
	"Fridrich" "Fridrik" "Fridrick" "Fridrih" "Friderich" "Friederich" "Friedrich" "Friedrich" "Friedrik" /// 
	"Fiedrik" "Fidrich" "Fidrik" /// 
	"Fuchs" "Fuchsz" "Fucks" "Fucksz" "Fughsz" "Fuks" "Fuksz" "Fux" /// 
	"Geiger" "Geieger" "Gieger" /// 
	"Gerhardt" "Gerhardt" "Gerhard" "Gerhard" "Gerhart" "Gerhat" "Gerhat" "Gerhath" "Gerhadt" /// 
	"Gerhadt" "Gerhar" "Gerard" "Gerald" "Gerath" "Gerat" /// 
	"Glonczi" "Glonczy" "Glonczi" "Glonci" /// 
	"Godor" "Godor" "Godor" /// 
	"Goman" "Goman" "Goman" "Goman" "Gomann" "Gomann" "Gomany" "Gomany" /// 
	"Grosz" "Grosz" "Gross" "Gros" /// 
	"Gruber" "Gruber" "Grubert" "Grubel" /// 
	"Guth" "Guth" "Gut" "Gut" "Gutt" "Guthe" "Gutmann" /// 
	"Hajzler" "Haizer" "Haiser" "Haiszer" "Hauser" "Hauzer" "Häuzer" "Hausherr" "Hausler" /// 
	"Häusler" "Hausser" "Häussler" "Hauszer" "Häuszer" "Hauszler" "Häuszler" "Hauzler" "Heisler" "Heissler" "Heiszer" "Heizler" /// 
	"Hartmann" "Hartman" "Harthmann" /// 
	"Hasz" "Hasz" "Hass" "Hass" "Has" "Has" "Haas" "Haas" "Haass" "Haasz" "Haasz" "Haasz" "Haz" "Haz" "Haaz" "Haaz" /// 
	"Hencz" "Henc" "Hentz" "Henz" "Heincz" "Heinc" "Heintz" "Heinz" /// 
	"Hermann" "Herman" "Herman" "Herman" "Hermann" "Hermany" "Herrmann" /// 
	"German" "German" "Germann" "Germany" "Jermann" "Jerman" /// 
	"Hoffer" "Hofer" "Hofer" "Hoffher" "Hoffherr" "Hofher" "Hofherr" /// 
	"Hoffmann" "Hoffman" "Hofmann" "Hofman" /// 
	"Jager" "Jager" "Jäger" "Jagher" "Jaeger" "Jeager" "Jeger" "Jeger" "Iager" /// 
	"Jung" "Junk" /// 
	"Kaiser" "Kaisser" "Kaiszer" "Kaizer" "Kaizer" "Kajzer" "Kajzer" "Kayser" "Kayzer" "Keiser" /// 
	"Keiszer" "Keizer" /// 
	"Kaltenekker" "Kaltenecker" "Kalteneker" "Kaltenicker" "Kaltanecker" "Kaltaneker" "Kaltneker" "Kaldenekker" "Kaldenecker" "Kaldeneker" "Kaldeneckker" "Kaldeneczker" "Kaldenneker" "Kaldennekker" /// 
	"Keller" "Keler" "Koller" "Kellar" "Kellert" "Kelner" "Kellner" "Kelnar" /// 
	"Kern" "Korn" "Kirn" /// 
	"Keszler" "Kesler" "Kessler" "Kestler" "Kesztler" "Koszler" "Kosztler" "Kossler" "Kostler" "Kiszler" "Geszler" "Gesler" /// 
	"Klein" "Kleine" "Klain" "Klajn" /// 
	"Koch" "Koch" "Koh" "Koh" "Kock" "Kok" "Kok" "Kokk" "Coc" "Cok" "Kock" "Kok" /// 
	"Koller" "Koller" /// 
	"Kramer" "Kramer" "Krämer" "Krammer" "Krammer" "Krämmer" "Krammel" "Kremer" /// 
	"Kremer" "Kremmer" /// 
	"Kranicz" "Kranitz" "Kranic" "Kranicz" "Kranitz" "Granicz" "Granitz" "Granic" "Gränitz" /// 
	"Krausz" "Kraus" "Krauss" "Grausz" "Krusch" "Kruse" "Kruss" "Krusze" /// 
	"Kreisz" "Kreisz" "Kreiss" "Kreis" "Kreisch" "Kreicz" "Kreitz" "Krejz" "Kraiss" "Kraisz" "Kraicz" "Kraitz" "Kraic" "Krajc" "Krajcz" /// 
	"Lakner" "Lackner" "Lachner" "Lahner" "Lahner" /// 
	"Lang" "Läng" "Lange" "Langh" /// 
	"Lechner" "Lehner" "Lehner" "Lener" "Lener" "Lenner" "Lekner" /// 
	"Ludvig" "Ludvigh" "Ludwig" "Ludwigh" "Ludvik" /// 
	"Majer" "Majer" "Mayer" "Mayer" "Mayr" "Maier" "Mayher" "Mayherr" "Meyer" /// 
	"Mejer" "Meijer" /// 
	"Mozer" "Mojzer" "Mozer" "Moser" "Moser" "Moser" "M oser" /// 
	"Muller" "Muller" "Mullher" "Miller" "Moller" "Moller" "Mullner" "Mulner" "Mullner" "Millner" "Milner" /// 
	"Pfeifer" "Pfeiffer" "Pfejfer" "Pfeffer" "Pfiffer" "Pfaifer" "Pfaiffer" "Peifeer" "Peffer" "Peiper" "Feifer" "Feiffer" "Fejfer" /// 
	"Piller" "Piller" "Piler" "Pieller" "Pieler" "Pillar" "Pilar" "Pilar" /// 
	"Richter" "Rikter" /// 
	"Roth" "Roth" "Rot" "Rot" "Rott" "Rott" "Rauth" "Roth" "Roth" "Rot" "Rott" /// 
	"Rozman" "Rozman" "Rozmann" "Rozman" "Roszmann" "Roszman" "Rosman" "Rosmann" /// 
	"Rossman" "Rossmann" /// 
	"Ruff" "Ruf" /// 
	"Scheffer" "Schäffer" "Schäfer" "Schaffer" "Schafer" "Scheffer" "Schefer" "Schefer" "Schaeffer" "Schaeffer" "Schaefer" /// 
	"Seffer" "Sefer" "Seffer" "Sefer" "Seper" /// 
	"Schmidt" "Schmidth" "Schmid" "Schmidt" "Schmitt" "Schmied" "Smied" "Schmiedt" "Smidt" /// 
	"Smidth" "Smit" "Smith" "Smitt" "Smid" /// 
	"Schneider" "Schneider" "Sneider" "Snejder" "Schneidler" "Snajder" "Snajder" /// 
	"Schultheisz" "Schultheiss" "Schultheis" "Schulteis" "Schulteisz" "Schultes" "Schultesz" "Scholts" "Scholtz" /// 
	"Scholz" "Schulcz" "Schultz" "Schulz" "Schulc" "Sulcz" "Sulc" "Schutz" /// 
	"Schwarcz" "Schwartz" "Schwartcz" "Schwarz" "Schvarcz" "Schvartz" "Schvarc" /// 
	"Schwarch" "Schvarz" "Swarcz" "Swartz" "Svarcz" "Svarc" /// 
	"Soter" "Soter" "Soter" "Schotter" "Sotter" "Zsoter" "Zsoter" "Zsoter" /// 
	"Stadler" "Stadler" /// 
	"Steiner" "Steiner" /// 
	"Suszter" "Schuszter" "Schuster" "Suster" /// 
	"Szeman" "Szeman" "Szeman" "Szemann" "Szeman" "Szemann" "Zeman" "Zeman" "Zeman" /// 
	"Zeman" "Zemann" "Zemann" "Zemann" /// 
	"Unger" "Ungar" "Ungar" /// 
	"Valter" "Walter" "Walther" "Walter" "Volter" "Volter" /// 
	"Veisz" "Weisz" "Weiss" "Veis" "Weis" "Vaisz" "Vajsz" "Vajsz" /// 
	"Vinkler" "Winkler" "Vinkler" /// 
	"Wagner" "Wagner" "Vagner" "Vagner" /// 
	"Weber" "Weeber" "Wieber" "Veber" "Veber" "Weber" "Webber" /// 
	"Wolf" "Wolff" "Wollf" "Wolf" "Wolff" "Wulf" "Wulff" "Volf"  {

	
	replace german=1 if `1'=="`s'" & commonjewishname==0
	
}



foreach s in "Aleksza" "Alexa" "Aleksa" "Alaksza" "Alaksa" "Oleksza" "Olexa" "Oleksa" ///
	"Banko" "Banko" "Banko" ///
	"Banszki" "Banszky" ///
	"Bencsik" "Bentsik" "Bencsik" "Benczik" "Bencik" "Bencik" ///
	"Blasko" "Blasko" "Blassko" "Blaschko" "Balasko" "Balasko" ///
	"Bozsik" "Bozsik" "Bazsik" "Buzsik" "Bozik" "Bozic" ///
	"Czako" "Czako" "Cako" "Cako" ///
	"Czene" "Cene" "Czane" "Czina" "Czine" ///
	"Csernak" "Csernak" "Csernyak" "Csermak" "Czernak" "Czermak" ///
	"Franko" "Franko" "Franko" "Franku" "Franco" ///
	"Gombar" "Gombar" "Gambar" ///
	"Gyuricza" "Gyurica" "Gyuritza" "Juricza" "Jurica" "Djurica" ///
	"Gyuris" "Gyuris" "Gyuriss" "Gyurisch" "Juris" "Jurisch" "Jurys" "Djuris" ///
	"Gyurko" "Gyurko" "Gyurko" "Jurko" "Jurko" ///
	"Gyurkovics" "Gyurkovits" "Gyurkovich" "Gyurokovics" "Gyurokovics" "Jurkovics" "Jurkovits" "Jurkovich" "Jurgovics" ///
	"Hamza" "Hamzah" "Hamzau" "Hamzsa" ///
	"Hanko" "Hanko" ///
	"Hornyak" "Hornyak" "Hornyiak" "Horniak" "Hornak" ///
	"Hrabovszki" "Hrabovszky" "Hrabowszky" "Hrabowsky" "Hrabovszy" "Hraboczki" "Hraboczky" ///
	"Hraboczki" "Hrabolszki" "Hraboszki" "Hraboszki" "Raboczki" "Raboczky" "Raboczki" "Rabocki" "Rabocki" ///
	"Raboczki" "Raboczki" "Raboczky" "Raboczky" "Raboczky" "Raboczi" "Raboczy" "Raboci" "Raboci" "Grabovszki" ///
	"Grabovszky" "Grabovski" "Grabowski" ///
	"Hudak" "Hodak" "Hudak" "Hugyak" "Hugyak" ///
	"Hudecz" "Hudec" "Hudetz" "Hugyecz" "Hugyec" "Hugyecz" "Hugyetz" ///
	"Huszka" "Husska" "Guska" ///
	"Ivanics" "Ivanits" "Ivanics" "Ivanits" "Ivanich" ///
	"Jankovics" "Jankovits" "Jankovich" "Jankovics" "Jankovitsch" "Jankovity" ///
	"Kiszel" "Kiszely" "Kiszely" "Kiszelly" "Kiszely" "Kiszaly" "Kisely" "Kiszeli" "Kiszelyi" "Kiszil" "Kiszl" ///
	"Koczan" "Kocan" "Koczan" "Kocan" "Koczan" "Koczian" "Kocian" "Koczian" "Kocian" ///
	"Kocziany" "Kocziany" "Kotzian" "Kotzian" "Kotczian" "Kotcian" "Kotcian" ///
	"Koleszar" "Kolesar" "Kolesar" "Koloszar" "Kolozar" ///
	"Kollar" "Kollar" "Kolar" "Kolar" ///
	"Kolonics" "Kolonits" "Kolonich" "Kolonych" ///
	"Komar" "Komar" "Kommar" "Kumar" "Kumar" ///
	"Koncsek" "Kontsek" "Koncseg" "Koncsak" "Koncsag" "Kontsag" "Koncsak" "Koncsok" "Koncsik" "Koncsik" "Kontsik" ///
	"Kosik" "Kosik" "Koschik" "Kosich" "Kossik" "Kossich" ///
	"Koszta" "Costa" "Kosztya" ///
	"Kovacsics" "Kovacsits" "Kovacsich" "Kovacsity" "Kovacsics" "Kovacsits" "Kovatsits" "Kovatsits" ///
	"Kowaczics" ///
	"Kralik" "Kralik" "Klarik" "Ralik" ///
	"Kriston" "Kriszton" ///
	"Kucsera" "Kutsera" "Kutschera" "Kucsara" "Kucsere" "Kucsora" ///
	"Lehoczki" "Lehoczky" "Lehoczki" "Lehoczky" "Lehocki" "Lehocky" "Lehocki" "Lehocky" ///
	"Lehotzki" "Lehotzky" "Lehotzky" "Lehotsky" "Lehotszky" "Lehoszki" "Lehoszki" "Lehoszki" "Slehovszki" "Slehoczki" ///
	"Slehoczki" ///
	"Lezsak" "Lezak" "Slezsak" "Slezak" "Slezak" "Szlezak" ///
	"Liptak" "Liptak" ///
	"Maczko" "Maczko" "Macko" "Macko" "Matzko" ///
	"Majzik" "Mojzik" "Mojzsik" ///
	"Makula" "Machula" "Macula" ///
	"Malik" "Malik" "Malyik" "Malyik" ///
	"Maraz" "Maraz" "Marasz" "Marasz" "Maracz" "Marac" "Maratz" "Maracz" "Mraz" "Mraz" ///
	"Markovics" "Markovits" "Markovich" "Markovics" "Markovits" "Markovych" ///
	"Mihalik" "Michalik" "Mihalik" "Mihalik" "Mihalyik" "Mihalyik" "Mihalek" ///
	"Mihalovics" "Mihalovits" "Michalovics" "Mihalovics" "Mihalovits" "Mihaljovics" ///
	"Milak" "Milak" "Milak" ///
	"Novak" "Novak" "Novagh" "Nowak" "Nowak" "Nowack" ///
	"Oravecz" "Oravetz" "Orawetz" "Oravec" "Oravicz" "Oravacz" "Orovecz" "Orovetz" "Orovec" ///
	"Orovicz" "Orovitc" ///
	"Palkovics" "Palkovits" "Palkovity" "Palkovich" "Palakovics" "Palakovits" "Palakovics" ///
	"Paulik" "Pauwlik" "Pavlik" "Pavlik" "Pawlik" ///
	"Paulovics" "Paulovits" "Paulovich" "Palovics" "Palovits" "Palovics" "Palovits" "Pallovics" "Pallovits" "Polovics" "Polovits" "Palavics" "Palyovits" "Pavlovics" "Pavlovits" "Pavlovity" "Pavlovich" ///
	"Petrik" "Petrick" "Petrik" ///
	"Petro" "Petro" "Petrou" ///
	"Petrovics" "Petrovits" "Petrovity" "Petrovich" "Petrovych" "Petrovszki" "Petrovszky" "Petrovszki" "Petrovszky" "Petrovski" "Petroszki" "Petroszky" "Petroszki" "Petroczki" "Petroczky" "Petrocki" "Petroczki" "Petroczky" "Petrocki" ///
	"Popovics" "Popovics" "Popovits" "Popovitsch" "Popovitch" "Popovych" "Popowitsch" "Poppovits" ///
	"Prokaj" "Prokaj" "Prokaj" "Prokai" "Prokay" "Prokai" "Prokay" "Prokaji" "Prokaji" "Prokkai" ///
	"Puporka" ///
	"Radics" "Radits" "Radity" "Radics" "Radity" "Radich" "Radics" ///
	"Rusznyak" "Rusznak" "Rusznyak" "Rusznak" "Ruszinyak" "Russnak" "Russnak" "Rusnak" "Rusnak" ///
	"Rusnyak" "Rusnac" ///
	"Ruszo" "Ruszo" "Ruszu" "Ruszo" "Russzo" "Ruso" "Russo" "Russo" ///
	"Spisak" "Spischak" "Spisjak" "Spissak" "Spiszak" "Szpisak" "Szpisjak" "Szpisjak" "Szpiszak" "Pisak" "Pischak" "Pisak" "Pisiak" "Pisjak" ///
	"Suha" "Soha" "Suhaj" "Suhai" ///
	"Suhajda" "Sohajda" "Sohajda" ///
	"Szedlak" "Szedljak" "Szedljak" "Sedlak" ///
	"Szeman" "Szeman" "Szeman" "Szemann" "Szeman" "Szemann" "Zeman" "Zeman" "Zeman" ///
	"Zeman" "Zemann" "Zemann" "Zemann" ///
	"Szikora" "Szikora" "Szikora" "Szikura" "Szikula" "Sikora" "Sikura" "Sikora" "Czikora" "Czikora" ///
	"Slavik" "Szlavik" ///
	"Sztojka" "Sztojka" "Sztolyka" ///
	"Terdik" "Terdig" ///
	"T orocsik" "T or ocsik" "Torocsik" ///
	"Turcsan" "Turtsan" "Turcsany" "Turcsan" "Turchan" "Turchany" ///
	"Uhrin" "Ugrin" ///
	"Vidak" "Vidak" {
		
	replace slavic=1 if `1'=="`s'"
	
}


foreach s in "Abander" "Abt" "Achim" "Acht" "Achtum" "Ackermann" "Adamoczki" "Aigner" "Albecker" "Albert" "Albitz" "Almann" "Ament" "Amrein" "Amsel" "Andele" "Anderlik" "Angermann" "Antl" "Artinger" "Aschenbrenner" "Assmann" "Auer" "Auerbach" "Auffenberg" "Aufmuth" "Augner" "Babijak" "Bach" "Baches" "Backstadter" "Bader" "Baldauf" "Bamberger" "Bartolf" "Bartolff" "Bauer" "Baumann" "Baumgartner" "Baumgartner" "Baumler" "Bayer" "Bayer" "Beck" "Beck" "Becker" "Beile" "Bejcek" "Belenyak" "Belsius" "Bencik" "Bendpak" "Benke" "Benkert" "Benkner" "Berger" "Bernhard" "Bernstein" "Bertsche" "Bertl" "Bertschi" "Betzner" "Bier" "Bierbauer" "Bierbrauer" "Biesinger" "Bissinger" "Bilder" "Binder" "Biermann" "Bischitz" "Bischof" "Bittenbinder" "Bittner" "Blasko" "Blaszko" "Bleyer" "Bloch" "Blum" "Blumenschein" "Blumental" "Bock" "Boda" "Bodemann" "Bohm" "Bohn" "Boncsek" "Borszuk" "Brachfeld" "Brambauer" "Brand" "Brandstatter" "Braun" "Brauer" "Brasberger" "Breier" "Brenner" "Brentano" "Brindzik" "Britvecz" "Bruckner" "Brull" "Bruncznieder" "Brunner" "Brust" "Brzobohati" "Bubelenyi" "Buchardt" "Buhhardt" "Buchgraber" "Buchner" "Buchwald" "Burghoffer" "Burst" "Buttel" "Cagany" "Celhan" "Celleng" "Chernak" "Chrismar" "Christ" "Christmann" "Csemann" "Csermanek" "Csiszler" "Czorn" "Zorn" "Dachs" "Danielovits" "Dein" "Demser" "Demus" "Deutsch" "Deutsch" "Deutsch" "Dewald" "Diener" "Dieter" "Dietsche" "Dietl" "Dietz" "Dietzgen" "Dobra" "Dobrovitz" "Dolak" "Dorn" "Dorner" "Draxler" "Drexler" "Drevenka" "Durst" "Dutko" "Dux" "Eberling" "Ebner" "Ebner" "Ecker" "Ecker" "Egermann" "Ehrenreiter" "Ehrlich" "Eibl" "Eichhardt" "Eichholz" "Eigner" "Eisen" "Eisenacker" "Eisenbarth" "Eisenhoffer" "Ellenbogen" "Engelbert" "Engelhardt" "Englert" "Englerth" "Engstner" "Eppel" "Erb" "Escandeli" "Falkonberg" "Fassbinder" "Faul" "Faulhaber" "Faustig" "Feger" "Fehrenthert-Gruppenberg" "Feil" "Felsmann" "Ferber" "Fernbach" "Fersch" "Ferwagner" "Fichtner" "Fieder" "Fiedler" "Filips" "Filsinger" "Fink" "Finster" "Firtl" "Fischer" "Fischer" "Flamich" "Fleckenstein" "Fleischmann" "Folk" "Follath" "Frank" "Frankl" "Freisinger" "Freistadtl" "Freud" "Freyberger" "Friebeiß" "Friedreich" "Frim" "Frischauf" "Fritsch" "Fritschek" "Fritz" "Frommer" "Fruhwirth" "Frummer" "Fuchs" "Fuchsberger" "Fuhrer" "Furst" "Fuß" "Gabel" "Galcik" "Gallik" "Gaidler" "Galler" "Ganz" "Gaschler" "Gauss" "Geist" "Georgi" "Gerhardt" "Geringer" "Gerstl" "Gerstmann" "Gerstner" "Gertswaller" "Getzler" "Geyer" "Gier" "Giergl" "Gießer" "Gilmayer" "Glitsch" "Glock" "Glutsch" "Glitsch" "Goebel" "Goldbecher" "Goldberger" "Goldhammer" "Goldmann" "Goldschmid" "Goldstein" "Golenyak" "Goller" "Golnhofer" "Gonauer" "Gorger" "Gottlieb" "Gottrich" "Graefl" "Gerstl" "Gobl" "Gorbitz" "Gregor" "Gregus" "Greguš" "Greitner" "Gress" "Grieser" "Grieshaber" "Grimm" "Grop" "Grosch" "Groschl" "Groß" "Groszmann" "Großschmid" "Großschmied" "Gruber" "Grun" "Grunbaum" "Grunfeld" "Grunstein" "Grunwald" "Grunzweig" "Gschmeidler" "Gschwandtner" "Gudra" "Gulden" "Gungl" "Gunther" "Gut" "Guth" "Guttmann" "Gyungya" "Gyurcsek" "Gyurcsik" "Haas" "Haaser" "Haaß" "Haberfeld" "Habony" "Hackl" "Hackspacher" "Hagemann" "Hahn" "Hak" "Halbschuh" "Halmer" "Haltmayer" "Hambach" "Hamburger" "Hammer" "Hampel" "Hando" "Handtel" "Hannes" "Happ" "Harrach" "Hart" "Hartlein" "Hartmann" "Hartstein" "Hasenfratz" "Hauer" "Hauptmann" "Hausknecht" "Hausmann" "Hautzinger" "Hauser" "Hechtl" "Heckler" "Heckmann" "Heer" "Heidelberg" "Heidinger" "Heilmann" "Heinemann" "Heinrich" "Heiser" "Helfer" "Hellebrandt" "Heller" "Heltau" "Heltebrand" "Helter" "Helth" "Hepp" "Herbst" "Hergenroder" "Herik" "Heringer" "Herklein" "Herling" "Hermann" "Hery" "Herzig" "Herzog" "Hess" "Hilpert" "Himmelstein" "Hinek" "Hinterscheck" "Hirsch" "Hirschl" "Hirschmann" "Hoch" "Hochhaus" "Hock" "Hoffmann" "Hofstatter" "Hohl" "Hohmann" "Holdampf" "Holzbauer" "Holzmann" "Holzmeister" "Horcher" "Horn" "Hory" "Hoschke" "Huber" "Hubert" "Hubl" "Hund" "Hundt" "Hoso" "Hugyec" "Hungler" "Hunsdorfer" "Huj" "Hupcik" "Hverda" "Ihracska" "Ispaits" "Ivanic" "Ivanski" "Jagedics" "Jager" "Jager" "Jahrmann" "Jahrmann" "Jamrik" "Janaroczki" "Jandl" "Janina" "Janus Pannonius" "Jelleke" "Jessenski" "Jilling" "Jobst" "Jorde" "Jung" "Junghans" "Kabda" "Kah" "Kahler" "Kaiser" "Kaizer" "Kaitan" "Kaltenbrunner" "Kaltenecker" "Kammerlauf" "Kampner" "Kann" "Kahn" "Kanzler" "Kapeller" "Kapp" "Kappenberger" "Kapplmayer" "Karner" "Kassner" "Katzenbach" "Kaufeld" "Kaufmann" "Kauker" "Kauremski" "Kauser" "Keil" "Keller" "Kellner" "Kempf" "Kenzler" "Kern" "Kerner" "Kerstner" "Khuen" "Kindler" "Kirchner" "Kirnbauer" "Kittenberger" "Klagyivik" "Klassek" "Klauber" "Klaus" "Klein" "Kleiner" "Klenner" "Klette" "Klettner" "Klimek" "Klinger" "Klitsch" "Klujber" "Knapp" "Knauß" "Kneiß" "Knipf" "Knoll" "Koder" "Koessler" "Kohaut" "Kohler" "Kohl" "Kohlberger" "Kohler" "Kohlmann" "Kohn" "Kollar" "Koller" "Konig" "Konrad" "Koppstein" "Korach" "Korn" "Kornfeld" "Korngut" "Kosch" "Kositzky" "Kracik" "Krakker" "Kral" "Kralik" "Kramer" "Kramer" "Krammerlauf" "Kranzinger" "Kassl" "Kramer" "Kratochwill" "Kraus" "Krauter" "Krebs" "Kreiner" "Kreis" "Kremsner" "Krenac" "Krenmuller" "Krenner" "Krepalek" "Kress" "Kretz" "Kriesch" "Krimpelbein" "Krippel" "Kriesinger" "Kristinkovic" "Krizsanovits" "Kronberger" "Kroneck" "Kroner" "Krug" "Kruhl" "Kudla" "Kuhl" "Kuhtreiber" "Kunczer" "Kungl" "Kunst" "Kunstler" "Kupfer" "Kupricz" "Kurz" "Kußbach" "Lack" "Lacka" "Lamperth" "Lang" "Langer" "Laub" "Laubert" "Lauter" "Lebenguth" "Lechner" "Leber" "Lederer" "Lee" "Lehmann" "Lehner" "Lehr" "Leicher" "Leimeister" "Leimeter" "Leinwater" "Leip" "Leiter" "Leitersdorfer" "Leitgeb" "Leitzinger" "Lenk" "Lenz" "Leopold" "Lerk" "Lerner" "Leszkovics" "Libertenyi" "Lichanec" "Lichtenecker" "Lichter" "Lieb" "Liebe" "Liebenberg" "Liebenberger" "Lieber" "Lindenmayer" "Lindwirm" "Ling" "Lingauer" "Lingl" "Link" "Lip" "Liptak" "Liskovski" "List" "Listner" "Litschauer" "Lobenwein" "Loffler" "Lofing" "Losteiner" "Luif" "Lung" "Luzenbacher" "Macc" "Mader" "Mahler" "Mahr" "Mailath" "Majdon" "Makso" "Malarik" "Maleth" "Mammel" "Mandel" "Mann" "Marek" "Markovic" "Marksteiner" "Marmorstein" "Marosan" "Martin" "Martinkovics" "Marx" "Marusan" "Masek" "Math" "Mathias" "Matheis" "Matz" "Maurer" "Mayer" "Meier" "Mayer-Rubcsics" "Meck" "Meckler" "Mehringer" "Meilinger" "Meiner" "Meinhardt" "Meinzinger" "Meister" "Melich" "Meliher" "Mensiger" "Mercz" "Merz" "Mergl" "Merk" "Merkert" "Merklein" "Meßner" "Metzger" "Meyer" "Miedner" "Mihalek" "Mikušcak" "Millich" "Milter" "Miltz" "Mistl" "Mittag" "Monger" "Moser" "Mosert" "Mraz" "Mrazik" "Muhr" "Mukahirn" "Muhl" "Muller" "Muller" "Muller" "Munk" "Munzer" "Musil" "Musto" "Naroda" "Narr" "Natta" "Navradi" "Navratil" "Neff" "Neidhardt" "Netzl" "Neumann" "Neumann" "Neuwirth" "Nick" "Nicolaides" "Nimpfer" "Noll" "Novak" "Nussbeck" "Nusser" "Oberritter" "Oesterreicher" "Oppenauer" "Oravetz" "Ortmayr" "Osl" "Osterbauer" "Ostertag" "Ostheimer" "Oxenmayer" "Ochsenmayer" "Pacnik" "Pajer" "Palica" "Pallavicini" "Palmer" "Pappert" "Payer" "Passmann" "Paulics" "Paus" "Pavelcze" "Peel" "Pehl" "Pehm" "Peltzer" "Pemsek" "Peng" "Pentz" "Penyaska" "Perger" "Perndl" "Peternics" "Petrich" "Petrovics" "Philips" "Pfandler" "Pfannschmidt" "Pfeffer" "Pfendtner" "Pfennig" "Pfer" "Pfister" "Pfistner" "Pfluger" "Pichler" "Pick" "Piller" "Pinczinger" "Pinczker" "Pinz" "Pichocker" "Pirint" "Plattner" "Platzer" "Pleva" "Pohl" "Pollich" "Poszpihal" "Potisek" "Preißberger" "Priegl" "Priska" "Primus" "Probstl" "Prossammer" "Pšenak" "Puchinger" "Pur" "Purgstaller" "Purzfeld" "Putz" "Quenz" "Quintz" "Rackh" "Radakovits" "Radankovits" "Reiner" "Rangoni" "Rapczok" "Rappensberger" "Rasch" "Rauch" "Rechner" "Redling" "Rehr" "Reich" "Reichenbach" "Reif" "Reindl" "Reinfort" "Reis" "Reiser" "Reisinger" "Reißner" "Reiter" "Reizinger" "Reperger" "Rehberger" "Resch" "Resner" "Rheinfuss" "Richter" "Richter" "Rieberger" "Riegler" "Rieß" "Rikker" "Rikter" "Rintel" "Rippl" "Ripsam" "Ritschmann" "Ritz" "Rohlich" "Rohrbacher" "Roll" "Roller" "Rosenfeld" "Rosenthal" "Rosenzweig" "Roskovics" "Rossmann" "Roth" "Rothauser" "Rothbaum" "Rotkrepf" "Rottenbiller" "Rottenbucher" "Ruck" "Ruckert" "Ruff" "Rumpel" "Ruzicska" "Sachs" "Saile" "Sam" "Samwald" "Santner" "Sass" "Sauerwein" "Sawel" "Sax" "Schabitz" "Schack" "Schaffer" "Schaffner" "Schaffrer" "Schalbert" "Schalk" "Schalkhammer" "Schalkhas" "Schalmayer" "Scharenpeck" "Schartz" "Scheck" "Schedel" "Scheff" "Scheffer" "Scheibelhoffer" "Scheiber" "Scheider" "Scheiling" "Schemiz" "Schenk" "Schenker" "Scherer" "Scherfleck" "Schermann" "Schettrer" "Scheuer" "Scheuring" "Schierling" "Schiff" "Schiller" "Schillinger" "Schilzong" "Schimert" "Schlegel" "Schleger" "Schlesinger" "Schlier" "Schlosser" "Schlotterberk" "Schmid" "Schmidt" "Schmierl" "Schmittauer" "Schmolz" "Schneider" "Schneller" "Schnellbach" "Schockl" "Schober" "Schobert" "Schoblocher" "Schoffer" "Scholtes" "Scholtz" "Schondl" "Schonbach" "Schenbach" "Schonbauer" "Schonberger" "Schonweis" "Schopf" "Schorn" "Schrank" "Schreck" "Schrock" "Schrempf" "Schrempner" "Schrenk" "Schriffert" "Schrock" "Schuck" "Schulhof" "Schuller" "Schuller" "Schultheiß" "Schunk" "Schussler" "Schuster" "Schuster" "Schutt" "Schutzenberger" "Schwab" "Schwalb" "Schwartz" "Schwarz" "Schwarz" "Schwarzel" "Schwarzer" "Schwartzkopf" "Schweier" "Schweiger" "Schweighofer" "Schweizer" "Schwertz" "Schwing" "Seelig" "Seemann" "Sehy" "Seibert" "Seibold" "Seidenleder" "Seidl" "Seiler" "Seili" "Seitz" "Seliger" "Semmelweis" "Seyer" "Sibiniani" "Sieber" "Siedl" "Simanek" "Singer" "Sinnreich" "Silberberg" "Silberstein" "Solomayer" "Sonnenberger" "Sonnenschein" "Sonntag" "Sopper" "Sorcik" "Sorik" "Spak" "Specht" "Spiegel" "Spielmann" "Spiller" "Spindl" "Spitzer" "Sprau" "Stadler" "Stahl" "Stampf" "Stand" "Stangl" "Stark" "Staß" "Staudinger" "Staudner" "Stefan" "Steiber" "Steigerwald" "Steinacker" "Steinbacher" "Steiner" "Steingassner" "Stenger" "Stephan" "Sterbenz" "Stern" "Steyerhoffer" "Stiller" "Stockl" "Stolar" "Stomp" "Storbeck" "Stramba" "Strasser" "Strassneff" "Straubinger" "Strauß" "Strba" "Streli" "Striebl" "Strigens" "Strobl" "Strohmayer" "Stroka" "Stroß" "Strumpf" "Studer" "Stulfa" "Stummer" "Stumpf" "Sturtz" "Stummer" "Subic" "Sumser" "Sused" "Szapucsek" "Szedlak" "Szeidenleder" "Szieber" "Sziedl" "Szloboda" "Szopper" "Sztraska" "Tagscherer" "Tahony" "Tallmayer" "Tannenbaum" "Tannhauser" "Tanner" "Tanzer" "Taugner" "Tauser" "Taussig" "Teichengraber" "Teichter" "Teigler" "Telch" "Theiler" "Theiß" "Thurmayer" "Tiegelmann" "Tilesch" "Tischler" "Tischner" "Titzl" "Tofeus" "Tomek" "Tonigold" "Tossenberger" "Toth" "Trabert" "Trajbiar" "Trankler" "Trautmann" "Trautner" "Trebes" "Treiber" "Tremmel" "Trenka" "Trethan" "Tressel" "Tretter" "Tricad" "Tringer" "Trisner" "Tripammer" "Trischler" "Trostler" "Tunkel" "Ulicka" "Umek" "Utz" "Uitz" "Ultenmuller" "Unternehrer" "Vamberger" "Vanczer" "Vanek" "Vater" "Vavrek" "Veigli" "Veigelsberg" "Venetianer" "Verhas" "Vessely" "Vilimi" "Viskardi" "Vopicka" "Vogel" "Vogelsinger" "Volum" "Wachsmann" "Wachtelschneider" "Wagner" "Walper" "Wamberger" "Wanzer" "Weber" "Webermann" "Wech" "Wederlehner" "Weigel" "Weigl" "Weiler" "Weimer" "Weinberger" "Weinper" "Weiß" "Weißhaar" "Weißwasser" "Welmer" "Weltner" "Wentz" "Werstroh" "Wesan" "Wesner" "Wiedmann" "Wiegler" "Wiesner" "Wildanger" "Wildschutz" "Wilhelm" "Windauer" "Windischmann" "Winkler" "Wirth" "Wiskidensky" "Wittmann" "Wittwindisch" "Wolf" "Wolff" "Wollner" "Wuhrl" "Wunder" "Wurth" "Zapotnik" "Zehetmayer" "Zeitler" "Zeller" "Zelmann" "Zemmel" "Zenger" "Zepf" "Ziegelbach" "Ziegler" "Ziegler" "Ziegelmaier" "Zierbusch" "Zierfuß" "Zima" "Zirkelbach" "Zirner" "Zogler" "Zsidakovits" "Zullich" "Zwick" "Beyer" "Freund" "Hory" "Keizer" "Kail" "Kripl" "Mejer" "Reisser" "Sahm" "Seeliger" {
	
	
		replace magyarisation_list=1 if `1'=="`s'" & commonjewishname==0 & german==0 & slavic==0 // a list of German, Jewish and Slavic surnames which were magyarised (from a document)

	
}



foreach s in "Argyelan" "Argyelan" "Argyellan" "Argyellan" "Argyilan" "Argyilan" "Ardelan" "Ardelan" "Ardelean" "Ardelean" "Ardelean" ///
	"Krizsan" "Krizsan" "Krisan" "Krisan" "Krizsany" "Kirizsan" "Crisan" "Crisan" "Crijan" ///
	"Marosan" "Marosan" "Marosian" "Marozsan" "Marusan" "Marusan" "Mrsan" "Mrsan" ///
	"Moldovan" "Moldovan" "Moldvan" "Moldvany" "Moldvan" ///
	"Serban" "Serban" "Serbany" "Sereban" "Cserban" "Cserban"  {

	replace romanian=1 if `1'=="`s'"

}



gen german_broad=german
gen slavic_broad=slavic
gen romanian_broad=romanian

* jolly joker: names ending in *er and *mann with some frequent Hungarian exceptions
replace german_broad=1 if substr(`1',-2,2)=="er"&`1'!="Cser"&`1'!="Mester"&`1'!="Peter" & commonjewishname!=1
replace german_broad=1 if substr(`1',-4,4)=="mann"&`1'!="Cser"&`1'!="Mester"&`1'!="Peter" & commonjewishname!=1
replace german_broad=1 if substr(`1',-3,3)=="man"&`1'!="Cser"&`1'!="Mester"&`1'!="Peter" & commonjewishname!=1

* jolly joker: "-ics" & "-k" & exeptions
replace slavic_broad=1 if substr(`1',-2,2)=="ik"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-2,2)=="ek"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-3,3)=="ik"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-3,3)=="ak"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-3,3)=="ics"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-3,3)=="ich"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-3,3)=="its"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-3,3)=="ski"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-4,4)=="szki"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-4,4)=="szky"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"
replace slavic_broad=1 if substr(`1',-5,5)=="itsch"&`1'!="Deak"&`1'!="Elek"&`1'!="Csik"&`1'!="Csik"&`1'!="Izsak"&`1'!="Ersek"&`1'!="Telek"&`1'!="Mak"&`1'!="Fridrich"&`1'!="Ehrlich"&`1'!="Rak"



* no jolly joker
replace romanian_broad=1 if substr(`1',-3,3)=="an"
replace romanian_broad=1 if substr(`1',-2,2)=="an"
replace romanian_broad=1 if substr(`1',-1,1)=="u"


