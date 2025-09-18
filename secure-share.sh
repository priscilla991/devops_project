#!/bin/bash

# === CONFIGURATION ===
RECIPIENT_EMAIL="secure@test.com"
DATA_DIR="./data"
ENCRYPTED_DIR="$DATA_DIR/encrypted"
DECRYPTED_DIR="$DATA_DIR/decrypted"
HASH_DIR="$DATA_DIR/hashes"

mkdir -p "$ENCRYPTED_DIR" "$DECRYPTED_DIR" "$HASH_DIR"

# === FONCTIONS ===

# Vérifie ou crée une clé GPG
check_or_create_key() {
    if ! gpg --list-keys "$RECIPIENT_EMAIL" > /dev/null 2>&1; then
        echo "[!] Clé GPG absente. Création..."
        gpg --batch --passphrase '' --quick-generate-key "$RECIPIENT_EMAIL" rsa2048 sign,encrypt 0
    fi
}

# Calcule et stocke le hash SHA-256
store_hash() {
    local file="$1"
    local hash_file="$HASH_DIR/$(basename "$file").sha256"
    sha256sum "$file" > "$hash_file"
    echo "[✓] Hash SHA-256 enregistré : $hash_file"
}

# Vérifie l'intégrité d'un fichier
verify_hash() {
    local file="$1"
    local hash_file="$HASH_DIR/$(basename "$file").sha256"
    if [ -f "$hash_file" ]; then
        echo "[*] Vérification d’intégrité de $file..."
        sha256sum -c "$hash_file"
    else
        echo "[!] Aucun hash enregistré pour $file"
    fi
}

# Chiffrement d'un fichier
encrypt_file() {
    read -p "Entrez le chemin du fichier à chiffrer : " input_file
    if [ ! -f "$input_file" ]; then
        echo "[✗] Fichier introuvable."
        return
    fi
    local base=$(basename "$input_file")
    local output_file="$ENCRYPTED_DIR/${base}.gpg"

    gpg --yes --output "$output_file" --encrypt --recipient "$RECIPIENT_EMAIL" "$input_file"

    if [ $? -eq 0 ]; then
        echo "[✓] Fichier chiffré : $output_file"
        store_hash "$input_file"
    else
        echo "[✗] Erreur de chiffrement."
    fi
}

# Déchiffrement d'un fichier
decrypt_file() {
    read -p "Entrez le nom du fichier chiffré (.gpg) à déchiffrer : " encrypted_file
    full_path="$ENCRYPTED_DIR/$encrypted_file"
    if [ ! -f "$full_path" ]; then
        echo "[✗] Fichier chiffré introuvable."
        return
    fi
    local output_file="$DECRYPTED_DIR/${encrypted_file%.gpg}"

    gpg --yes --output "$output_file" --decrypt "$full_path"

    if [ $? -eq 0 ]; then
        echo "[✓] Fichier déchiffré : $output_file"
        verify_hash "$output_file"
    else
        echo "[✗] Erreur de déchiffrement."
    fi
}

# === MENU INTERACTIF ===

check_or_create_key

while true; do
    echo ""
    echo "========= MENU SÉCURITÉ ========="
    echo "1. Chiffrer un fichier"
    echo "2. Déchiffrer un fichier"
    echo "3. Vérifier l'intégrité d'un fichier"
    echo "4. Quitter"
    echo "=================================="
    read -p "Votre choix [1-4] : " choice

    case $choice in
        1) encrypt_file ;;
        2) decrypt_file ;;
        3)
            read -p "Nom du fichier à vérifier (dans decrypted/) : " check_file
            verify_hash "$DECRYPTED_DIR/$check_file"
            ;;
        4) echo "Au revoir !"; exit 0 ;;
        *) echo "[!] Choix invalide." ;;
    esac
done
