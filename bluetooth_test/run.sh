#!/usr/bin/env bash
set -e

# Démarrer DBus (requis pour Bluez)
#echo "Démarrage de DBus..."
#dbus-daemon --system --fork

# Démarrer le service Bluetooth
echo "Démarrrage du service Bluetooth..."
bluetoothd --debug &

# Attendre que le service soit prêt
sleep 5

# Démarrer PulseAudio en mode système
echo "Démarrrage de PulseAudio..."
pulseaudio --system --disallow-exit --high-priority --exit-idle-time=-1 &

# Attendre et lister les périphériques
sleep 10
echo "=== État Bluetooth ==="
bluetoothctl show
bluetoothctl devices

echo "=== Sources audio détectées ==="
pactl list sources short

# Maintenir le conteneur actif
echo "Add-on en cours d'exécution. Utilisez 'docker exec' pour plus de commandes."
tail -f /dev/null