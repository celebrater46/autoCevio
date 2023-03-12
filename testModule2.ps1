[int[]] $noteTypes = @(2, 4, 8, 16)
[int[]] $noteTypesWeightRatio = @(2, 4, 6, 2)

[int[]] $noteLengthArray = & "$($PSScriptRoot)\getNoteLengthOrderArray.ps1" $noteTypes $noteTypesWeightRatio 7
Write-Host "noteLengthArray"
Write-Host $noteLengthArray