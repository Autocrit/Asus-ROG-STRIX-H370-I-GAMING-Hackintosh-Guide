![Banner](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/banner.jpg "Banner")

# Asus ROG STRIX H370-I GAMING Hackintosh Guide
This is a guide to installing macOS on ROG STRIX H370-I GAMING mini-ITX H370 motherboard, based on *CorpNewt's [Hackintosh Vanilla Desktop Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)*.

## Contents
1. [Intro](#intro)
2. [BIOS settings](#bios-settings)
3. [Installing Clover](#installing-clover)
4. [Kexts](#kexts)
5. [config.plist](#configplist)
6. [USB](#usb)
7. [WiFi and Bluetooth](#wifi-and-bluetooth)
8. [Miscellaneous](#miscellaneous)
9. [Feedback](#feedback)

## Intro
*CorpNewt*'s *[Hackintosh Vanilla Desktop Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)* (which I will refer to as *The Guide*) is just about as clear and easy-to-follow as a guide can be so I wont attempt to duplicate it here. If something is missing here it's probably because it's already covered by *The Guide*.

There are some configuration settings and files specific to this motherboard (and to a lesser extent to all H370-based motherboards), and that is what I want to cover for the ROG STRIX H370-I GAMING.

## BIOS settings
I need to add more here but:
1. `Launch CSM: Enabled` seems to be necessary to get output from an Nvidia GTX 1080 graphics card; otherwise, `Launch CSM: Disabled` works
2. BIOS version 2012 problem/solution by *Satanichia* on [tonymacx86.com](https://www.tonymacx86.com/threads/a-solution-of-asus-new-bios-ver-2012-not-downgrading.273151/)

## Installing Clover
Other chipsets might require just three EFI drivers (assuming you're not using FileVault): *AptioMemoryFix*, *HFSPlus* or *VBoxHfs-64* and *ApfsDriverLoader*. H370 also needs *EmuVariableUefi-64* in order to have working sleep, restart and shutdown.

>:bulb: If your macOS install is freezing/crashing at something like 2 minutes remaining you might not have installed *EmuVariableUefi-64*.

Clover installation options should look like:
![Clover installation options](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-install-options-2.png "Clover installation options")

## Kexts
The required kexts are as described in *The Guide* i.e. *IntelMausiEthernet.kext* (and/or *RealtekRTL8111.kext* for the Realtek LAN port), *USBInjectAll.kext*, *WhateverGreen.kext*, *AppleALC.kext*, *Lilu.kext*, *VirtualSMC.kext* and *XHCI-unsupported.kext*.

I use [build_lilu.sh](http://headsoft.com.au/download/mac/build_lilu.zip) to clone and build the latest *Lilu.kext*, *VirtualSMC.kext*, *WhateverGreen.kext*, *AppleALC.kext* etc.

## config.plist
*The Guide* covers the process of creating a config.plist step-by-step from scratch. This is the recommended approach but here is a sample config.plist (iMac18,1 SMBIOS, connected iGPU) as an alternative starting point:

[imac18,1-config.plist](https://github.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/blob/master/imac18,1-config.plist)

### Tools
There are several ways to mount an EFI partition but in general I use Clover Configurator:
![Mount EFI in Clover Configurator](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-configigurator-mount-efi.png "Mount EFI in Clover Configurator")
Kexts can be copied into /Volumes/EFI/EFI/CLOVER/kexts/Other using Finder.
For config.plist editing I use a text editor e.g. BBEdit (evaluation version), Clover Configurator and a plist editor e.g. Xcode.

### Audio
Audio is enabled by *AppleALC.kext* (which is dependent on *Lilu.kext*) and a layout that works with this motherboard's S1220A codec:
```
<key>Audio</key>
<dict>
	<key>Inject</key>
	<integer>7</integer>
	<key>ResetHDA</key>
	<true/>
</dict>
```
![Audio in Clover Configurator](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-configurator-audio.png "Audio in Clover Configurator")

### Graphics
This is covered by *The Guide* but:

**Connected iGPU** (use an iMac18,1 SMBIOS)
```
<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
<dict>
	<key>AAPL,ig-platform-id</key>
	<data>BwCbPg==</data>
</dict>
```
**Connector-less iGPU** (use an iMac18,3 SMBIOS)
```
<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
<dict>
	<key>AAPL,ig-platform-id</key>
	<data>AwCSPg==</data>
</dict>
```

**iGPU HDMI port fix**

I have a dual monitor setup using the DisplayPort and HDMI ports but without these fixes I get no output from the HDMI port, and even with them I have to reconnect the HDMI port after booting.
```
<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
<dict>
	<key>AAPL,ig-platform-id</key>
	<data>BwCbPg==</data>
	<key>disable-external-gpu</key>
	<data>AQAAAA==</data>
	<key>framebuffer-con1-enable</key>
	<data>AQAAAA==</data>
	<key>framebuffer-con1-type</key>
	<data>AAgAAA==</data>
	<key>framebuffer-con1-pipe</key>
	<data>CAAAAA==</data>
	<key>framebuffer-con1-busid</key>
	<data>AgAAAA==</data>
	<key>framebuffer-con2-enable</key>
	<data>AQAAAA==</data>
	<key>framebuffer-con2-index</key>
	<data>/////w==</data>
	<key>framebuffer-patch-enable</key>
	<data>AQAAAA==</data>
	<key>framebuffer-portcount</key>
	<data>AgAAAA==</data>
	<key>framebuffer-pipecount</key>
	<data>AgAAAA==</data>
</dict>
```

**Nvidia GPU** (for High Sierra)

Once macOS is intalled you'll need the Nvidia driver version that matches your macOS build number (listed [here](https://gfe.nvidia.com/mac-update)), the connectorless AAPL,ig-platform-id from above, an iMac18,3 SMBIOS and the following in SystemParameters:
```
<key>NvidiaWeb</key>
<true/>
```
![Clover Configurator NvidiaWeb](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-configurator-nvidia.png "Clover Configurator NvidiaWeb")

Here's an sample config.plist with those changes (connectorless iGPU, iMac13,1 SMBIOS and NvidiWeb=true)

[iMac18,3-nvidia-config.plist](https://github.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/blob/master/iMac18,3-nvidia-config.plist)

### TRIM for SSDs
Add the following inside the KernelAndKextPatches/KextsToPatch array (I've included it in the sample files):
```
<dict>
	<key>Comment</key>
	<string>Enable TRIM for SSD</string>
	<key>Disabled</key>
	<false/>
	<key>Find</key>
	<data>AEFQUExFIFNTRAA=</data>
	<key>Name</key>
	<string>com.apple.iokit.IOAHCIBlockStorage</string>
	<key>Replace</key>
	<data>AAAAAAAAAAAAAAA=</data>
</dict>
```
Clover Configurator has the patch built-in (select it from the drop-down menu):
![TRIM patch in Clover Configurator](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-configurator-trim.png "TRIM patch in Clover Configurator")

## USB
>:bulb: If you are having problems with USB mouse or keyboard not working during or post macOS installation or other USB issues, you probably haven't tackled the 15-port limit that applies to 10.11 onwards.

I recommend following *RehabMan's*  guide to *[Creating a Custom SSDT for USBInjectAll.kext](https://www.tonymacx86.com/threads/guide-creating-a-custom-ssdt-for-usbinjectall-kext.211311/)*. This will limit you to 15 ports (and fewer physical ports because USB 3 ports use two ports, one for USB 3 and one for USB 2). The locations of the USB ports on the Asus ROG STRIX H370-I GAMING motherboard are:

![Asus H370-I GAMING USB ports](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/asus-h370-i-gaming-usb-ports-2.png "Asus H370-I GAMING USB ports")

Example [SSDT-UIAC.dsl](https://github.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/blob/master/SSDT-UIAC.dsl)

In this example SSDT-UIAC.dsl I have chosen to exclude the internal USB2.0 headers (I don't use them), and port(s) HS05/SS05 (one of the internal-to-front-panel USB 3.1 Gen 1 ports and its USB 2 counterpart), leaving a total of 15 ports. The excluded ports are commented-out (i.e. between `/*` and `*/`).

![IORegistryExplorer USB ports](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/ioregistryexplorer-usb.png "IORegistryExplorer USB ports")

As descibed in *RehabMan's*  guide, SSDT-UIAC.dsl needs to be compiled with MaciASL and the resulting file (SSDT-UIAC.aml) is placed in */Volumes/EFI/EFI/CLOVER/ACPI/patched*. *USBInjectAll.kext* and *XHCI-unsupported.kext* are still needed.

## WiFi and Bluetooth
![Bluetooth](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/bluetooth2.png "Bluetooth")

I replaced the Intel WiFi/BT card with a Broadcom BCM94352Z based DW1560 from [Ebay](https://www.ebay.co.uk/itm/172212358962).
For kexts I have *AirportBrcmFixup.kext*, *BrcmFirmwareData.kext* and *BrcmPatchRAM2.kext*. I also added a `brcmfx-country=XX` boot argument e.g.
```
<key>Arguments</key>
<string>keepsyms=1 dart=0 debug=0x100 brcmfx-country=UK</string>
```

## Miscellaneous

### Dual booting macOS and Windows
* It is easiest to install Windows on a seperate drive (as opposed to sharing the same drive), and to disconnect the macOS drive(s) when installing Windows
* Clean the drive using the following (during installation)

    ```
    shift + F10
    diskpart
    list disk (note the disk # e.g. 0)
    select disk # (e.g. select disk 0) 
    clean
    exit
    exit
    ```

* Allow the Windows installer to create the necessary partitions
* Once both operating systems are installed, set the drive with your EFI partition (usually the drive with macOS on it) as the first boot drive in your BIOS settings and use the Clover boot screen to select an operating system
* An alternative to dual-booting is to run Windows in a virtual machine; VirtualBox, being free, is a good option

### Testing
It is a good idea to keep at least one testbed for macOS updates, new versions, new configurations, as a backup etc. Unlike Windows, macOS will happily install to an external drive, and if that drive is a spare SSD in a USB 3.1 Gen 2 enclosure (I have this one https://www.amazon.co.uk/gp/product/B07D2BHVBD), it will be fast. Even a USB 3.0 or 3.1 flash drive will do the job and doesn't cost much. Carbon Copy Cloner can be used to clone the contents of a drive back-and-forth to the test drive.

## Feedback
Questions, comments, suggestions: https://www.reddit.com/r/hackintosh/comments/avdfz7/asus_rog_strix_h370i_gaming_hackintosh_guide/
