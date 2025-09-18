
#!/bin/bash
#Auteur: Priscilla
# Version: 1
#Description: Script de création auto des utilisateurs 

#Passons les arguments en vérification
if [ $# -eq 0 ]; then
    echo "Il manque les noms d'utilisateurs en argument"
    exit 1
fi

#  vérification de l'existence dans le système des utilisateurs

for utilisateur in "$@" ;

 do
    
    #Vérification

if id "$utilisateur" &>/dev/null ; then

    echo "L'utilisateur $utilisateur existe déjà"
else

  echo "L'utilisateur $utilisateur n'existe pas encore"

    #Création d'utilisateur
    sudo useradd "$utilisateur"
    echo "l'utilisateur $utilisateur a été créé"

    #vérification de la création 
if [ $? -eq 0 ]
then

    echo "L'utilisateur $utilisateur a été crée"
    
else

    echo "Échec de la création de l'utilisateur $utilisateur"

    fi    
    fi
done
exit 0