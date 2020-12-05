#!/bin/bash

install -m 644 files/bluez-mod.diff "${ROOTFS_DIR}/bluez-mod.diff"

on_chroot << EOF
rm -rf bluez-5.55
apt-get source bluez
pushd bluez-5.55
patch -p1 </bluez-mod.diff
dpkg-buildpackage -b
popd
dpkg -i bluez_5.55-1_armhf.deb
dpkg -i libbluetooth3_5.55-1_armhf.deb
rm -rf *blue*
sed -i 's|#DiscoverableTimeout = 0|DiscoverableTimeout = 0|' /etc/bluetooth/main.conf
ln -s /tmp /var/lib/bluetooth
EOF
