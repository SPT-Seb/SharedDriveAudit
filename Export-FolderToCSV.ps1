<#
.SYNOPSIS
    In case of Shared drive to SharePoint migration, export all usefull information about all files in specified folder into a CSV file.
.DESCRIPTION
    Export Name, Path, Extension, Size (byte), Creation time, Last modification time, last access time in an UTF8 ';' delimited CSV file.
.NOTES
    File Name      : Export-FolderToCSV.ps1
    Author         : Sébastien Paulet (SPT Conseil)
    Prerequisite   : PowerShell V2 
.PARAMETER SourceFolder
    Full path to the folder to export
.PARAMETER TargetCSVBaseName
    Prefix to use in created CSV Name
.PARAMETER TargetCSVFolder
    Folder where to create CSV file (by default, current folder)

.EXAMPLE
    .\Export-FolderToCSV.ps1 . "MyCurrentFolderExport"
.EXAMPLE
    .\Export-FolderToCSV.ps1 G:\ "Export-GDrive"
.EXAMPLE
    .\Export-FolderToCSV.ps1 "\\my_server_unc\sub_folder\" "Export-UNCPathDrive"

#>
param(
    [Parameter(Mandatory = $true)]
    [String]$SourceFolder,
    [Parameter(Mandatory = $true)]
    [String]$TargetCSVBaseName,
    [String]$TargetCSVFolder = '.'
)
    $targetCSVFullName = Join-Path $TargetCSVFolder "$TargetCSVBaseName$([DateTime]::Now.ToString("yyyyMMddHHmmss")).csv"
    Get-ChildItem -Path $SourceFolder -Recurse | where {! $_.PSIsContainer}| Select-Object -Property Directory, Name, Extension, Length, CreationTime, LastWriteTime, LastAccessTime | Export-CSV -noTypeInformation -delimiter ';' -path $targetCSVFullName -Encoding UTF8