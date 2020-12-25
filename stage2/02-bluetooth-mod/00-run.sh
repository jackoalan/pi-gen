#!/bin/bash

if [ "${ENABLE_JS}" == "1" ]; then

cat << EOF > "${ROOTFS_DIR}/boot/config.txt"
EOF

install -m 644 files/bluez-mod.diff "${ROOTFS_DIR}/bluez-mod.diff"

on_chroot << EOF
apt-get -y install dpkg-dev flex bison libdbus-glib-1-dev libglib2.0-dev libcap-ng-dev libdw-dev libudev-dev libreadline-dev libical-dev libasound2-dev check debhelper
rm -rf bluez-5.55
apt-get source bluez
pushd bluez-5.55
patch -p1 </bluez-mod.diff
dpkg-buildpackage -b
popd
dpkg -i bluez_5.55-*_armhf.deb libbluetooth3_5.55-*_armhf.deb
rm -rf *blue*
sed -i 's|#DiscoverableTimeout = 0|DiscoverableTimeout = 0|' /etc/bluetooth/main.conf
ln -s /tmp /var/lib/bluetooth
EOF

else
on_chroot << EOF
systemctl disable bluetooth
EOF
fi
