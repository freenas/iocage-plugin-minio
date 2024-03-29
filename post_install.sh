#!/bin/sh

# Create some random keys
export LC_ALL=C
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1 > /root/akey
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1 > /root/skey
AKEY=$(cat /root/akey)
SKEY=$(cat /root/skey)

# Enable the service
sysrc -f /etc/rc.conf minio_enable="YES"
sysrc -f /etc/rc.conf minio_console_address=":9001"
sysrc -f /etc/rc.conf minio_env="MINIO_ACCESS_KEY=$AKEY MINIO_SECRET_KEY=$SKEY"

# Setup backend directory
mkdir -p /var/db/minio
chown -R minio /var/db/minio && chmod u+rxw /var/db/minio

# Start the service
service minio start 2>/dev/null

echo "MINIO ROOT USER: $AKEY" > /root/PLUGIN_INFO
echo "MINIO ROOT PASSWORD: $SKEY" >> /root/PLUGIN_INFO
