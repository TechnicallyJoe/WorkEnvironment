function Confirm-Chocolatey
{
    [CmdletBinding()]
    param
    (
        # choco executable - Don't change this unless you know what you are doing.
        [Parameter()]
        [string] $ChocolateyExecuteable = 'choco'
    )

    $chocoOutput = (Get-Command -Name $ChocolateyExecuteable -TotalCount 1 -ErrorAction SilentlyContinue)

    If ($chocoOutput)
    {
        Write-Verbose "Chocolatey Version: $($chocoOutput.Version)"
        $true
    }
    else
    {
        Write-Warning 'Chocolatey is not installed!`nPlease install chocolatey first.'
        $false
    }
}