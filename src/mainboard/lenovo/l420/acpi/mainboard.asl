/* SPDX-License-Identifier: GPL-2.0-only */

Scope (\_SB)
{
	Device (PWRB)
	{
		Name (_HID, EisaId("PNP0C0C"))
	}

	Device (LID0)
	{
		Name (_HID, EisaId ("PNP0C0D"))
		Name (_PRW, Package (0x02) // _PRW: Power Resources for Wake
		{
			0x18,
			0x03
		})
	}

	Device (CWDT)
	{
		Name (_HID, EisaId ("INT3F0D"))
		Name (_CID, EisaId ("PNP0C02"))
		Name (BUF0, ResourceTemplate ()
		{
			IO (Decode16,
			0x0454, // Range Minimum
			0x0454, // Range Maximum
			0x04,   // Alignment
			0x04,   // Length
			)
		})
		Method (_CRS, 0, Serialized)
		{
			Return (BUF0)
		}
	}
}
