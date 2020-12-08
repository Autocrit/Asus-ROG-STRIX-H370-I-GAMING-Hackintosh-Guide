UPDATE_OC="true"
UPDATE_KEXTS="true"

DEST_FOLDER="/Volumes/EFI/EFI"

if [ "${UPDATE_OC}" == "true" ] ; then
	echo "Updating OpenCore"
	
	SOURCE_FOLDER="${HOME}/Downloads/OpenCore-0.6.4-RELEASE/X64/EFI"

	# Drivers to copy
	FILENAME=(
		"BOOT/BOOTx64.efi"
		"OC/OpenCore.efi"
		"OC/Drivers/OpenRuntime.efi"
		"OC/Drivers/OpenCanopy.efi"
	)

	for i in ${FILENAME[@]}
	do
		cp -v "${SOURCE_FOLDER}/$i" "${DEST_FOLDER}/$i"
	done
fi

if [ "${UPDATE_KEXTS}" == "true" ] ; then
	echo "Running Lilu-and-Friends"
	
	DEV_FOLDER="${HOME}/Development"

	echo "Updating kexts"
	echo "Deleting ${DEV_FOLDER}/Lilu-and-Friends"
	rm -rfv "${DEV_FOLDER}/Lilu-and-Friends"
	cd "${DEV_FOLDER}"
	git clone https://github.com/corpnewt/Lilu-and-Friends
	cd "Lilu-and-Friends"
	chmod +x Run.command
	./Run.command
	
	# Select 6, 30, 33, 36, 44, 47, 54
	
	cd kexts
	unzip \*.zip
	
	# Kexts to copy
	FILENAME=(
		"AppleALC.kext"
		"IntelMausi.kext"
		"Lilu.kext"
		"NVMeFix.kext"
		"USBInjectAll.kext"
		"WhateverGreen.kext"
		"XHCI-unsupported.kext"
		"VirtualSMC/Kexts/SMCProcessor.kext"
		"VirtualSMC/Kexts/SMCSuperIO.kext"
		"VirtualSMC/Kexts/VirtualSMC.kext"
	)
	
	echo "Copying kexts"
	
	for i in ${FILENAME[@]}
	do
		cp -vr "$i" "${DEST_FOLDER}/OC/Kexts/"
	done
fi
