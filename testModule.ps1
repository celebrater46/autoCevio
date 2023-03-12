$currentNoteHeight = 0

# the higher number, the higher probability
[int[]] $upperLowerRatio = @(1, 1)

# array[0] is base note
[int[]] $upperNotesWeightRatio = @(6, 3, 2, 1, 1, 1, 1, 1)

# the lower number, the lower probability
[int[]] $lowerNotesWeightRatio = @(6, 3, 2, 1, 1, 1, 1, 1)

[int[]] $noteNumsY = & "$($PSScriptRoot)\getNoteNumsY.ps1" $upperLowerRatio $upperNotesWeightRatio $lowerNotesWeightRatio

Write-Host "noteNumsY"
Write-Host $noteNumsY
# function getNextNum(){
#     if($isUp){
#         return & "$($PSScriptRoot)\getNoteNumsY.ps1" $upperNotesWeightRatio
#     } else {
#         return & "$($PSScriptRoot)\getNoteNumsY.ps1" $lowerNotesWeightRatio
#     }
# }

# # [int] $currentNotesNumY = [math]::Round(($upperNotesWeightRatio.Length + $lowerNotesWeightRatio.Length) / 2)
# [int] $currentNotesNumY = 8
# # Write-Host "currentNotesNumY: "
# # Write-Host $currentNotesNumY

# for($i = 0; $i -lt 7; $i++){
#     [bool] $isUp = & "$($PSScriptRoot)\upOrDown.ps1" $upperLowerRatio
#     # Write-Host "isUp: "
#     # Write-Host $isUp
#     [int] $nextNotesNum = getNextNum
#     # Write-Host "nextNotesNum: "
#     # Write-Host $nextNotesNum
#     if($isUp){
#         $currentNotesNumY += $nextNotesNum
#         $maxNum = $upperNotesWeightRatio.Length + $lowerNotesWeightRatio.Length - 1
#         if($currentNotesNumY -gt $maxNum){
#             $currentNotesNumY = $maxNum
#         }
#     } else {
#         $currentNotesNumY -= $nextNotesNum
#         if($currentNotesNumY -lt 1){
#             $currentNotesNumY = 1
#         }
#     }
#     Write-Host "currentNotesNumY: "
#     Write-Host $currentNotesNumY
# }

