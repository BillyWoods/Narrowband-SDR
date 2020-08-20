#!/bin/sh

modprobe usbmon;
if [ $? -ne 0 ]
then
  echo "Could not load usbmon\n";
  exit 1;
fi

# find our usb bus and device number
VID=${1:-"04b4"};
dev_string=`lsusb -d $VID:`;
#echo $dev_string;
bus=`echo $dev_string | awk '{gsub("^0*", "", $2); print $2}'`;
dev=`echo $dev_string | awk '{print $4}'`;
#echo "$bus";
#echo "$dev";

# listen into bus for packets involving our device
cat "/sys/kernel/debug/usb/usbmon/${bus}u" | grep $dev
