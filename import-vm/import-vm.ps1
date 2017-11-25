Get-Module -ListAvailable PowerCLI* | Import-Module

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -confirm:$false -DisplayDeprecationWarnings:$false

Connect-VIServer -Server $env:VCENTER_HOST -User $env:VCENTER_USER -Password $env:VCENTER_PASSWORD
