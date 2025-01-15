#!/bin/bash

# Dossier où les dépendances seront téléchargées
DEPENDENCIES_DIR=$(pwd)
echo "Téléchargement des dépendances dans le dossier : $DEPENDENCIES_DIR"

# Téléchargement de Firefox
FIREFOX_URL="https://download.mozilla.org/?product=firefox-134.0.1-ssl&os=linux64&lang=en-US"
FIREFOX_ARCHIVE="firefox-134.0.1.tar.bz2"

if [ ! -f "$DEPENDENCIES_DIR/$FIREFOX_ARCHIVE" ]; then
    echo "Téléchargement de Firefox..."
    wget -O "$DEPENDENCIES_DIR/$FIREFOX_ARCHIVE" "$FIREFOX_URL"
else
    echo "Firefox déjà téléchargé."
fi

# Téléchargement de noVNC
NOVNC_REPO="https://github.com/novnc/noVNC/archive/refs/heads/master.zip"
NOVNC_ARCHIVE="novnc-master.zip"

if [ ! -f "$DEPENDENCIES_DIR/$NOVNC_ARCHIVE" ]; then
    echo "Téléchargement de noVNC..."
    wget -O "$DEPENDENCIES_DIR/$NOVNC_ARCHIVE" "$NOVNC_REPO"
else
    echo "noVNC déjà téléchargé."
fi

# Téléchargement de websockify
WEBSOCKIFY_REPO="https://github.com/novnc/websockify/archive/refs/heads/main.zip"
WEBSOCKIFY_ARCHIVE="websockify-main.zip"

if [ ! -f "$DEPENDENCIES_DIR/$WEBSOCKIFY_ARCHIVE" ]; then
    echo "Téléchargement de websockify..."
    wget -O "$DEPENDENCIES_DIR/$WEBSOCKIFY_ARCHIVE" "$WEBSOCKIFY_REPO"
else
    echo "websockify déjà téléchargé."
fi

# Téléchargement de PulseAudio
PULSEAUDIO_URL="http://ftp.us.debian.org/debian/pool/main/p/pulseaudio/pulseaudio_14.2.orig.tar.gz"
PULSEAUDIO_ARCHIVE="pulseaudio-14.2.tar.gz"

if [ ! -f "$DEPENDENCIES_DIR/$PULSEAUDIO_ARCHIVE" ]; then
    echo "Téléchargement de PulseAudio..."
    wget -O "$DEPENDENCIES_DIR/$PULSEAUDIO_ARCHIVE" "$PULSEAUDIO_URL"
else
    echo "PulseAudio déjà téléchargé."
fi

# Téléchargement de Xorg
XORG_URL="https://xorg.freedesktop.org/releases/individual/xserver/xorg-server-1.20.14.tar.gz"
XORG_ARCHIVE="xorg-server-1.20.14.tar.gz"

if [ ! -f "$DEPENDENCIES_DIR/$XORG_ARCHIVE" ]; then
    echo "Téléchargement de Xorg..."
    wget -O "$DEPENDENCIES_DIR/$XORG_ARCHIVE" "$XORG_URL"
else
    echo "Xorg déjà téléchargé."
fi

echo "Téléchargement des dépendances terminé."
