#!/bin/bash -e

#rm -rf "${ROOTFS_DIR}"/var/lib/dhcp "${ROOTFS_DIR}"/var/lib/dhcpcd5 "${ROOTFS_DIR}"/var/spool "${ROOTFS_DIR}"/etc/resolv.conf
#ln -s /tmp "${ROOTFS_DIR}"/var/lib/dhcp
#ln -s /tmp "${ROOTFS_DIR}"/var/lib/dhcpcd5
#ln -s /tmp "${ROOTFS_DIR}"/var/spool
#touch "${ROOTFS_DIR}"/tmp/dhcpcd.resolv.conf
#ln -s /tmp/dhcpcd.resolv.conf "${ROOTFS_DIR}"/etc/resolv.conf

#rm "${ROOTFS_DIR}"/var/lib/systemd/random-seed
#ln -s /tmp/random-seed "${ROOTFS_DIR}"/var/lib/systemd/random-seed

#echo "ExecStartPre=/bin/echo "" >/tmp/random-seed" >> "${ROOTFS_DIR}"/lib/systemd/system/systemd-random-seed.service

on_chroot << EOF
systemctl disable systemd-timesyncd dhcpcd
systemctl mask systemd-logind
EOF
