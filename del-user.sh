###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Zineb SOUDI
#   description  : création utilisateur 
###################################

read -p "Nom utilisateur a supprimer :" del_user

if grep -w $del_user /etc/passwd > /dev/null
then 
    #le compte $del user exite  ===> suppression 
    echo -e "Info   : Suppression de l'utilisateur $del_user"
    sudo deluser -q $del_user 2> /dev/null
    if  grep -w  $del_user /etc/passwd 1> /dev/null 2> /dev/null
    then
        echo -e "Erreur : de suppression"
        exit 1
    else
        echo -e "Info   : l'utilisateur $del_user a été supprimé"
        exit 0
    fi  
else
    echo -e "l'utilisateur $del_user n'existe pas\nbye!!"
    exit 1
fi