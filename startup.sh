#!/bin/bash
CLAMAV_MIRROR=${CLAMAV_MIRROR:-"http://firewall.host:8000"}
CLAMAV_PORT=${CLAMAV_PORT:-"3310"}

if [ ! -z "${CLAMAV_MIRROR}" ]; then
	echo ">>> Setup CLAMAV_MIRROR: ${CLAMAV_MIRROR}"
	sed -i 's,^\(DatabaseMirror\),#\1,' /etc/clamav/freshclam.conf
	sed -i 's,^\(DNSDatabaseInfo\),#\1,' /etc/clamav/freshclam.conf
	echo "DatabaseMirror ${CLAMAV_MIRROR}" >> /etc/clamav/freshclam.conf
fi

echo "TCPSocket ${CLAMAV_PORT}" >> /etc/clamav/clamd.conf

chown -R clamav:clamav /var/run/clamav

# Initial downloading
freshclam

# Daemon Starting
freshclam -d

clamd -F
