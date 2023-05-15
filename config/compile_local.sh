#!/bin/bash

# Uses local copy of ZMK to compile keyboard. It's faster


if [ $# -gt 0 ]; then
    echo "usage: $0 $1"
    exit 1
fi

echo "building harold keyboard, plz wait..."

localdir=$(pwd)
zmkconf="/home/ayilay/downloads/zmk-harold/config"
zmkapp="/home/ayilay/downloads/zmk/app"
zmkbuild="${zmkapp}/build"

cd $zmkapp
west build -d build/left -b seeeduino_xiao_ble  -o=-j10 -- -DSHIELD=harold_left -DZMK_CONFIG=$zmkconf
west build -d build/right -b seeeduino_xiao_ble -o=-j10 -- -DSHIELD=harold_right -DZMK_CONFIG=$zmkconf

cd $localdir
cp ${zmkbuild}/right/zephyr/zmk.uf2 ./builds/harold_right.uf2
cp ${zmkbuild}/left/zephyr/zmk.uf2 ./builds/harold_left.uf2

echo ""
echo "Finished building Harold, harold_left/right.uf2 files are in ./builds/"
