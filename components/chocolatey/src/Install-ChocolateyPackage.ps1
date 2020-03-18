function Install-ChocolateyPackage
{
    [CmdletBinding()]
    param (
        # Chocolatey package to install / update
        [Parameter(Mandatory)]
        [string] $Package
    )

    choco upgrade -y $Package
}