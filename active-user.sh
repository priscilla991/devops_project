###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Zineb SOUDI
#   description  : activation de l'utilisateur 
###################################



read -p "Utilisateur a activer :" activate_user

# if getent passwod $activate_user
if cat /etc/passwd | grep -w $activate_user >/dev/null 2>/dev/null
then
    # le compte existe
    echo "activation de l'utilisateur $activate_user"
    if sudo usermod -U $activate_user
    then 
        echo "l'utilisateur $activate_user a été activé"
        exit 0
    else 
        echo "Erreur : l'utilisateur n'a pas pu être activé."
    fi
else 
    # le compte n'existe pas
    echo "l'utilisateur $activate_user n'existe pas"
    exit 1
fi