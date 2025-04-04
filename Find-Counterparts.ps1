param (
    [string]$ArgListFile
)

Add-Type -AssemblyName System.Windows.Forms

# Read and sanitize the list of files (UTF-8 to support special characters)
$Files = Get-Content -Path $ArgListFile -Encoding UTF8 |
    ForEach-Object { $_.Trim('"').Trim() } |
    Where-Object { $_ -and (Test-Path $_) }

"Files to process:`n$($Files -join "`n")`n"

# Ask once for the folder containing counterparts
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select the folder containing counterpart files (e.g., JPGs)"
if ($folderBrowser.ShowDialog() -ne "OK") {
    "No folder selected. Exiting."
    exit
}
$targetFolder = $folderBrowser.SelectedPath
"Target folder: $targetFolder"

# Allow multiple extensions (case-insensitive)
$targetExts = @(".jpg", ".jpeg")

$copiedCount = 0

foreach ($file in $Files) {
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($file)
    $sourceFolder = Split-Path $file
    $found = $false

    "Checking: $file => base name: $baseName"

    foreach ($ext in $targetExts) {
        # Search both lowercase and uppercase extensions
        $possibleMatches = Get-ChildItem -Path $targetFolder -Filter "$baseName*$ext" -File -Recurse | Where-Object {
            $_.Extension -ieq $ext
        }

        foreach ($match in $possibleMatches) {
            $destinationPath = Join-Path $sourceFolder ($match.Name)
            Copy-Item -Path $match.FullName -Destination $destinationPath -Force
            $copiedCount++
            $found = $true
            "Copied to: $destinationPath"
            break
        }

        if ($found) { break }
    }

    if (-not $found) {
        "No match found for: $baseName"
    }
}

[System.Windows.Forms.MessageBox]::Show("Copied $copiedCount counterpart(s).", "Finished", "OK", "Information")
