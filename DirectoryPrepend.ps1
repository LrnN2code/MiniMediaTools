# Function to get user input for directory path

function Get-DirectoryPath {

    [CmdletBinding()]

    param()



    $initialDirectory = $PWD.Path

    $directoryPath = Read-Host "Enter the directory path (or leave blank for the current directory)"



    if ([string]::IsNullOrWhiteSpace($directoryPath)) {

        $directoryPath = $initialDirectory

    }

    elseif (-not (Test-Path -Path $directoryPath -PathType Container)) {

        Write-Warning "The specified directory path does not exist."

        return $null

    }



    return $directoryPath

}



# Function to get user input for the string to prepend

function Get-PrependString {

    [CmdletBinding()]

    param()



    $prependString = Read-Host "Enter the string to prepend to file names"

    return $prependString

}



# Main script

$directoryPath = Get-DirectoryPath

if ($null -eq $directoryPath) {

    Write-Warning "No valid directory path provided. Exiting script."

    return

}



$prependString = Get-PrependString



$files = Get-ChildItem -Path $directoryPath -File



foreach ($file in $files) {

    $oldName = $file.Name

    $newName = "{0}{1}" -f $prependString, $oldName

    $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName



    Rename-Item -Path $file.FullName -NewName $newName

}



Write-Host "File renaming completed successfully."