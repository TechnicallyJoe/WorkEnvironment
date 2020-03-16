[cmdletBinding()]

param
(
    # Packages YAML file path
    [Parameter()]
    [string] $PackagesPath = "$PSScriptRoot/entities.yml"
)

Write-Verbose 'loading dependencies'
foreach ($item in (Get-ChildItem -Path "$PSScriptRoot/src/" -Recurse -File))
{
    Write-Verbose "Loading: $($item.Name)"
    . $item.FullName
}

Write-Verbose "Confirming privileged mode is on."
if (-not(Confirm-Administrator)) { break; }

Write-Verbose 'Confirming Chocolatey Is installed.'
if (-not(Confirm-Chocolatey)) { Install-Chocolatey }

Write-Verbose "Loading modules"
if (-not(Get-Module -ListAvailable 'powershell-yaml'))
{
    Install-Module -Name 'powershell-yaml'
}
else
{
    Import-Module -Name 'powershell-yaml'
}

Write-Verbose "Loading Scripts"
$packages = Get-Content -Path $PackagesPath -Raw | ConvertFrom-Yaml
$packages.packages

foreach ($package in $packages.packages)
{
    choco upgrade -y $package
}

. $PSScriptRoot\src\powershellprofile\task.ps1