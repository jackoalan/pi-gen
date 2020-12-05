#!/bin/bash -e

on_chroot << EOF
pushd /home/"${FIRST_USER_NAME}"
if [ -d pnet-tiberius ]; then
  rm -r pnet-tiberius
fi
git clone https://github.com/jackoalan/pnet-tiberius
pushd pnet-tiberius
git submodule update --recursive --init
mkdir -p build

pushd build/
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-Wno-error=nonnull" -DCMAKE_INSTALL_PREFIX=/ ..
make -j`nproc`
make install
popd

if [ "${ENABLE_JS}" == "1" ]; then
	systemctl enable pnet-js
	echo "enabled pnet-js"
elif [ "${ENABLE_CAN}" == "1" ]; then
	systemctl enable pnet-can
	echo "enabled pnet-can"
fi

popd
popd
EOF
