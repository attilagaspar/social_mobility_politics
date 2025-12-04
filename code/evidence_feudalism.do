/*

noble share in land and landowners

1720
1895

*/
use "../../social mobility (1)/data/urbaria1767/urbaria1767namelist.dta", clear

drop nobility
do create_name_groups.do

tab nobility

preserve 
	keep if acres>100
	collapse (sum) acres, by(nobility)
	tab nobility acres
restore

tab top20

preserve 
	collapse (sum) acres, by(top20)
	tab top20 acres
restore

* 39.63% of landholders ..y
* 52.49% of land hold by ..y 

* 1.28% of landholders top20
* 2.32% of land hold by top20


use "../../leporolt_adatok/techxtremism\data\processed\gazdaczimtar_raw.dta" , clear

split H, gen(ln)
split neve, gen(ln)

rename ln1 lastname

do create_name_groups.do

tab nobility 

destring összesen, force gen(acres)
destring szántó, force gen(acres2)
preserve 
	collapse (sum) acres, by(nobility)
	tab nobility acres
restore

tab top20

preserve 
	collapse (sum) acres, by(top20)
	tab top20 acres
restore
preserve 
	collapse (sum) acres2, by(nobility)
	tab nobility acres2
restore

preserve 
	collapse (sum) acres2, by(top20)
	tab top20 acres2
restore
*14.08% percent is noble, controls 18.25% of arable land
*7.38% percent is top20, controls 4.06% of arable land

/*
1767:
39.63% of landholders ..y
52.49% of land hold by ..y 
1.28% of landholders top20
2.32% of land hold by top20

1895:
14.08% percent is noble, controls 18.25% of arable land
7.38% percent is top20, controls 4.06% of arable land
*/


preserve

clear
input year nob_holders nob_land top20_holders top20_land
1767 39.63 52.49 1.28 2.32
1895 14.08 18.25 7.38 4.06
end

* Single figure with 4 lines
twoway ///
    (line nob_holders year,    lpattern(solid) lcolor(blue)) ///
    (line nob_land    year,    lpattern(dash)  lcolor(blue)) ///
    (line top20_holders year,  lpattern(solid) lcolor(red)) ///
    (line top20_land    year,  lpattern(dash)  lcolor(red)), ///
    xtitle("Year") ///
    ytitle("Percent of landholders / land") ///
    xlabel(1767 1895, valuelabel) ///
    ylabel(0(10)60, angle(horizontal)) ///
    legend(order(1 "Noble / -y landholders" ///
                 2 "Noble / -y land share" ///
                 3 "Top 20 landholders" ///
                 4 "Top 20 land share") ///
           pos(6) row(1) col(4)) ///
    title("Elite surname dominance in landholding, 1767 vs 1895")

	graph export "../figures/land.pdf", replace
	
* Go back to your original data
restore


/*

top20 share in land and landowners

1720 
1895


*/