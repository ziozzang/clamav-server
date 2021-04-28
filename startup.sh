#!/bin/bash
CLAMAV_MIRROR=${CLAMAV_MIRROR:-"firewall.host:8000"}
CLAMAV_PORT=${CLAMAV_PORT:-"3310"}

if [ -z "${CLAMAV_MIRROR}" ]; then

	echo ">>> CLAMAV_MIRROR: ${CLAMAV_MIRROR}"
cat > /etc/clamav/freshclam.conf <<EOF
DatabaseOwner clamav
UpdateLogFile /var/log/clamav/freshclam.log
LogVerbose false
LogSyslog false
LogFacility LOG_LOCAL6
LogFileMaxSize 0
LogRotate true
LogTime true
Foreground false
Debug false
MaxAttempts 5
DatabaseDirectory /var/lib/clamav
#DNSDatabaseInfo current.cvd.clamav.net
ConnectTimeout 30
ReceiveTimeout 0
TestDatabases yes
ScriptedUpdates yes
CompressLocalDatabase no
SafeBrowsing false
Bytecode true
NotifyClamd /etc/clamav/clamd.conf
# Check for new database 24 times a day
Checks 24
DatabaseMirror http://${CLAMAV_MIRROR}
EOF
fi

echo "TCPSocket ${CLAMAV_PORT}" >> /etc/clamav/clamd.conf

chown -R clamav:clamav /var/run/clamav

#freshclam
freshclam -d

clamd -F
