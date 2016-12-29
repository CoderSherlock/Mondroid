#!/bin/sh

#####################################################
#													#
#	This script used for one-click root nexus 5X	#
#													#
#													#
#####################################################



Android_Debug_Tools_Dir=${HOME}/Android/Sdk/platform-tools

zip="./UPDATE-SuperSU-v2.79-20161211114519.zip"
rec="./twrp-3.0.2-2-bullhead.img"

Adb=${Android_Debug_Tools_Dir}/adb
Fastboot=${Android_Debug_Tools_Dir}/fastboot

devloc="/sdcard/"

cmd="$Adb push $zip $devloc"
eval $cmd

echo "Reboot to bootloader ..."
cmd="$Adb reboot bootloader"
eval $cmd

sleep 5s

cmd="sudo $Fastboot flash recovery $rec"
eval $cmd

echo "\nboot to recovery and pick zip file under $devloc\n"
