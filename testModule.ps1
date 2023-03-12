# the higher number, the higher probability
[int[]] $upperLowerRatio = @(1, 1)

# array[0] is base note
[int[]] $upperNotesWeightRatio = @(6, 3, 2, 1, 1, 1, 1, 1)

# the lower number, the lower probability
[int[]] $lowerNotesWeightRatio = @(6, 3, 2, 1, 1, 1, 1, 1)

[int] $isUp = & "$($PSScriptRoot)\upOrDown.ps1" $upperLowerRatio

[int] $nextNotesNum
if($isUp){
    $nextNotesNum = & "$($PSScriptRoot)\getNextNote.ps1" $upperNotesWeightRatio
} else {
    $nextNotesNum = & "$($PSScriptRoot)\getNextNote.ps1" $lowerNotesWeightRatio
}

Write-Host "nextNotesNum: "
Write-Host $nextNotesNum