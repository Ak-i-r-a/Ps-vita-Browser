#!/bin/bash

# Fonction pour installer et vérifier un paquet
install_and_verify() {
    local package=$1
    echo "Installation de $package..."
    sudo apt install -y $package
    if dpkg -s $package &> /dev/null; then
        echo "$package est bien installé."
    else
        echo "Erreur: $package n'a pas pu être installé."
        exit 1
    fi
}

# Mise à jour des listes de paquets
sudo apt update && sudo apt upgrade -y

# Liste des paquets à installer
packages=(
    "firefox"
    "libasound2"
    "xterm"
    "tigervnc-standalone-server"
    "novnc"
    "websockify"
    "xorg"
    "xauth"
    "pulseaudio"  # Ajout de PulseAudio pour la gestion audio
)

# Installation et vérification de chaque paquet
for package in "${packages[@]}"; do
    install_and_verify $package
done

# Configuration de PulseAudio pour l'accès réseau
echo "Configuration de PulseAudio..."
echo "load-module module-native-protocol-tcp auth-anonymous=1" | sudo tee -a /etc/pulse/default.pa

# Démarrage de PulseAudio
pulseaudio --kill  # Arrête PulseAudio s'il est déjà en cours d'exécution
pulseaudio --start  # Démarre PulseAudio avec la nouvelle configuration

# Configuration du serveur VNC
echo "Configuration du serveur VNC..."
vncserver :1 -xstartup /usr/bin/xterm -geometry 1280x1024 -depth 24

# Récupération du cookie xauth pour permettre l'accès à X
export DISPLAY=:1
xauth add $DISPLAY . $(mcookie)

# Lancement de noVNC
echo "Lancement de noVNC..."
websockify --web=/usr/share/novnc 6080 localhost:5901 &

# Affichage du lien pour accéder via le navigateur
echo "Accédez à Firefox via : http://$(hostname -I | awk '{print $1}'):6080"

# Lancement de Firefox avec PulseAudio configuré pour le son
echo "Lancement de Firefox..."
firefox --no-remote &



# rendre executable:
# chmod +x install.sh

# installer :
# ./install.sh

# Installer Pulseaudio (si nécessaire)
# sudo apt install -y pulseaudio

# Demarrer PulseAudio
# pulseaudio --start

# Lancer Firefox :
# l'option --no-remote à Firefox pour permettre le lancement dans un environnement VNC
# firefox --no-remote &

# firefox --no-sandbox --incognito --start-fullscreen &