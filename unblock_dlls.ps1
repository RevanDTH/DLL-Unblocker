## Functions
function read_choice($question) {
    
    $response = $null

    while ($response.ToLower() -ne "y" -or $response.ToLower() -ne "n") {
    
        $response = Read-Host "$question (Y/N) "

        switch ($response.ToLower()) {
            "y"{return $True}

            "n"{return $False}
        }
    }
}

function UI() {
    $userInput = $null

    while ($userInput -ne 1 -and $userInput -ne 2) {
        Clear-Host
        Write-Host @'
        (1) Unblock DLL files
        (2) Exit
'@
        $userInput = Read-Host " "
    }

    if($userInput -eq 1){
        return $true
    }elseif ($userInput -eq 2) {
        return $false
    }
}

## Main

$choice = UI

while($choice){

    Clear-Host
    $directory_Path = Read-Host "Path of the Directory "
    Clear-Host
    $recursive = read_choice("Affect subfolders to?")
    Clear-Host
    if($recursive){
        $DLLs = Get-ChildItem $directory_Path -Recurse -Filter *.dll -File
    }else{
        $DLLs = Get-ChildItem $directory_Path -Filter *.dll -File   
    }
    if(Test-Path $directory_Path){
        foreach($file in $DLLs){
            try {
                Write-Host "[INFO] Unblocking $file . . . `n"
                $adsPath = $file.FullName + ":Zone.Identifier"
                [System.IO.File]::Delete($adsPath)
            }
            catch {
                Write-Error "[ERROR] Something went Wrong . . ."
                Write-Warning "[INFO] Moving on to the next . . ."
                Write-Error $_
            }
        }
    }else{
        Write-Error "[ERROR] The Path doesn't exist, please check if the Path is correct . . ."
    }

    Write-Host "[INFO] All DLLs unblocked"
    Read-Host "Press ENTER to continue"

    $choice = UI
    if($choice -eq $false){exit}
}

