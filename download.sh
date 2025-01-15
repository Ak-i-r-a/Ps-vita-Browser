#!/bin/bash

# Téléchargement de Firefox
FIREFOX_URL="https://download.mozilla.org/?product=firefox-134.0.1-ssl&os=linux64&lang=en-US"
FIREFOX_ARCHIVE="firefox-134.0.1.tar.bz2"

if [ ! -f "$FIREFOX_ARCHIVE" ]; then
    echo "Téléchargement de Firefox..."
    wget -O "$FIREFOX_ARCHIVE" "$FIREFOX_URL"
    tar -xjf "$FIREFOX_ARCHIVE"
else
    echo "Firefox déjà téléchargé."
fi

# Téléchargement de noVNC
NOVNC_REPO="https://github.com/novnc/noVNC/archive/refs/heads/master.zip"
NOVNC_ARCHIVE="novnc-master.zip"

if [ ! -f "$NOVNC_ARCHIVE" ]; then
    echo "Téléchargement de noVNC..."
    wget -O "$NOVNC_ARCHIVE" "$NOVNC_REPO"
    unzip "$NOVNC_ARCHIVE"
else
    echo "noVNC déjà téléchargé."
fi

# Téléchargement de websockify
WEBSOCKIFY_REPO="https://github.com/novnc/websockify.git"
WEBSOCKIFY_DIR="websockify"

if [ ! -d "$WEBSOCKIFY_DIR" ]; then
    echo "Téléchargement de websockify..."
    git clone "$WEBSOCKIFY_REPO" "$WEBSOCKIFY_DIR"
else
    echo "websockify déjà téléchargé."
fi

# Téléchargement de PulseAudio
PULSEAUDIO_URL="https://freedesktop.org/software/pulseaudio/releases/pulseaudio-17.0.tar.gz"
PULSEAUDIO_ARCHIVE="pulseaudio-17.0.tar.gz"

if [ ! -f "$PULSEAUDIO_ARCHIVE" ]; then
    echo "Téléchargement de PulseAudio..."
    wget -O "$PULSEAUDIO_ARCHIVE" "$PULSEAUDIO_URL"
    tar -xzf "$PULSEAUDIO_ARCHIVE"
else
    echo "PulseAudio déjà téléchargé."
fi

# Téléchargement de Xorg
XORG_URL="https://xorg.freedesktop.org/releases/individual/xserver/xorg-server-1.20.14.tar.gz"
XORG_ARCHIVE="xorg-server-1.20.14.tar.gz"

if [ ! -f "$XORG_ARCHIVE" ]; then
    echo "Téléchargement de Xorg..."
    wget -O "$XORG_ARCHIVE" "$XORG_URL"
    tar -xzf "$XORG_ARCHIVE"
else
    echo "Xorg déjà téléchargé."
fi

echo "Téléchargement des dépendances terminé."