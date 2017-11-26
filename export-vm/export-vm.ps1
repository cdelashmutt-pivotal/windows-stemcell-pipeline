try
{
	Get-Module -ListAvailable PowerCLI* | Import-Module

	Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -confirm:$false -DisplayDeprecationWarnings:$false

	Connect-VIServer -Server $env:VCENTER_HOST -User $env:VCENTER_USER -Password $env:VCENTER_PASSWORD

	$version = cat base-vm/version
	$vm = Get-VM -Name "windows-stemcell-$version"

	Export-vApp -Destination "stemcell" -VM $vm -Format Ova -ErrorAction Stop
}
catch
{
	Write-Error $_
	exit 1
}
