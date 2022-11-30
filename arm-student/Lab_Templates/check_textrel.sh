#/bin/sh
if readelf --all $1 | grep -q 'TEXTREL'; then
   echo ".text relocations detected. Program will not run on android targets with ABI>=23"
   exit 1
else
    echo "No .text relocations detected. Program should run on targets with ABI>=23"
    exit 0
fi
