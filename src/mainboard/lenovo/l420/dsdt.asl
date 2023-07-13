/* SPDX-License-Identifier: GPL-2.0-only */

#define THINKPAD_EC_GPE 0x16
#define EC_SCI_GPI 0x6

#include <acpi/acpi.h>

DefinitionBlock(
	"dsdt.aml",
	"DSDT",
	ACPI_DSDT_REV_2,
	OEM_ID,
	ACPI_TABLE_CREATOR,
	0x20230622 // OEM revision
)
{
	#include <acpi/dsdt_top.asl>
	#include <southbridge/intel/common/acpi/platform.asl>
	#include <southbridge/intel/bd82x6x/acpi/globalnvs.asl>
	#include <cpu/intel/common/acpi/cpu.asl>
	#include "acpi/platform.asl"

	Device (\_SB.PCI0) {
		#include <northbridge/intel/sandybridge/acpi/sandybridge.asl>
		#include <southbridge/intel/bd82x6x/acpi/pch.asl>
		#include <drivers/intel/gma/acpi/default_brightness_levels.asl>
	}

	#include <southbridge/intel/common/acpi/sleepstates.asl>
}
