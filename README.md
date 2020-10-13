# Change Boot Order Dell CCTK
 
PowerShell Script that changes the Bootorder on Dell Machines.

Edit the values under "Change this".
You can set these devices: 
hdd, uefi, cdrom, USB Hard Drive, USB Device, Embedded NIC

Example: 

1st Boot: Windows

2nd Boot: IPV4

$firstBoot = "Windows"

$secondBoot = "IPV4"

If you only want to set first Boot Device: Leave $secondBoot empty

If you have set a Bios password assign it to the variable $Password

Tested with Dell Command Configure Version 4.1.0.478


# Change Dell Boot Order 

PowerShell Script that can change the Bootorder and disable Bootdevices.

## Installation

Dell Command Configure is required to use this Script.

## Usage

```powershell

Edit the values under Change this:

Example: Set Windows Boot Manager on first Boot and IPV4 and second Boot. Bios password is set.

$firstBoot = "Windows",
$secondBoot = "IPV4",
$Password = "changeme",
$disableDevice = ""

Or you can run this Script with arguments:

.\change_bot.ps1 -firstBoot Windows -secondBoot IPV4 -Password changeme

If you dont need a second Boot leave it empty.
To disable a device in the Bootlist change the value for $disableDevice.
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
