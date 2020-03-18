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

$profileParent = (Split-Path -Path $Profile -Parent)
$profileName = (Split-Path -Path $Profile -leaf)
$profileTemplateName = "profile.ps1"

if (-not(Test-Path -Path $profile)) 
{
    if (-not(Test-Path -Path $profileParent)) { New-Item -Path $profileParent -Type Directory }

    Copy-Item -Path "$srcPath\$profileTemplateName" -Destination $profileParent -Force
    Rename-Item -Path "$profileParent\$profileTemplateName" -NewName $profileName -Force
}
else
{
    Write-Warning -Message "Cannot replace profile. Profile already exists at: $profile"
}
