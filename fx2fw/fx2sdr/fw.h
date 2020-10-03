/*
 * This file is part of the Narrowband-SDR project
 * This file is derived from the sigrok-firmware-fx2lafw project.
 *
 * Copyright (C) 2012 Joel Holdsworth <joel@airwebreathe.org.uk>
 * Copyright (C) 2020 William Woods <wwoo0003@student.monash.edu>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

#ifndef FW_H
#define FW_H

#define SYNCDELAY SYNCDELAY4 // SYNCDELAY4 is defined in delay.h

/*
 * Major and minor fx2lafw firmware version numbers.
 * These can be queried by the host via CMD_GET_FW_VERSION.
 *
 * The minor version number must be increased every time there are
 * backwards-compatible changes (which do not change the API).
 *
 * The major version number must be increased every time there are API
 * changes or functional changes which require adaptations in the host
 * (libsigrok) drivers, i.e. changes where old libsigrok versions would no
 * longer (properly) work with the new fx2lafw firmware.
 */
#define FW_VERSION_MAJOR	0
#define FW_VERSION_MINOR	1

#define LED_POLARITY		0 /* 1: active-high, 0: active-low */

#define LED_INIT()		do { PORTACFG = 0; OEA = (1 << 1 | 1 << 0); } while (0)

#define LED1_ON()		do { PA0 = LED_POLARITY; } while (0)
#define LED1_OFF()		do { PA0 = !LED_POLARITY; } while (0)
#define LED1_TOGGLE()		do { PA0 = !PA0; } while (0)

#define LED2_ON()		do { PA1 = LED_POLARITY; } while (0)
#define LED2_OFF()		do { PA1 = !LED_POLARITY; } while (0)
#define LED2_TOGGLE()		do { PA1 = !PA1; } while (0)

#endif
