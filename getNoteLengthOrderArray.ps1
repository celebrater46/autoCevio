# [int[]] $noteTypes = @(2, 4, 8, 16)
# [int[]] $noteTypesWeightRatio = @(2, 4, 6, 2)
[int[]] $notesLengthArray = @(2, 4, 8, 16)
[int[]] $notesLengthWeightRatio = @(2, 4, 6, 2)
[int] $notes = 7
# [int[]] $notesLengthArr = $args[0]
# [int[]] $notesLengthWeightRatio = $args[1]
# [int] $notes = $args[2] # 7

# function getSum(){
#     [int] $sum = 0
#     foreach($num in $notesLengthWeightRatio){
#         $sum += $num
#     }
#     return $sum
# }

# function getNextLength($sum){
#     $random = Get-Random -Maximum $sum -Minimum 0

# }

function getNotesLengthOrderArray(){
    [int[]] $arr = @()
    for($i = 0; $i -lt $notes; $i++){
        $nextNth = & "$($PSScriptRoot)\getNextNoteNum.ps1" $notesLengthWeightRatio
        $arr += $notesLengthArray[$nextNth]
    }
    return $arr
}

[int[]] $notesLengthOrderArray = getNotesLengthOrderArray
return $notesLengthOrderArray
