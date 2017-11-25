Get-Module -ListAvailable PowerCLI* | Import-Module

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -confirm:$false -DisplayDeprecationWarnings:$false

Connect-VIServer -Server $env:VCENTER_HOST -User $env:VCENTER_USER -Password $env:VCENTER_PASSWORD

$cluster = Get-Cluster -Name "Cluster"
$firstHost = Get-VMHost -Location $cluster | select -first 1
$version = cat base-vm/version
$ova = dir base-vm/*.ova | %{$_.Name}

Import-vApp -Source $ova -VMHost $firstHost -Location $cluster -Name "windows-stemcell-$version"
