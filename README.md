# Narrowband-SDR
A four-channel narrowband SDR receiver based around the Mirics MSi001, Maxim MAX11131 and Cypress FX2LP.

Simulations of the RF architecture and other related things are in the **simulations/** folder.

KiCAD PCB designs are in the **pcb/** folder.

Firmware running on the Cypress FX2LP is stored in the **fx2fw/** folder, although most of the code in this folder is the fx2lib, which provides most of the functionality and provides utilities for python 2.7 to upload/program the firmware.
fx2lib has a few dependencies:
* make
* gcc
* libusb-1.0
* SDCC
* python 2.7
* swig
