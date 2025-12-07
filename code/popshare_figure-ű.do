use "$population_control_data_dir/$population_control_file", clear


twoway connected nobility top20 year, xline(1720 1869 1895 1998 2016) legend(pos(6) col(2) order(1 "-y ending surnames" 2 "Top20 most frequent surnames")) xlabel(1720 1869 1895 1998 2016 " ") ///
title("Population shares")

graph export ../figures/population_shares.pdf, replace