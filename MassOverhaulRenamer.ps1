# Get the directory path from the user
$dirPath = Read-Host "Enter the directory path"

# Get the desired prefix string from the user
$prefix = Read-Host "Enter the desired prefix string"

# Get the desired number of digits for the numbering from the user
$numDigits = Read-Host "Enter the desired number of digits for the numbering (1-9)"

# Validate the number of digits input
if ($numDigits -lt 1 -or $numDigits -gt 9) {
    Write-Host "Invalid number of digits. Please enter a value between 1 and 9."
    return
}

# Get the files in the directory
$files = Get-ChildItem -Path $dirPath -File

# Initialize the counter
$counter = 1

# Print the original and new file names before renaming
Write-Host "Original File Name -> New File Name"
foreach ($file in $files) {
    $extension = [System.IO.Path]::GetExtension($file.Name)
    $newFileName = "{0}{1:D$numDigits}{2}" -f $prefix, $counter, $extension
    Write-Host "$($file.Name) -> $newFileName"
    $counter++
}

# Prompt the user to confirm the renaming
$confirm = Read-Host "Do you want to proceed with renaming the files? (y/n)"

if ($confirm.ToLower() -eq 'y') {
    # Reset the counter
    $counter = 1

    foreach ($file in $files) {
        $extension = [System.IO.Path]::GetExtension($file.Name)
        $newFileName = "{0}{1:D$numDigits}{2}" -f $prefix, $counter, $extension
        $newFilePath = Join-Path $dirPath $newFileName

        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newFileName

        $counter++
    }

    Write-Host "Files renamed successfully."
} else {
    Write-Host "File renaming canceled."
}