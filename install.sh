#!/bin/bash

# Mise à jour des listes de paquets
sudo apt update && sudo apt upgrade -y

# Installation de Ghost Browser, VNC, noVNC, PulseAudio et outils nécessaires
sudo apt install -y xterm tigervnc-standalone-server novnc websockify xorg xauth pulseaudio pulseaudio-utils
sudo dpkg -i ghost-browser-stable_2.4.0.4_amd64.deb
sudo apt install -f -y

# Démarrer PulseAudio pour cette session VNC
pulseaudio --start

# Assurez-vous que PulseAudio écoute les connexions réseau
echo "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1" | sudo tee -a /etc/pulse/default.pa

# Configuration du serveur VNC (serveur X minimal) avec PulseAudio activé
vncserver :1 -xstartup /usr/bin/xterm -geometry 1280x1024 -depth 24

# Récupération du cookie xauth pour permettre l'accès à X
export DISPLAY=:1
xauth add $DISPLAY . $(mcookie)

# Lancer noVNC pour accéder à l'interface Ghost Browser via un navigateur
websockify --web=/usr/share/novnc 6080 localhost:5901 &

# Affichage du lien pour accéder via le navigateur
echo "Accédez à Ghost Browser via : http://$(hostname -I | awk '{print $1}'):6080"

# Lancez Ghost Browser pour vérifier si le son fonctionne (ou à partir du navigateur VNC)
ghost-browser --no-sandbox --incognito --start-fullscreen &

# rendre executable:
# chmod +x install.sh

# installer :
# ./install.sh


# Installer Pulseaudio (si nécessaire)
# sudo apt install -y pulseaudio

# Demarrer PulseAudio
# pulseaudio --start

# Lancer Ghost Browser :
# ghost-browser --no-sandbox --incognito --start-fullscreen &
