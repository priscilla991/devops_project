###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Zineb SOUDI
#   description  : création utilisateur 
###################################

read -p "Nom d'utilisateur a créer :" new_user
credentiel="motdepasse"

# if [ getent passwd $new_user ]
if cat /etc/passwd | grep $new_user > /dev/null 2> /dev/null 
then
    # le compye $new_user existe 
    echo -e "l'utilisateur $new_user existe \n Sortie du script"
    exit 1
else
     # le compye $new_user n'existe pas 
     echo "Création de l'utilisateur $new_user"
     sudo useradd $new_user > /dev/null 2> /dev/null 
    if cat /etc/passwd | grep $new_user > /dev/null 2> /dev/null 
    then
        # le compye $new_user existe 
        echo -e "l'utilisateur $new_user a été créé \n Sortie du script"
        exit 0
    else
        # le compte utilisateur $new_user 
        echo "Utilisateur $new_user non créé ==>pb"
        exit 1
    fi 
fi 