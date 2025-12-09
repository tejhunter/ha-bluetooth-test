#!/usr/bin/env bash
set -e

# Variables d'environnement CRITIQUES pour utiliser DBus de l'hôte
export DBUS_SYSTEM_BUS_ADDRESS="unix:path=/run/dbus/system_bus_socket"
export PULSE_RUNTIME_PATH=/var/run/pulse

# Créer la structure pour PulseAudio en mode utilisateur
mkdir -p /var/run/pulse
chown -R root:root /var/run/pulse

# Configurer PulseAudio pour utiliser le socket DBus de l'hôte
cat > /etc/pulse/client.conf << EOF
# Connexion au serveur PulseAudio du système
default-server = unix:/run/pulse/native
autospawn = no
daemon-binary = /bin/true
enable-shm = false
EOF

echo "=== Environnement configuré ==="
echo "DBus socket: $DBUS_SYSTEM_BUS_ADDRESS"
echo "Pulse runtime: $PULSE_RUNTIME_PATH"

# Lancer PulseAudio en mode utilisateur (pas système!)
echo "Démarrage de PulseAudio en mode utilisateur..."
pulseaudio --start --log-target=stderr --high-priority=false

# Attendre que PulseAudio soit prêt
sleep 3

# Tester la connexion
echo "=== Test des commandes audio ==="
pactl list sources short 2>&1 || echo "Pactl échoue mais continue..."
pactl list sinks short 2>&1 || echo "Pactl échoue mais continue..."

echo "=== L'add-on est prêt ==="
echo "Utilisez 'docker exec -it addon_local_bluetooth_test bash' pour accéder au terminal."
echo "Commandes à tester manuellement :"
echo "1. bluetoothctl"
echo "2. pair XX:XX:XX:XX:XX:XX"
echo "3. connect XX:XX:XX:XX:XX:XX"
echo "4. pactl list sources"

# Maintenir le conteneur actif
tail -f /dev/null