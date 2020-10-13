

# Change Dell Boot Order 

PowerShell Script that can change the Bootorder and disable Bootdevices.
Tested with Dell Command Configure Version 4.1.0.478

## Installation

Dell Command Configure is required to use this Script.

## Usage

```powershell

Edit the values under Change this:

Example: Set Windows Boot Manager on first Boot and IPV4 and second Boot. BIOS password is "changeme".

$firstBoot = "Windows",
$secondBoot = "IPV4",
$Password = "changeme",
$disableDevice = ""

Or you can run this Script with arguments:

.\change_boot.ps1 -firstBoot Windows -secondBoot IPV4 -Password changeme

If you dont need a second Boot leave it empty.
To disable a device in the Bootlist change the value for $disableDevice.
```

These devices will be recognized:
```hdd, uefi, cdrom, USB Hard Drive, USB Device, Embedded NIC```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
