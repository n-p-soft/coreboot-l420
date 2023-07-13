/* SPDX-License-Identifier: GPL-2.0-only */

#include <ec/quanta/it8518/acpi/ec.asl>

Scope (\_SB.PCI0.LPCB.EC0)
{
	/* set fan in automatic mode */
	HFSP = 0x80
}

#include "mainboard.asl"
#include "thermal.asl"
