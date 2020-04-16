$modules = @(
    "posh-git",
    "posh-docker"
    "oh-my-posh"
)

foreach ($module in $modules)
{
    if (-not(Get-Module -ListAvailable -Name $module))
    {
        Install-Module -Name $module -Force -Scope CurrentUser
    }

    Import-module -Name $module
}

# Custom Aliases
New-Alias -Name 'dig' -Value 'Resolve-DnsName'
New-Alias -Name 'rdp' -Value 'Start-RemoteDesktop'

# Console Config
Set-Theme Agnoster
Set-location -Path "$($ENV:USERPROFILE)\git"

Set-PSReadlineKeyHandler -Key Tab -Function Complete

# Custom Global Variables
$Hosts = "$($Env:WinDir)\system32\Drivers\etc\hosts"

# Custom Functions
function Start-RemoteDesktop
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$computername
    )
    mstsc /v:$computername
}

function Add-ToHosts
{
    [CmdletBinding()]
    param (
        # The associated IP
        [Parameter(Mandatory, Position = 0)]
        [string] $IP,

        # The associated Hostname / Domain name / FQDN
        [Parameter(Mandatory, Position = 1)]
        [string] $HostName,

        # Hosts file location
        [Parameter()]
        [ValidateScript({Test-Path $_ })]
        [string] $FilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"
    )

    $content = (Get-Content -Path $FilePath -Raw).TrimEnd()
    $content += "$([Environment]::NewLine)$IP `t $HostName"
    Write-Verbose -Message $content
    Set-Content -Encoding UTF8 -Path $FilePath -Value $content
    "Added $IP `t $HostName to $FilePath"
}
