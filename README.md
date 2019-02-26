# Asus ROG STRIX H370-I GAMING Hackintosh Guide
This is a guide to installing macOS on ROG STRIX H370-I GAMING mini-ITX H370 motherboard, based on *CorpNewt's [Hackintosh Vanilla Desktop Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)*.

## Intro
*CorpNewt's *[Hackintosh Vanilla Desktop Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)* (which I will refer to as *The Guide*) is just about as clear and easy-to-follow as a guide can be so I wont attempt to duplicate it here. If something is missing here it's probably because it's already covered by in *The Guide*.

There are however some configuration settings and files specific to this motherboard (and to a lesser extent applicable to all H370-based motherboards), and that is what I intend to cover here for the ROG STRIX H370-I GAMING.

## My system
|Component|Part|
|:-|:-|
| CPU | Core i7-8700K |
|Cooler|Noctua NH-L12S|
|Motherboard|Asus ROG STRIX H370-I GAMING|
|Memory|Corsair Vengeance LPX 16GB (2 x 8GB) DDR4-3200|
|Storage|2 x Crucial MX500 500GB 2.5" SSD|
|Video card|Gigabyte GeForce GTX 1080 8GB/iGPU in Mojave|
|Case|Lazer3D LZ7|
|PSU|Corsair SF450W Gold|

## BIOS settings
I need to add more here but:
1. VT-d: *disabled*
2. Launch CSM: *enabled* (seems to be necessary to get output from the Nvidia graphics card; otherwise, *disabled* works)

## Installing Clover
Other chipsets might require just three EFI drivers: *AptioMemoryFix*, *HFSPlus* or *VBoxHfs-64* and *ApfsDriverLoader*. H370 also needs *EmuVariableUefi-64* in order to have working sleep, restart and shutdown.

If your macOS install is freezing/crashing at something like 2 minutes remaining you might not have installed *EmuVariableUefi-64*.

Clover installation options should look like:
![Clover installation options](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-install-options-2.png "Clover installation options")

## Kexts
The required kexts are as described in *The Guide* i.e. *IntelMausiEthernet.kext* (and/or *RealtekRTL8111.kext* for the Realtek LAN port), *USBInjectAll.kext*, *WhateverGreen.kext*, *AppleALC.kext*, *Lilu.kext*, *VirtualSMC.kext* and *XHCI-unsupported.kext*

## config.plist
*CorpNewt*'s guide covers step-by-step the process of creating a config.plist from scratch.

### Tools
There are sevreal ways to mount an EFI partition but in general I use Clover Configurator:
![Mount EFI in Clover Configurator](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-configigurator-mount-efi.png "Mount EFI in Clover Configurator")
Kexts can be copied into /Volumes/EFI/EFI/CLOVER/kexts/Other using Finder.
For config.plist editing I use a text editor e.g. BBEdit (evaluation version), Clover Configurator and a plist editor e.g. Xcode.

### Audio
Audio is enabled by *AppleALC.kext* (which is dependent on *Lilu.kext*) and layout that works with this motherboard's S1220A codec:
```<key>Audio</key>
<dict>
	<key>Inject</key>
	<integer>7</integer>
	<key>ResetHDA</key>
	<true/>
</dict>
```
![Audio in Clover Configurator](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/clover-configurator-audio.png "Audio in Clover Configurator")

### Graphics
Again this is covered the *The Guide* but:

iGPU connected
```
<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
<dict>
	<key>AAPL,ig-platform-id</key>
	<data>BwCbPg==</data>
</dict>
```
iGPU connectorless
```
<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
<dict>
   <key>AAPL,ig-platform-id</key>
   <data>AwCSPg==</data>
</dict>
```

iGPU HDMI port fix
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

## USB
If you are having problems with USB mouse or keyboard not working during or post macOS installation or other USB issues, you probably haven't tackled the 15-port limit that applies to 10.11 onwards.

I recommend following *RehabMan's*  guide to [Creating a Custom SSDT for USBInjectAll.kext](https://www.tonymacx86.com/threads/guide-creating-a-custom-ssdt-for-usbinjectall-kext.211311/). This will limit you to 15 ports (and fewer physical ports because USB 3 ports take up two ports, one for USB 3 and one for USB 2). The locations of the USB ports on the Asus ROG STRIX H370-I GAMING motherboard are:

![Asus H370-I GAMING USB ports](https://raw.githubusercontent.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/master/asus-h370-i-gaming-usb-ports-2.png "Asus H370-I GAMING USB ports")

Example [SSDT-UIAC.dsl](https://github.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/blob/master/SSDT-UIAC.dsl)

In this example SSDT-UIAC.dsl I have chosen to exclude the internal USB2.0 headers (I don't use them), and port(s) HS05/SS05 (one of the internal-to-front-panel USB 3.1Gen1 ports and its USB2.0 counterpart), leaving a total of 15 ports. The excluded ports are commented-out (i.e. between /** and **/).
