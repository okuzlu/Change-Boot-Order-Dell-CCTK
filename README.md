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
