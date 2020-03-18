[cmdletBinding()]
param
(
    # Packages YAML file path
    [Parameter()]
    [string] $PackagesPath = "$PSScriptRoot/entities.yml",

    # path to the src folder
    [Parameter()]
    [string] $srcPath = "$PSScriptRoot\src"
)

Write-Verbose 'loading dependencies'
foreach ($item in (Get-ChildItem -Path "$PSScriptRoot/src/" -Recurse -File))
{
    Write-Verbose "Loading: $($item.Name)"
    . $item.FullName
}