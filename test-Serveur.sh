###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Zineb SOUDI
#   description  : verifier l'état de serveur 
###################################

# adresse ip du serveur a tester
serveur="127.0.0.1"

ping -c 2 127.0.0.1 > /dev/null

if [ $? -eq 0 ]
then 
    echo "le serverur est joignable"
else 
    echo "le ping a échoué"

fi 