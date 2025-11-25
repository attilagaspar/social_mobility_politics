/*

	this script cleans data and runs analysis

*/

* set working directory

if (c(username)=="agaspar") {
	
	disp "user is Attila Gáspár"
	cd "C:\Users\agaspar\Dropbox\research\social_mobility_long20\code\"
	
}

* set data location global variables
do set_directories.do

* clean raw elite data
do clean_doctors.do 
do clean_law.do
do clean_representatives.do
do clean_army.do
do clean_business.do

* create population control data
do merge_population_control_long.do 

* calculate representations
do calc_representation_doctors y10 assumption
do calc_representation_law y10 assumption
do calc_representation_representatives y10 assumption
do calc_representation_officers y10 assumption
do calc_representation_business y10 assumption

* draw main figure
do figure_main_long ../figures/highstatus ../figures/lowstatus