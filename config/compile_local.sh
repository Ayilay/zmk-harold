#!/bin/bash

# Uses local copy of ZMK to compile keyboard. It's faster


if [ $# -gt 0 ]; then
    echo "usage: $0 $1"
    exit 1
fi

echo "building harold keyboard, plz wait..."

localdir=$(pwd)
zmkconf="/home/ayilay/github/zmk-harold/config"
zmkapp="/home/ayilay/github/zmk/app"
zmkbuild="${zmkapp}/build"

#------------------------------------------------------------
# Error Checking
#------------------------------------------------------------

[ -d "$zmkconf"  ] || { echo "zmk conf dir ${zmkconf} (for keyboard config) does not exist"; exit 1; }
[ -d "$zmkapp"   ] || { echo "zmk app dir ${zmkapp} does not exist"; exit 1; }
[ -d "$zmkbuild" ] || { echo "build dir ${zmkbuild} does not exist, please make it within ${zmkconf}"; exit 1; }
[ -d "./builds" ]  || { echo "directory './builds' does not exist, please create it"; exit 1; }

#------------------------------------------------------------
# The Fun Stuff
#------------------------------------------------------------

# IF build errors occur, add --pristine to WEST_OPTS
WEST_OPTS="-o=-j10"
BOARD="-b seeeduino_xiao_ble"

cd $zmkapp
west build -d build/left  $BOARD $WEST_OPTS -- -DSHIELD=harold_left -DZMK_CONFIG=$zmkconf
west build -d build/right $BOARD $WEST_OPTS -- -DSHIELD=harold_right -DZMK_CONFIG=$zmkconf

cd $localdir
cp ${zmkbuild}/left/zephyr/zmk.uf2 ./builds/harold_left.uf2
cp ${zmkbuild}/right/zephyr/zmk.uf2 ./builds/harold_right.uf2

echo ""
echo "Finished building Harold, harold_left/right.uf2 files are in ./builds/"

cp ./builds/* ~ayilay/winAyilay/Downloads
echo "Copied build/ files to Windows partition"
