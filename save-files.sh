###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Zineb SOUDI
#   description  : ce scrip sert a créer des nouveau projet
###################################

dir_tosave="Python"
dir_destination="saves"

date_sys=$(date +%Y-%m-%d)

tar -czvf "$dir_destination/archive_$date_sys" $dir_tosave 