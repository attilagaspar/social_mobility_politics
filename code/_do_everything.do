/*

	this script cleans data and runs analysis

*/

* set working directory
* to find out your username : display "`c(hostname)'"


cap cd "/Users/pawelbukowski/Dropbox/Social Mobility HUN/social_mobility_long20/code/"


if (c(username)=="agaspar") {
	
	disp "user is Attila Gáspár"
	cap cd "C:\Users\agaspar\Dropbox\research\social_mobility_long20\code\"
	
}

/* this does not seem to work well on mac
else if (c(username)=="CSEES057721.local") {
	
	disp "user is Paweł Bukowski"
	cd "/Users/pawelbukowski/Dropbox/Social Mobility HUN/social_mobility_long20/code/"
}
*/



* set data location global variables
do set_directories.do

* clean raw elite data
do clean_doctors.do 
do clean_law.do
do clean_representatives.do
do clean_army.do
do clean_business.do
do clean_hschool.do


* create population control data
do do_popshare_1720.do
do do_popshare_1895-1950_marriages.do
do do_popshare_1998_registry.do
do do_popshare_2016_registry.do
do merge_population_control_long.do 

* calculate representations for y10 
do calc_representation_doctors y10 assumption
do calc_representation_law y10 assumption
do calc_representation_representatives y10 assumption
do calc_representation_officers y10 assumption
do calc_representation_business y10 assumption
do calc_representation_hschool y10 assumption

do calc_representation_doctors year assumption
do calc_representation_law year assumption
do calc_representation_representatives year assumption
do calc_representation_officers year assumption
do calc_representation_business year assumption
do calc_representation_hschool year assumption


* calculate representations for periods
do calc_representation_doctors periods assumption
do calc_representation_law periods assumption
do calc_representation_representatives periods assumption
do calc_representation_officers periods assumption
do calc_representation_business periods assumption
do calc_representation_hschool periods assumption



* draw main figures for Paper 1
do figure_main_long_top20 ../figures/lowstatus

do figure_main_long_y ../figures/highstatus 

do figure_main_long_top20_withpredict_logs ../figures/lowstatus_trend

do figure_main_long_y_withpredict_logs ../figures/highstatus_trend

* draw main figures for Paper 2
do figures_paper2



// NOTES: after 1787 Jews were required to adopt a surname (Josepf II decree) and preferable surnames were german -> so we should observe a simultanous rise of both german and jewish surnames at the end of the 18th century
