#!/bin/bash

if [ "${ENABLE_CAN}" == "1" ]; then

install -m 644 files/ffmpeg-keyframe-replay-params.diff "${ROOTFS_DIR}/ffmpeg-keyframe-replay-params.diff"

on_chroot << EOF
apt-get -y install debhelper flite1-dev frei0r-plugins-dev ladspa-sdk libaom-dev libaribb24-dev libass-dev libbluray-dev libbrotli-dev libbs2b-dev libbz2-dev libcaca-dev libcdio-paranoia-dev libchromaprint-dev libcodec2-dev libdav1d-dev libdc1394-dev libdrm-dev libfontconfig1-dev libfreetype6-dev libfribidi-dev libgl1-mesa-dev libgme-dev libgnutls28-dev libgsm1-dev libiec61883-dev libavc1394-dev libjack-jackd2-dev liblensfun-dev liblilv-dev liblzma-dev libmp3lame-dev libmysofa-dev libopenal-dev libomxil-bellagio-dev libopencore-amrnb-dev libopencore-amrwb-dev libopenjp2-7-dev libopenmpt-dev libopus-dev libpocketsphinx-dev libpulse-dev librabbitmq-dev librubberband-dev librsvg2-dev libsctp-dev libsdl2-dev libshine-dev libsnappy-dev libsoxr-dev libspeex-dev libssh-gcrypt-dev libtesseract-dev libtheora-dev libtwolame-dev libva-dev libvdpau-dev libvidstab-dev libvo-amrwbenc-dev libvorbis-dev libvpx-dev libwavpack-dev libwebp-dev libx264-dev libx265-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-xfixes0-dev libxml2-dev libxv-dev libxvidcore-dev libxvmc-dev libzmq3-dev libzvbi-dev ocl-icd-opencl-dev texinfo nasm pkg-kde-tools cleancss doxygen node-less
rm -rf ffmpeg-4.3.1
apt-get source ffmpeg
pushd ffmpeg-4.3.1
patch -p1 </ffmpeg-keyframe-replay-params.diff
DEB_BUILD_OPTIONS=nocheck dpkg-buildpackage -b -uc -ui -nc
popd
dpkg -i libavformat58_4.3.1-*_armhf.deb libavformat-dev_4.3.1-*_armhf.deb libavcodec58_4.3.1-*_armhf.deb libavcodec-dev_4.3.1-*_armhf.deb libavdevice58_4.3.1-*_armhf.deb libavdevice-dev_4.3.1-*_armhf.deb libswscale5_4.3.1-*_armhf.deb libswscale-dev_4.3.1-*_armhf.deb libavutil56_4.3.1-*_armhf.deb libavutil-dev_4.3.1-*_armhf.deb
rm -rf ffmpeg*
rm -rf *.deb

pushd /home/"${FIRST_USER_NAME}"
rm -rf vid-tiberius
git clone https://github.com/jackoalan/vid-tiberius
pushd vid-tiberius
mkdir -p build

pushd build/
cmake -DCMAKE_BUILD_TYPE=Release -DV4L2_ENCODE=On -DCMAKE_INSTALL_PREFIX=/ ..
make -j`nproc`
make install
popd

systemctl enable vid-sender

popd
rm -rf vid-tiberius
popd
EOF

fi
