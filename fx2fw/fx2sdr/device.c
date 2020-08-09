/**
 * Copyright (C) 2009 Ubixum, Inc. 
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 **/

#include <fx2regs.h>
#include <fx2macros.h>
#include <fx2ints.h>
#include <autovector.h>
#include <delay.h>
#include <setupdat.h>
#include <eputils.h>
#include <gpif.h>


#ifdef DEBUG_FIRMWARE
#include <stdio.h>
#else
#define printf(...)
#endif

#include "fw.h"



BYTE vendor_command;

/*
* These handlers fill out the pre-defs which fx2lib/includes/setupdat.c is looking for:
*
    extern BOOL handle_get_descriptor();
    extern BOOL handle_vendorcommand(BYTE cmd);
    extern BOOL handle_set_configuration(BYTE cfg);
    extern BOOL handle_get_interface(BYTE ifc, BYTE* alt_ifc);
    extern BOOL handle_set_interface(BYTE ifc,BYTE alt_ifc);
    extern BYTE handle_get_configuration();
    extern void handle_reset_ep(BYTE ep); <-- does not appear to ever be used in setupdat.c
*/

BOOL handle_get_descriptor() {
  // by returning FALSE, _handle_get_descriptor in fx2lib/includes/setupdat.c takes over
  return FALSE;
}

//************************** Configuration Handlers *****************************

// change to support as many interfaces as you need
//volatile xdata BYTE interface=0;
//volatile xdata BYTE alt=0; // alt interface

// set *alt_ifc to the current alt interface for ifc
BOOL handle_get_interface(BYTE ifc, BYTE* alt_ifc) {
// *alt_ifc=alt;
 return TRUE;
}
// return TRUE if you set the interface requested
// NOTE this function should reconfigure and reset the endpoints
// according to the interface descriptors you provided.
BOOL handle_set_interface(BYTE ifc,BYTE alt_ifc) {  
 printf ( "Set Interface.\n" );
 //interface=ifc;
 //alt=alt_ifc;
 return TRUE;
}

// handle getting and setting the configuration
// 1 is the default.  If you support more than one config
// keep track of the config number and return the correct number
// config numbers are set int the dscr file.
//volatile BYTE config=1;
BYTE handle_get_configuration() { 
 return 1;
}

// NOTE changing config requires the device to reset all the endpoints
BOOL handle_set_configuration(BYTE cfg) { 
 printf ( "Set Configuration.\n" );
 //config=cfg;
 return TRUE;
}


//******************* VENDOR COMMAND HANDLERS **************************


BOOL handle_vendorcommand(BYTE cmd) {
 // your custom vendor handler code here..
 return FALSE; // not handled by handlers
}

/**********************************************************
* USB endpoint setup.
**********************************************************
* derived from fx2lafw.c in the Sigrok project
*/
static void setup_endpoints(void)
{
	/* Setup EP2 (IN). */
	EP2CFG = (1u << 7) |		  /* EP is valid/activated */
		 (1u << 6) |		  /* EP direction: IN */
		 (1u << 5) | (0u << 4) |  /* EP Type: bulk */
		 (1u << 3) |		  /* EP buffer size: 1024 */
		 (0u << 2) |		  /* Reserved. */
		 (0u << 1) | (0u << 0);	  /* EP buffering: quad buffering */
	SYNCDELAY;

	/* Disable all other EPs (EP1, EP4, EP6, and EP8). */
	EP1INCFG &= ~bmVALID;
	SYNCDELAY;
	EP1OUTCFG &= ~bmVALID;
	SYNCDELAY;
	EP4CFG &= ~bmVALID;
	SYNCDELAY;
	EP6CFG &= ~bmVALID;
	SYNCDELAY;
	EP8CFG &= ~bmVALID;
	SYNCDELAY;

	/* EP2: Reset the FIFOs. */
	/* Note: RESETFIFO() gets the EP number WITHOUT bit 7 set/cleared. */
	RESETFIFO(0x02);

	/* EP2: Enable AUTOIN mode. Set FIFO width to 8bits. */
	EP2FIFOCFG = bmAUTOIN;
	SYNCDELAY;

	/* EP2: Auto-commit 512 (0x200) byte packets (due to AUTOIN = 1). */
	EP2AUTOINLENH = 0x02;
	SYNCDELAY;
	EP2AUTOINLENL = 0x00;
	SYNCDELAY;

	/* EP2: Set the GPIF flag to 'full'. */
	EP2GPIFFLGSEL = (1 << 1) | (0 << 1);
	SYNCDELAY;
}


//********************  INIT ***********************
/*
* this comes from fx2lafw_init in the Sigrok fx2lafw project
*/
void main_init() {
	/* Set DYN_OUT and ENH_PKT bits, as recommended by the TRM. */
	REVCTL = bmNOAUTOARM | bmSKIPCOMMIT;

	vendor_command = 0;

	/* Renumerate. */
	RENUMERATE_UNCOND();

	SETCPUFREQ(CLK_48M);

	USE_USB_INTS();

	/* TODO: Does the order of the following lines matter? */
	ENABLE_SUDAV();
	ENABLE_EP2IBN();
	ENABLE_HISPEED();
	ENABLE_USBRESET();

	LED_INIT();
	LED_ON();

	/* Init timer2. */
	RCAP2L = -500 & 0xff;
	RCAP2H = (-500 & 0xff00) >> 8;
	T2CON = 0;
	ET2 = 1;
	TR2 = 1;

	/* Global (8051) interrupt enable. */
	EA = 1;

	/* Setup the endpoints. */
	setup_endpoints();

	/* Put the FX2 into GPIF master mode and setup the GPIF. */
	//gpif_init_la();
}


void main_loop() {
 // do some work
}


