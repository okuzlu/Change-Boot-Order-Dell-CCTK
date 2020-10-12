
# Change this
$firstBoot = "Windows"
$secondBoot = "IPV4"
$Password = ""
$cctk = "C:\Program Files (x86)\Dell\Command Configure\X86_64\cctk.exe"

# Check cctk is installed
if ((Test-Path $cctk) -eq $false) {
    Write-Error "Can not find Command Configure Path cctk.exe: $_"
    exit 1
}

# Output current Boot Sequence
try {
    cmd.exe /c $cctk bootorder --bootlisttype=uefi > C:\uefi.txt
}
catch {
    Write-Error "Something went wrong: $_ "
}



# If firstboot 
if ($firstBoot.Length -gt 2) {
    foreach ($line in (Get-Content -Path "C:\uefi.txt")) {
        if ($line -match "$firstBoot") {
            # Regex hdd, uefi, cdrom, USB Hard Drive, USB Device, Embedded NIC (Case Sensitive)
            $boot1 = $line.Split(" ") -cmatch "dd|uefi|cdrom|hsbhdd|usbdev|embnicipv4|embnicipv6|embnic"
            $boot1
            if ($Password) {
                Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1 --EnableDevice=$boot1 --ValSetupPwd=$Password" -NoNewWindows
            }
            else {
                Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1 --EnableDevice=$boot1" -NoNewWindow
            } 
        }
        
        # If secondBoot 
        if ($secondBoot.Length -gt 2) {
            if ($line -match "$secondBoot") {
                $boot2 = $line.Split(" ") -cmatch "dd|uefi|cdrom|hsbhdd|usbdev|embnicipv4|embnicipv6|embnic"
                $boot2
                if ($Password) {
                    Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1,$boot2 --EnableDevice=$boot1,$boot2 --ValSetupPwd=$Password" -NoNewWindow
                }
                else {
                    Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1,$boot2 --EnableDevice=$boot1,$boot2" -NoNewWindow
                }
            }
        }
    }
}

# Delete uefi.txt File
Remove-Item C:\uefi.txt -ErrorAction SilentlyContinue