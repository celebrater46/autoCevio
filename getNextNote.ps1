[int[]] $upperNotesWeight = @(6, 3, 2, 1, 1, 1, 1, 1)
[int[]] $lowerNotesWeight = @(8, 3, 2, 1, 1, 1, 1, 1)

function toUpper(){
    $random = Get-Random -Maximum 10 -Minimum 1
    if($random -gt 5){
        write-host "UPPER: "
        return $TRUE
    } else {
        write-host "LOWER: "
        return $FALSE
    }
}

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

function selectNextNote($arr){
    $tempArr = getTempArr $arr
    write-host "TEMP-ARR: "
    write-host $tempArr
}

selectNextNote $upperNotesWeight

# $sumnum

# if(toUpper){
#     $sumNum = calcSum $upperNotesWeight
# } else {
#     $sumNum = calcSum $lowerNotesWeight
# }
# write-host $sumNum
