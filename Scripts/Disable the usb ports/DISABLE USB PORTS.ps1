#
# Script.ps1
#

$usbDevices = Get-PnpDevice | Where-Object {$_.Class -eq 'USB' -and $_.Status -eq 'OK'}

foreach ($device in $usbDevices) { Disable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false}

<# TO UNDO OR RENABLED THE DISABLED CLASS: 

$usbDevices = Get-PnpDevice | Where-Object {$_.ClassGuid -eq 'USB' -and $_.Status -eq 'Disabled'}

foreach ($device in $usbDevices) { Enable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false}



# TYPES OF CLASSES:
# USB
# KEYBOARD
# PRINTER
# BLUETOOTH
# KEYBOARD
# MOUSE
# SOUND
# NET
# DISPLAY
# DISKDRIVE
# SYSTEM
# MEDIA


#>
