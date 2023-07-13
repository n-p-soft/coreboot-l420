/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/pci_ops.h>
#include <northbridge/intel/sandybridge/raminit_native.h>
#include <southbridge/intel/bd82x6x/pch.h>
#include <northbridge/intel/sandybridge/sandybridge.h>
#include <device/device.h>

/*
 * USB map:
 * EHCI1:
 * 0 -> USB0 eSata Combo, OC0, 1A
 * 1 -> USB1 (AUO3), OC0, 1A
 * 2 -> Express Card
 * 3 -> Camera
 * 4 -> WLAN
 * 5 -> WWAN
 * 6 -> x
 * EHCI2:
 * 7 -> x
 * 8 -> USB3, OC4
 * 9 -> USB2, OC4
 * 10 -> Fingerprint reader
 * 11 -> Dock USB
 * 12 -> x (Reserved)
 * 13 -> BlueTooth
 */
const struct southbridge_usb_port mainboard_usb_ports[] = {
	{ 1, 0,  0 }, /* 0 OC0 */
	{ 1, 1,  0 }, /* 1 OC0 */
	{ 1, 0, -1 },
	{ 1, 0, -1 },
	{ 1, 0, -1 },
	{ 1, 0, -1 },
	{ 0, 0, -1 }, /* 6 off */
	{ 0, 0, -1 }, /* 7 off */
	{ 1, 1,  4 }, /* 8 USB3 OC4 */
	{ 1, 1,  4 }, /* 9 USB2 OC4 */
	{ 1, 0, -1 },
	{ 1, 0, -1 },
	{ 0, 0, -1 }, /* 12 off */
	{ 1, 0, -1 },
};

void mainboard_get_spd(spd_raw_data *spd, bool id_only)
{
	read_spd(&spd[0], 0x50, id_only);
	read_spd(&spd[2], 0x52, id_only);
}

void mainboard_early_init(int s3resume)
{
}
