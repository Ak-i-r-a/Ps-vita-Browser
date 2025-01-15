#!/bin/bash

# Dossier contenant les dépendances téléchargées
DEPENDENCIES_DIR=$(pwd)
echo "Installation des dépendances depuis : $DEPENDENCIES_DIR"

# Extraction et installation de Firefox
FIREFOX_ARCHIVE="firefox-134.0.1.tar.bz2"
if [ -f "$DEPENDENCIES_DIR/$FIREFOX_ARCHIVE" ]; then
    echo "Extraction de Firefox..."
    tar -xjf "$DEPENDENCIES_DIR/$FIREFOX_ARCHIVE" -C "$DEPENDENCIES_DIR"
    echo "Firefox extrait. Ajout au PATH."
    export PATH="$DEPENDENCIES_DIR/firefox:$PATH"
else
    echo "Archive Firefox introuvable : $FIREFOX_ARCHIVE"
fi

# Extraction et préparation de noVNC
NOVNC_ARCHIVE="novnc-master.zip"
if [ -f "$DEPENDENCIES_DIR/$NOVNC_ARCHIVE" ]; then
    echo "Extraction de noVNC..."
    unzip -qo "$DEPENDENCIES_DIR/$NOVNC_ARCHIVE" -d "$DEPENDENCIES_DIR"
    echo "noVNC préparé."
else
    echo "Archive noVNC introuvable : $NOVNC_ARCHIVE"
fi

# Extraction et préparation de websockify
WEBSOCKIFY_ARCHIVE="websockify-main.zip"
if [ -f "$DEPENDENCIES_DIR/$WEBSOCKIFY_ARCHIVE" ]; then
    echo "Extraction de websockify..."
    unzip -qo "$DEPENDENCIES_DIR/$WEBSOCKIFY_ARCHIVE" -d "$DEPENDENCIES_DIR"
    echo "websockify préparé."
else
    echo "Archive websockify introuvable : $WEBSOCKIFY_ARCHIVE"
fi

# Extraction et compilation de PulseAudio 14.2
PULSEAUDIO_ARCHIVE="pulseaudio-14.2.tar.gz"
if [ -f "$DEPENDENCIES_DIR/$PULSEAUDIO_ARCHIVE" ]; then
    echo "Extraction de PulseAudio 14.2..."
    tar -xzf "$DEPENDENCIES_DIR/$PULSEAUDIO_ARCHIVE" -C "$DEPENDENCIES_DIR"
    cd "$DEPENDENCIES_DIR/pulseaudio-14.2" || exit
    echo "Configuration de PulseAudio 14.2..."
    ./configure --prefix="$DEPENDENCIES_DIR/pulseaudio-build" && make && make install
    cd "$DEPENDENCIES_DIR" || exit
else
    echo "Archive PulseAudio introuvable : $PULSEAUDIO_ARCHIVE"
fi

# Extraction et compilation de Xorg
XORG_ARCHIVE="xorg-server-1.20.14.tar.gz"
if [ -f "$DEPENDENCIES_DIR/$XORG_ARCHIVE" ]; then
    echo "Extraction de Xorg..."
    tar -xzf "$DEPENDENCIES_DIR/$XORG_ARCHIVE" -C "$DEPENDENCIES_DIR"
    cd "$DEPENDENCIES_DIR/xorg-server-1.20.14" || exit
    echo "Configuration de Xorg..."
    ./configure --prefix="$DEPENDENCIES_DIR/xorg-build" && make && make install
    cd "$DEPENDENCIES_DIR" || exit
else
    echo "Archive Xorg introuvable : $XORG_ARCHIVE"
fi

# Démarrer PulseAudio pour cette session VNC
pulseaudio --start

# Assurez-vous que PulseAudio écoute les connexions réseau
echo "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1" | sudo tee -a /etc/pulse/default.pa

# Configuration du serveur VNC (serveur X minimal) avec PulseAudio activé
vncserver :1 -xstartup /usr/bin/xterm -geometry 1280x1024 -depth 24

# Récupération du cookie xauth pour permettre l'accès à X
export DISPLAY=:1
xauth add $DISPLAY . $(mcookie)

# Lancer noVNC pour accéder à l'interface Firefox via un navigateur
"$DEPENDENCIES_DIR/noVNC-master/utils/launch.sh" --vnc localhost:5901 &

# Affichage du lien pour accéder via le navigateur
echo "Accédez à Firefox via : http://$(hostname -I | awk '{print $1}'):6080"

# Lancez Firefox pour vérifier si le son fonctionne (ou à partir du navigateur VNC)


# rendre executable:
# chmod +x install.sh

# installer :
# ./install.sh


# Installer Pulseaudio (si nécessaire)
# sudo apt install -y pulseaudio

# Demarrer PulseAudio
# pulseaudio --start

# Lancer Firefox :
# firefox --no-sandbox --incognito --start-fullscreen &
