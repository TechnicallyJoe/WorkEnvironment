function Install-Chocolatey
{
    [CmdletBinding()]
    param ()

    if (-not(Confirm-Administrator))
    {
        break;
    }

    Write-Verbose 'Installing Chocolatey'
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    Write-Verbose 'Refreshing environment variables'
    refreshenv

}