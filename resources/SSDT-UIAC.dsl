// Initial full list SSDT-UIAC.dsl for Asus ROG STRIX H370-I GAMING
DefinitionBlock ("", "SSDT", 2, "hack", "UIAC", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            "8086_a36d", Package()
            {
                "port-count", Buffer() { 26, 0, 0, 0 },
                "ports", Package()
                {
                    "HS01", Package() // Rear I/O upper right (USB 3.1 Gen2 Type A)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                    "HS02", Package() // Rear I/O lower right (USB 3.1 Gen2 Type A)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 2, 0, 0, 0 },
                    },
                    "HS03", Package() // Rear I/O upper middle (USB 3.1 Gen1)	
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    "HS04", Package() // Rear I/O lower middle (USB 3.1 Gen2 Type C)
                    {
                        "UsbConnector", 9,
                        "port", Buffer() { 4, 0, 0, 0 },
                    },
                    /*
                    "HS05", Package() // Internal->lower front panel (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },
                    */
                    "HS06", Package() // Internal->upper front panel (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },
                    "HS07", Package() // Rear I/O upper left (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },
                    "HS08", Package() // Rear I/O lower left (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 8, 0, 0, 0 },
                    },
                    /*
                    "HS09", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 9, 0, 0, 0 },
                    },
                    "HS10", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 10, 0, 0, 0 },
                    },
                    "HS11", Package() // AURA LED Controller
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 11, 0, 0, 0 },
                    },
                    "HS12", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 12, 0, 0, 0 },
                    },
                    "HS13", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 13, 0, 0, 0 },
                    },
                    */
                    "HS14", Package() // Bluetooth USB Host Controller
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 14, 0, 0, 0 },
                    },
                    "SS01", Package() // Rear I/O upper right (USB 3.1 Gen2 Type A)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 17, 0, 0, 0 },
                    },
                    "SS02", Package() // Rear I/O lower right (USB 3.1 Gen2 Type A)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 18, 0, 0, 0 },
                    },
                    "SS03", Package() // Rear I/O upper middle (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 19, 0, 0, 0 },
                    },
                    "SS04", Package() // Rear I/O lower middle (USB 3.1 Gen2 Type C)
                    {
                        "UsbConnector", 9,
                        "port", Buffer() { 20, 0, 0, 0 },
                    },
                    /*
                    "SS05", Package() // Internal->lower front panel (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 21, 0, 0, 0 },
                    },
                    */
                    "SS06", Package() // Internal->upper front panel (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 22, 0, 0, 0 },
                    },
                    "SS07", Package() // Rear I/O upper left (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 23, 0, 0, 0 },
                    },
                    "SS08", Package() // Rear I/O lower left (USB 3.1 Gen1)
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 24, 0, 0, 0 },
                    },
                    /*
                    "SS09", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 25, 0, 0, 0 },
                    },
                    "SS10", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 26, 0, 0, 0 },
                    },
                    "USR1", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 15, 0, 0, 0 },
                    },
                    "USR2", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 16, 0, 0, 0 },
                    },
                    */
                },
            },
        })
    }
}
//EOF
