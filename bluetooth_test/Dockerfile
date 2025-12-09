# Basé sur Alpine pour compatibilité HA OS
ARG BUILD_FROM
FROM $BUILD_FROM

# Installation des paquets ESSENTIELS
RUN apk add --no-cache \
    pulseaudio \
    pulseaudio-bluetooth \
    pulseaudio-utils \
    bluez \
    bluez-deprecated \
    bluez-libs \
    bluez-tools \
    dbus \
    alsa-utils \
    bash \
    curl

# Script de démarrage
COPY run.sh /
RUN chmod a+x /run.sh

# Configuration PulseAudio de base
RUN mkdir -p /etc/pulse && \
    echo "load-module module-bluetooth-policy" >> /etc/pulse/default.pa && \
    echo "load-module module-bluetooth-discover" >> /etc/pulse/default.pa && \
    echo "load-module module-switch-on-connect" >> /etc/pulse/default.pa

CMD ["/run.sh"]