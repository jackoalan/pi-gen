#!/bin/bash -e

on_chroot << EOF
apt-get -y remove --purge build-essential git cmake gcc-10 cpp-10 check debhelper flex bison dpkg-dev
apt-get -y autoremove --purge
EOF
