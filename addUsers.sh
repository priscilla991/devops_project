########################################################################
#!/bin/bash
#  version: 0.0
#  Auteur: Priscilla
#  Description: Script qui traite les utilisateurs



# Vérifions si un argument est deja passé

if [ $# -eq 0 ]; then
   echo "Il manque les noms d'utilisateurs en argument - Fin du script"
   exit 1
fi

#Vérification de l'existence des utilisateurs dans le système

for user1 in "$@" ; 
do
#Vérification de l'existence
   if id "$user1" ; 
   then
      echo "L'utilisateur $user1 existe déjà"
   else
      echo "L'utilisateur $user1 n'existe pas encore."

   #Création de l'utilisateur
   sudo useradd "$user1"
   
#Vérification de la création d'utilisateur
 if [ $? eq 0 ] ; then
   echo "L'utilisateur <user1> a été crée"
else
   echo "Erreur à la création de l'utilisateur $user1"
 fi

   fi
done
