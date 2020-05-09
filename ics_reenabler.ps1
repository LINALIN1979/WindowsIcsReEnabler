#
# Windows ICS (Internet Connection Sharing) doesn't work after system reboot.
# The workaround solution is to re-enable ICS after reboot.
#
# Ref: https://superuser.com/questions/470319/how-to-enable-internet-connection-sharing-using-command-line
#


# Custom setup
$publicInterface  = "Remote NDIS based Internet Sharing Device"
$privateInterface = "Intel(R) Ethernet Connection (6) I219-V"


# Create a NetSharingManager object
$m = New-Object -ComObject HNetCfg.HNetShare

$public = $m.EnumEveryConnection |? { $m.NetConnectionProps.Invoke($_).DeviceName -eq "$publicInterface" }
$configPublic = $m.INetSharingConfigurationForINetConnection.Invoke($public)

$private = $m.EnumEveryConnection |? { $m.NetConnectionProps.Invoke($_).DeviceName -eq "$privateInterface" }
$configPrivate = $m.INetSharingConfigurationForINetConnection.Invoke($private)

Write-Output "Before:"
Write-Output "  Public : [$($publicInterface)] sharing $($configPublic.SharingEnabled), role $($configPublic.SharingConnectionType)"
Write-Output "  Private: [$($privateInterface)] sharing $($configPrivate.SharingEnabled), role $($configPrivate.SharingConnectionType)"
Write-Output "  (Role has meaning when sharing = True; 0 - publice, 1 - private)"

# Disable sharing first
if ($configPrivate.SharingEnabled) {
    $configPrivate.DisableSharing()
}
if ($configPublic.SharingEnabled) {
    $configPublic.DisableSharing()
}

# Enable sharing
$configPublic.EnableSharing(0)
$configPrivate.EnableSharing(1)

Write-Output "After:"
Write-Output "  Public : [$($publicInterface)] sharing $($configPublic.SharingEnabled), role $($configPublic.SharingConnectionType)"
Write-Output "  Private: [$($privateInterface)] sharing $($configPrivate.SharingEnabled), role $($configPrivate.SharingConnectionType)"
Write-Output "  (Role has meaning when sharing = True; 0 - publice, 1 - private)"
