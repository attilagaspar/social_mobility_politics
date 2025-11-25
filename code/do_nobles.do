gen nobility=0 // define nobility - Y-rule
replace nobility=1 if substr(lastname,-1,1)=="y" // definition of nobility ("y" rule)
replace nobility=0 if substr(lastname,-2,2)=="gy" | substr(lastname,-2,2)=="ly" | substr(lastname,-2,2)=="ny" | substr(lastname, -3,3)=="ity"

*replace nobility=0 if substr(lastname,-4,4)=="szky"
*replace nobility=0 if substr(lastname,-3,3)=="sky"
