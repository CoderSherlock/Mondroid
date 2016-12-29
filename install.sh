#!/bin/sh


# Prof.
# 	This is not cool.
#	AT ALL.
#
# HPZ

Android_Debug_Tools_Dir=${HOME}/Android/Sdk/platform-tools

Kernel_Source_Dir=${HOME}/Mondroid/kernelsource/msm
Kernel_Image_Dir=${Kernel_Source_Dir}/arch/arm64/boot

Pack_Image_Dir=${HOME}/Mondroid/kernel
Factory_Image_Dir=${Pack_Image_Dir}/factory		# TODO:Add a factory recovery
Rooted_Image_Dir=${Pack_Image_Dir}/rooted

Imgname="testboot.img"

#
#	Symbolic Link Kernel Image to Image Directory
#	$ ln -s Image-File Linker	
#	


if [ -f $Pack_Image_Dir/Image-test ]; then
    echo "Remove previews link"
	eval "rm $Pack_Image_Dir/Image-test"
fi

cmd="ln -s $Kernel_Image_Dir/Image.gz-dtb $Pack_Image_Dir/Image-test"
#echo $cmd
eval $cmd


#
#	Pack up Kernel Image
#	$ abootimg --create testboot.img -f bootimg.cfg -k Image-test -r initrd.img 
#

# cmd="abootimg --create $Imgname -f $Factory_Image_Dir/bootimg.cfg -k $Pack_Image_Dir/Image-test -r $Factory_Image_Dir/initrd.img -c \"bootsize=12500000\"" 
cmd="abootimg --create $Pack_Image_Dir/$Imgname -f $Rooted_Image_Dir/bootimg.cfg -k $Pack_Image_Dir/Image-test -r $Rooted_Image_Dir/initrd.img -c \"bootsize=12550000\"" 

#echo $cmd
eval $cmd


Adb=${Android_Debug_Tools_Dir}/adb
Fastboot=${Android_Debug_Tools_Dir}/fastboot

echo "\nStart un-undoable\n"
sleep 10s

cmd="$Adb reboot bootloader"
eval $cmd

sleep 5s

cmd="sudo $Fastboot flash boot $Pack_Image_Dir/$Imgname "
eval $cmd
