# Asus ROG STRIX H370 I GAMING Hackintosh Guide
A guide to installing macOS on this mini-ITX H370 motherboard based on [*CorpNewt*'s Hackintosh Vanilla Desktop Guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/).

## Intro
This isn't intented to be a standalone guide as it doens't make sense to re what is already a clear and concise easy-to-follow. I will mostly describe It assumes you have already studied and understood the Rather, I will mostly describe areas where I will describe some of the 

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
A typical Z390 Clover installation (i.e. one not requiring FileVault) will use just three EFI drivers: AptioMemoryFix, HFSPlus or VBoxHfs-64 and ApfsDriverLoader.

H370 needs EmuVariableUefi-64 in order to have working sleep, restart and shutdown.

If your macOS install is freezing at something like 2 minutes remaining you might not have installed EmuVariableUefi-64 and it is in fact crashing when trying to restart.

Clover installation options should look like:

![Clover installation options](https://github.com/Autocrit/Asus-ROG-STRIX-H370-I-GAMING-Hackintosh-Guide/blob/master/Clover%20install%20options%202.png "Clover installation options")
