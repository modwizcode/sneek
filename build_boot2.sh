#!/bin/sh
make -C es clean all
make -C fs clean all
make -C fs-usb clean all
make -C di clean all
make -C mini-tree-mod clean all

echo Patching..

echo Patching for SNEEK
echo IOSKPatch: SD \(with di\) 
./IOSKpatch/IOSKPatch 0000000e.app 0000000E-TMP.app -s -d > /dev/null
echo elfins: Creating kernel_sd_di.bin \(SDCard as NAND, with DI module support\)
./ELFIns/elfins 0000000E-TMP.app kernel_sd_di.bin es/esmodule.elf fs/iosmodule.elf > /dev/null

echo IOSKPatch: SD \(no di\) 
./IOSKpatch/IOSKPatch 0000000e.app 0000000E-TMP.app -s > /dev/null
echo elfins: Creating kernel_sd.bin \(SDCard as NAND\)
./ELFIns/elfins 0000000E-TMP.app kernel_sd.bin es/esmodule.elf fs/iosmodule.elf > /dev/null

echo Patching for UNEEK
echo IOSKPatch: USB \(with di\)
./IOSKpatch/IOSKPatch 0000000e.app 0000000E-TMP.app -u -d > /dev/null
echo elfins: Creating kernel_usb_di.bin \(USB as NAND, with DI module support\)
./ELFIns/elfins 0000000E-TMP.app kernel_usb_di.bin es/esmodule.elf fs-usb/iosmodule.elf > /dev/null

echo Patching for UNEEK
echo IOSKPatch: USB \(no di\)
./IOSKpatch/IOSKPatch 0000000e.app 0000000E-TMP.app -u > /dev/null
echo elfins: Creating kernel_usb.bin \(USB as NAND\)
./ELFIns/elfins 0000000E-TMP.app kernel_usb.bin es/esmodule.elf fs-usb/iosmodule.elf > /dev/null

echo eFIX: Creating di.bin
./eFIX/efix di/dimodule.elf > /dev/null

rm 0000000E-TMP.app -v
