[int[]] $notesWeightRatio = $Args[0]

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

[int] $nextNotesNum = selectNextNote $upperNotesWeightRatio
return $nextNotesNum

# $sumnum

# if(toUpper){
#     $sumNum = calcSum $upperNotesWeightRatio
# } else {
#     $sumNum = calcSum $lowerNotesWeightRatio
# }
# write-host $sumNum