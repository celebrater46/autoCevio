# [int[]] $notesWeightRatio = $Args[0]
[int[]] $upperLowerRatio = $Args[0]
[int[]] $upperNotesWeightRatio = $Args[1]
[int[]] $lowerNotesWeightRatio = $Args[2]

function calcSum($arr){
    [int] $sum = 0
    foreach($num in $arr){
        $sum += $num
    }
    return $sum
}

function getSumInArray($arr, $nth){
    $sum = 0;
    for($j = 0; $j -lt $nth; $j++){
        $sum += $arr[$j]
    }
    return $sum
}

function getTempArr($arr){
    $tempArr = @()
    for($i = 1; $i -le $arr.length; $i++){
        $num = getSumInArray $arr $i
        $tempArr += $num
    }
    return $tempArr
}

function getNextNotesNum($arr, $tempArr){
    $sum = calcSum $arr
    $random = Get-Random -Maximum $sum -Minimum 0
    # if($random -eq 0) {
    #     $random = 1
    # }
    for($k = 0; $k -lt $tempArr.length; $k++){
        if($random -le $tempArr[$k]){
            return $k
        }
        # return $tempArr.length
    }
}

function selectNextNote($arr){
    $tempArr = getTempArr $arr
    # write-host "TEMP-ARR: "
    # write-host $tempArr
    $nth = getNextNotesNum $arr $tempArr
    # write-host "NEXT-NOTE: "
    # write-host $nth
    return $nth
}

function getNoteNumsY(){  
    # [int] $currentNotesNumY = [math]::Round(($upperNotesWeightRatio.Length + $lowerNotesWeightRatio.Length) / 2)
    [int] $currentNotesNumY = 8
    # Write-Host "currentNotesNumY: "
    # Write-Host $currentNotesNumY
    [int[]] $tempArr = @($currentNotesNumY)
    for($i = 0; $i -lt 7; $i++){
        [bool] $isUp = & "$($PSScriptRoot)\upOrDown.ps1" $upperLowerRatio
        # $nextNotesNum
        # if($isUp){
        #     return & "$($PSScriptRoot)\getNoteNumsY.ps1" $upperNotesWeightRatio
        # } else {
        #     return & "$($PSScriptRoot)\getNoteNumsY.ps1" $lowerNotesWeightRatio
        # }
        # Write-Host "isUp: "
        # Write-Host $isUp
        # Write-Host "nextNotesNum: "
        # Write-Host $nextNotesNum
        if($isUp){
            [int] $nextNotesNum = selectNextNote $upperNotesWeightRatio
            $currentNotesNumY += $nextNotesNum
            $maxNum = $upperNotesWeightRatio.Length + $lowerNotesWeightRatio.Length - 1
            if($currentNotesNumY -gt $maxNum){
                $currentNotesNumY = $maxNum
            }
        } else {
            [int] $nextNotesNum = selectNextNote $lowerNotesWeightRatio
            $currentNotesNumY -= $nextNotesNum
            if($currentNotesNumY -lt 1){
                $currentNotesNumY = 1
            }
        }
        $tempArr += $currentNotesNumY
        Write-Host "currentNotesNumY: "
        Write-Host $currentNotesNumY
    }
    return $tempArr
}

# [int] $arrNextNotesNumsY = selectNextNote $upperNotesWeightRatio
[int[]] $arrNotesNumsY = getNoteNumsY
return $arrNotesNumsY

# $sumnum

# if(toUpper){
#     $sumNum = calcSum $upperNotesWeightRatio
# } else {
#     $sumNum = calcSum $lowerNotesWeightRatio
# }
# write-host $sumNum
