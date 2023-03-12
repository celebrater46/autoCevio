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
    for($k = 0; $k -lt $tempArr.length; $k++){
        if($random -le $tempArr[$k]){
            return $k
        }
    }
}

function selectNextNote($arr){
    $tempArr = getTempArr $arr
    $nth = getNextNotesNum $arr $tempArr
    return $nth
}

function getNoteNumsY(){  
    [int] $currentNotesNumY = 8
    [int[]] $tempArr = @($currentNotesNumY)
    for($i = 0; $i -lt 7; $i++){
        [bool] $isUp = & "$($PSScriptRoot)\upOrDown.ps1" $upperLowerRatio
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

[int[]] $arrNotesNumsY = getNoteNumsY
return $arrNotesNumsY
