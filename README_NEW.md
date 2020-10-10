![Banner](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/banner4.jpg "Banner")

# Asus ROG STRIX H370-I GAMING Hackintosh Guide
The old version of this guide, using Clover and *CorpNewt's [Hackintosh Vanilla Desktop Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)* method can be found [here](README_OLD.md).

## Miscellaneous

### My system
CPU: Core i7-8700K | Cooler: Noctua NH-L9I Chromax | Motherboard: Asus ROG STRIX H370-I GAMING | Memory: Corsair Vengeance LPX 16GB (2 x 8GB) DDR4-3200 | Storage: 2 x Samsung 970 Evo Plus | Video card: AMD Radeon RX 5700 XT | Case: Dan A4-SFX | PSU: Corsair SF600 Platinum

## Contents
1. [Intro](#intro)
2. [BIOS settings](#bios-settings)
3. [Installing Clover](#installing-clover)
4. [Kexts](#kexts)

## Guide
https://dortania.github.io/OpenCore-Install-Guide/

## ACPI
Ran SSDTTime in Windows with the following:
- Dump DSDT
- FakeEC
- PluginType
- PMC
- AWAC
(- FixHPET)
Added
- SSDT-USBX.aml

## PlatformInfo
iMac19,1 SMBIOS

## Post install
"The system has posted in safe mode"
- DisableRtcChecksum in Kernal->Quirks

## USB port limit
- still using USBInjectAll.kext, XHCI-unsupported.kext and SSDT-UIAC.aml
- remember to OC Snapshot in ProperTree after any kext, driver or ACPI additions or deletions
- alternatively use USBMap

## GUI chooser
- not working, why not?

## Audio
- Layout ID 7 in DeviceProperies:

<key>PciRoot(0x0)/Pci(0x1b,0x0)</key>
<dict>
	<key>layout-id</key>
	<data>BwAAAA==</data>
</dict>

## USB
>:bulb: If you are having problems with USB mouse or keyboard not working during or post macOS installation or other USB issues, you probably haven't tackled the 15-port limit that applies to 10.11 onwards.

I recommend following *RehabMan's*  guide to *[Creating a Custom SSDT for USBInjectAll.kext](https://www.tonymacx86.com/threads/guide-creating-a-custom-ssdt-for-usbinjectall-kext.211311/)*. This will limit you to 15 ports (and fewer physical ports because USB 3 ports use two ports, one for USB 3 and one for USB 2). The locations of the USB ports on the Asus ROG STRIX H370-I GAMING motherboard are:

![Asus H370-I GAMING USB ports](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/asus-h370-i-gaming-usb-ports-2.png "Asus H370-I GAMING USB ports")

Example [SSDT-UIAC.dsl](https://github.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/blob/master/SSDT-UIAC.dsl)

In this example SSDT-UIAC.dsl I have chosen to exclude the internal USB2.0 headers (I don't use them), and port(s) HS05/SS05 (one of the internal-to-front-panel USB 3.1 Gen 1 ports and its USB 2 counterpart), leaving a total of 15 ports. The excluded ports are commented-out (i.e. between `/*` and `*/`).

![IORegistryExplorer USB ports](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/ioregistryexplorer-usb.png "IORegistryExplorer USB ports")

As descibed in *RehabMan's*  guide, SSDT-UIAC.dsl needs to be compiled with MaciASL and the resulting file (SSDT-UIAC.aml) is placed in */Volumes/EFI/EFI/CLOVER/ACPI/patched*. *USBInjectAll.kext* and *XHCI-unsupported.kext* are still needed.

## Feedback
Questions, comments, suggestions: https://www.reddit.com/r/hackintosh/comments/avdfz7/asus_rog_strix_h370i_gaming_hackintosh_guide/. 
