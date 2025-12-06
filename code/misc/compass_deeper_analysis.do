
import delimited "../data/raw/compass_with_capital.csv", varnames(1) clear

do clean_compass_names.do

do clean_compass_titles.do

keep lastname year role_CEO  firm industry share_capital

keep if role_CEO==1

split share_capital, parse(", ") gen(sc) 
gen share_capital_clean = regexr( sc1  , "[^0-9]", "")
destring share_capital_clean, force gen(capital)


gen log_capital = log(capital)

do create_name_groups.do
