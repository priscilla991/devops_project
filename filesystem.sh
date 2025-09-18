###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Zineb SOUDI
#   description  : script de vérification fs 
###################################

# Seuil d'alerte en pourcentage  du fs /usr/lib/wsl/drivers
seuil=90

porcentage=$(df -h | grep /usr/lib/wsl/drivers | awk 'NR==1 {print $5}' | sed 's/%//')

if [ $porcentage -gt $seuil ]
then 
    echo "Alerte Orange : le seuil est dépassé"
else 
    echo "tout va bien"
fi