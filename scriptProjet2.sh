##########################################################################################################
#!/bin/bash
#Auteur: GROUPE 1 
#Version
#Description: Script qui, s'exécute sur un serveur Debian pour administrer des machines clientes Ubuntu.
##########################################################################################################


#!/bin/bash


# Fonction : afficher la version de l'OS
version_os() {
    echo -e "\n--- Version de l'OS ---"
    cat /etc/os-release
}

# Fonction : afficher le nombre de disques
nombre_disques() {
    echo -e "\n--- Nombre de disques ---"
    lsblk -d -e 7 -o NAME,SIZE | grep -v NAME
    echo "Total: $(lsblk -d -e 7 -n | wc -l) disque(s)"
}

# Fonction : afficher les partitions par disque
partitions_disques() {
    echo -e "\n--- Détails des partitions ---"
    lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT
}

# Fonction : espace disque restant par partition/volume
espace_disque() {
    echo -e "\n--- Espace disque utilisé et disponible ---"
    df -h | grep "^/"
}

# Fonction : espace disque d’un dossier spécifique
dossier_espace() {
    echo -e "\n--- Espace disque d'un dossier ---"
    read -p "Entrez le chemin du dossier à analyser (ex: /home/user): " dossier
    if [ -d "$dossier" ]; then
        du -sh "$dossier"
    else
        echo "Dossier invalide ou introuvable."
    fi
}

# Fonction : lecteurs montés
lecteurs_montes() {
    echo -e "\n--- Lecteurs montés ---"
    mount | grep "^/dev"
}

# Fonction : paquets installés
paquets_installes() {
    echo -e "\n--- Paquets installés ---"
    if command -v dpkg &> /dev/null; then
        dpkg -l
    elif command -v rpm &> /dev/null; then
        rpm -qa
    else
        echo "Gestionnaire de paquets non détecté."
    fi
}

# Fonction : services en cours d'exécution
services_actifs() {
    echo -e "\n--- Services actifs ---"
    systemctl list-units --type=service --state=running
}

# Fonction : utilisateurs locaux
utilisateurs_locaux() {
    echo -e "\n--- Utilisateurs locaux ---"
    cut -d: -f1 /etc/passwd
}


# Menu interactif
while true; do
    echo -e "\n MENU PRINCIPAL"
    echo "1. Version de l'OS"
    echo "2. Nombre de disques"
    echo "3. Partitions par disque"
    echo "4. Espace disque restant"
    echo "5. Espace utilisé par un dossier"
    echo "6. Liste des lecteurs montés"
    echo "7. Liste des paquets installés"
    echo "8. Services en cours d'exécution"
    echo "9. Utilisateurs locaux"
    echo "0. Quitter"

    read -p "Choisissez une option : " choix

    case $choix in
        1) version_os ;;
        2) nombre_disques ;;
        3) partitions_disques ;;
        4) espace_disque ;;
        5) dossier_espace ;;
        6) lecteurs_montes ;;
        7) paquets_installes ;;
        8) services_actifs ;;
        9) utilisateurs_locaux ;;
        0) echo "À bientôt !"; break ;;
        *) echo "Option invalide. Réessayez." ;;
    esac
done

