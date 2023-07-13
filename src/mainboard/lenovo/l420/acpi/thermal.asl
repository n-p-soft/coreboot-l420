/* SPDX-License-Identifier: GPL-2.0-or-later */

External (\PPKG, MethodObj)

Scope (_TZ)
{
	Name (TPAS, 80)
	Name (TPC, 100)
	ThermalZone (TZ00)
	{
		/* Celsius to 1/10th Kelvin */
		Method (CTOK, 1)
		{
			Return (0x0AAC + (Arg0 * 10))
		}

		/* _CRT: Critical Temperature (Kelvin) */
		Method (_CRT, 0, Serialized)
		{
			Return (CTOK (TPC))
		}

		/* _PSL: Passive List */
		Method (_PSL, 0, Serialized)
		{
			Return (\PPKG ())
		}

		/* _PSV: Passive Temperature (Kelvin) */
		Method (_PSV, 0, Serialized)
		{
			Return (CTOK (TPAS))
		}

		/* _TC1: Thermal Constant 1 */
		Method (_TC1, 0, Serialized)
		{
			Return (0x02)
		}

		/* _TC1: Thermal Constant 2 */
		Method (_TC2, 0, Serialized)
		{
			Return (0x03)
		}

		/* _TSP: Thermal Sampling Period */
		Method (_TSP, 0, Serialized)
		{
			Return (0x64)
		}

		/* _TMP: Get Temperature */
		Method (_TMP, 0, Serialized)
		{
			If (\_SB.PCI0.LPCB.EC0.TMP2 > \_SB.PCI0.LPCB.EC0.TMP1)
			{
				Local0 = \_SB.PCI0.LPCB.EC0.TMP2
			}
			Else
			{
				Local0 = \_SB.PCI0.LPCB.EC0.TMP1
			}

			/* Check for invalid value */
			If ((Local0 < 35) | (Local0 > 115))
			{
				Local0 = 35
			}

			Return (CTOK (Local0))
		}
	}
}
