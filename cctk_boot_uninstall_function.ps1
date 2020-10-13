Param(
    $firstBoot,
    $secondBoot,
    $Password,
    $disableDevice

)


function changeBootOrder {
    param (
        # First Boot Device, Mandatory
        [Parameter(Mandatory=$true)]
        [String]
        [AllowEmptyString()]
        $firstBoot,
        # Second Boot Device 
        [Parameter()]
        [String]
        [AllowEmptyString()]
        $secondBoot,
        # If Password is set
        [Parameter()]
        [String]
        [AllowEmptyString()]
        $Password
    )

    $cctk = "C:\Program Files (x86)\Dell\Command Configure\X86_64\cctk.exe"

    # Check cctk is installed
    if ((Test-Path $cctk) -eq $false) {
        Write-Error "Can not find Command Configure Path cctk.exe: $_"
        exit 1
    }

    # Output current Boot Sequence
    try {
        cmd.exe /c "C:\Program Files (x86)\Dell\Command Configure\X86_64\cctk.exe" bootorder --bootlisttype=uefi > C:\uefi.txt
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
                    Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1 --EnableDevice=$boot1 --ValSetupPwd=$Password"
                }
                else {
                    Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1 --EnableDevice=$boot1"
                } 
            }
            
            # If secondBoot 
            if ($secondBoot.Length -gt 2) {
                if ($line -match "$secondBoot") {
                    $boot2 = $line.Split(" ") -cmatch "dd|uefi|cdrom|hsbhdd|usbdev|embnicipv4|embnicipv6|embnic"
                    $boot2
                    if ($Password) {
                        Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1,$boot2 --EnableDevice=$boot1,$boot2 --ValSetupPwd=$Password"
                    }
                    else {
                        Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1,$boot2 --EnableDevice=$boot1,$boot2"
                    }
                }
            }
        }
    }

    # Delete uefi.txt File
    Remove-Item C:\uefi.txt -ErrorAction SilentlyContinue
}

changeBootOrder -firstBoot $firstBoot -secondBoot $secondBoot -Password $Password

function disableBootDevice {
    param (
        # Device
        [Parameter(Mandatory=$true)]
        [String]
        $firstDevice,
        # Password
        [Parameter()]
        [String]
        $Password
    )
    
    # CCTK Path
    $cctk = "C:\Program Files (x86)\Dell\Command Configure\X86_64\cctk.exe"

    # Check cctk is installed
    if ((Test-Path $cctk) -eq $false) {
        Write-Error "Can not find Command Configure Path cctk.exe: $_"
        exit 1
    }

    # Output current Boot Sequence
    try {
        cmd.exe /c "C:\Program Files (x86)\Dell\Command Configure\X86_64\cctk.exe" bootorder --bootlisttype=uefi > C:\uefi.txt
    }
    catch {
        Write-Error "Something went wrong: $_ "
    }

    # Disable Boot Device
    if ($firstDevice -gt 2) {
        foreach ($line in (Get-Content -Path "C:\uefi.txt")) {
            if ($line -match $firstDevice) {
                $boot1 = $line.Split(" ") -cmatch "dd|uefi|cdrom|hsbhdd|usbdev|embnicipv4|embnicipv6|embnic"
                $boot1
                if ($Password) {
                    Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1 --DisableDevice=$boot1 --ValSetupPwd=$Password"
                }
                else {
                    Start-Process -FilePath $cctk -ArgumentList "Bootorder --bootlisttype=uefi --sequence=$boot1 --DisableDevice=$boot1"
                } 
            }
        }
    }

    # Delete uefi.txt File
    Remove-Item C:\uefi.txt -ErrorAction SilentlyContinue
}

if ($disableDevice) {
    disableBootDevice -firstDevice $disableDevice -Password $Password
}