$modules = @(
    "posh-git",
    "posh-docker"
)

foreach ($module in $modules)
{
    if (-not(Get-Module -ListAvailable -Name $module))
    {
        Install-Module -Name $module -Force -Scope CurrentUser
    }

    Import-module -Name $module
}

#Custom Aliases
New-Alias -Name 'dig' -Value 'Resolve-DnsName'

#Console Config
Set-location -Path "$($ENV:USERPROFILE)\git"

Set-PSReadlineKeyHandler -Key Tab -Function Complete