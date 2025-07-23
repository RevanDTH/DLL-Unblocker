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

## Main

$directory_Path = Read-Host "Path of the Directory: "
Clear-Host
$recursive = Read-Host read_choice("Affect subfolders to?")
Clear-Host

Test-Path $directory_Path