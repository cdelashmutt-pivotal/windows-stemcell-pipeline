try
{
	Get-Module -ListAvailable PowerCLI* | Import-Module

	Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -confirm:$false -DisplayDeprecationWarnings:$false

	Connect-VIServer -Server $env:VCENTER_HOST -User $env:VCENTER_USER -Password $env:VCENTER_PASSWORD

	$cluster = Get-Cluster -Name "Cluster"
	$firstHost = Get-VMHost -Location $cluster | select -first 1
	$version = cat base-vm/version
	$ova = dir base-vm/*$version.ova | %{$_.Name}

	Import-vApp -Source "base-vm/$ova" -VMHost $firstHost -Location $cluster -Name "windows-stemcell-$version" -ErrorAction Stop
}
catch
{
	Write-Error $_
	exit 1
}
