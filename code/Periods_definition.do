gen periods=-7 if inrange(year,1760,1789)
replace periods=-6 if inrange(year,1790,1799)
replace periods=-5 if inrange(year,1800,1809)
replace periods=-4 if inrange(year,1810,1819)
replace periods=-3 if inrange(year,1820,1829)
replace periods=-2 if inrange(year,1830,1839)
replace periods=-1 if inrange(year,1840,1848)
replace periods=0 if inrange(year,1849,1866)
replace periods=1 if inrange(year,1867,1879)
replace periods=2 if inrange(year,1880,1889)
replace periods=3 if inrange(year,1890,1899)
replace periods=4 if inrange(year,1900,1909)
replace periods=5 if inrange(year,1910,1918) // WW1 and pre-Trianon
replace periods=6 if inrange(year,1919,1933) // long-lasting depression Luijkx Et al 2002
replace periods=7 if inrange(year,1934,1945) // The long WW2 Luijkx Et al 2002
replace periods=8 if inrange(year,1946,1956) // The long 50s Luijkx Et al 2002
replace periods=9 if inrange(year,1957,1969) // The long 50s Luijkx Et al 2002
replace periods=10 if inrange(year,1970,1979) // Reform Socialism Luijkx Et al 2002
replace periods=11 if inrange(year,1980,1989) // Decline of Socialism Luijkx Et al 2002
replace periods=12 if inrange(year,1990,1999) // Early Transition 
replace periods=13 if inrange(year,2000,2009) // Early EU
replace periods=14 if inrange(year,2010,2018) // Orban


label define periods -7 "1780-89" -6 "1790-99" -5 "1800-09" -4 "1810-19" -3 "1820-29" -2 "1830-39" -1 "1840-48" 0 "1849-66" 1 "1867-79" 2 "1880-89" 3 "1890-99" 4 "1900-09" 5 "1910-18" 6 "1919-33" 7 "1934-45" 8 "1946-56" 9 "1957-69" 10 "1970-80" 11 "1980-89" 12 "1990-99" 13 "2000-09" 14 "2010-18", replace
label values periods periods
