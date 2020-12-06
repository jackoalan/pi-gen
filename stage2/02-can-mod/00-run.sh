#!/bin/bash

if [ "${ENABLE_CAN}" == "1" ]; then

install -m 644 files/ifcfg-can0 "${ROOTFS_DIR}/etc/network/interfaces.d/ifcfg-can0"

cat << EOF > "${ROOTFS_DIR}/boot/config.txt"
dtparam=spi=on
dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=25
dtoverlay=spi-bcm2835-overlay
EOF

fi
