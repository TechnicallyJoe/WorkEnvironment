Write-Verbose 'Loading tasks'
foreach ($item in (Get-ChildItem -Filter 'task.ps1' -recurse))
{
    Write-Verbose "Found task at: $($item.FullName)"
    try 
    {
        . $item.FullName
    }
    catch 
    {
        Write-Error -Message "Error on task: $($item.FullName)"
        $Error[0]
    }
}