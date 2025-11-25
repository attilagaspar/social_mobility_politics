
gen periods=-1 if inrange(year,1825,1848)
replace periods=0 if inrange(year,1849,1866)
replace periods=1 if inrange(year,1867,1879)
replace periods=2 if inrange(year,1880,1889)
replace periods=3 if inrange(year,1890,1899)
replace periods=4 if inrange(year,1900,1909)
replace periods=5 if inrange(year,1910,1918) // WW1 and pre-Trianon
replace periods=6 if inrange(year,1919,1933) // long-lasting depression Luijkx Et al 2002
replace periods=7 if inrange(year,1934,1945) // The long WW2 Luijkx Et al 2002
replace periods=8 if inrange(year,1946,1956) // The long 50s Luijkx Et al 2002
replace periods=9 if inrange(year,1957,1967) // The long 50s Luijkx Et al 2002
replace periods=10 if inrange(year,1968,1982) // Reform Socialism Luijkx Et al 2002
replace periods=11 if inrange(year,1982,1989) // Decline of Socialism Luijkx Et al 2002
replace periods=12 if inrange(year,1990,1999) // Early Transition 
replace periods=13 if inrange(year,2000,2009) // Early EU
replace periods=14 if inrange(year,2010,2018) // Orban


label define periods -1 "1825-48" 0 "1849-66" 1 "1867-79" 2 "1880-89" 3 "1890-99" 4 "1900-09" 5 "1910-18" 6 "1919-33" 7 "1934-45" 8 "1946-56" 9 "1957-67" 10 "1968-82" 11 "1983-89" 12 "1990-99" 13 "2000-09" 14 "2010-18", replace
label values periods periods
