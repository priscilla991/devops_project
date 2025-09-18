#!/bin/bash
#Description : script débutant à l'aise 
#version : 2.0
#Auteur : Priscilla



echo "choissez votre boisson"
echo "1) café"
echo "2) thé"
echo "3) chocolat"
read -p "Votre choix (1-3): " choix 

case $choix in 

    1) boisson="café" ;;
    2) boisson="thé" ;;
    3) boisson="chocolat" ;;
    *) echo choix invalide. exit 1 ;;        
esac


read -p "Avez-vous un gobelet ? (oui/non) : " gobelet
read -p "Voulez-vous du sucre ? (oui/non) : " sucre

echo -e "\nCommande finale :"
echo "Boisson : $boisson"
echo "Sucre : $sucre"
echo "Gobelet : $gobelet"
echo "Bonne dégustation !"