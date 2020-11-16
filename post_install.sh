#!/bin/sh

# Create some random keys
export LC_ALL=C
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1 > /root/akey
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1 > /root/skey
AKEY=$(cat /root/akey)
SKEY=$(cat /root/skey)

# Enable the service
sysrc -f /etc/rc.conf minio_enable="YES"
sysrc -f /etc/rc.conf minio_env="MINIO_ACCESS_KEY=$AKEY MINIO_SECRET_KEY=$SKEY"

# Start the service
service minio start 2>/dev/null

echo "MINIO_ACCESS_KEY: $AKEY" > /root/PLUGIN_INFO
echo "MINIO_SECRET_KEY: $SKEY" > /root/PLUGIN_INFO
