###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Zineb SOUDI
#   description  : script de gestion des utilisateur
###################################

echo "1 => Créer utilisateur"
echo "2 => Supprimer de l'utilisateur"
echo "3 => Activer utilisateur"
echo "4 => Desactiver utilisateur"
echo "5 => Ajouter à un groupe"
echo "6 => "
echo "7 =>"
echo "x => Quitter"

read -p "faites votre choix :" choix

case $choix in
    1) 
        source create_user.sh 
        ;;
    2)       
        source del_user.sh
        ;;
    3)
        source active_user.sh
        ;;
    4) 
        exit 0
    5)
        echo "le choix est incorrect"
esac
