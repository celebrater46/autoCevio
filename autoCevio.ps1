[int] $startX = 226
[int] $startY = 394
[int] $endX = 1276
[int] $endY = 1015
[int] $maxBar = 8
[int] $barWidth = 128
[int] $noteHeight = 24
[int] $lines = 14 # 7 == 1 octave
# [int] $fullLines = 24 # 12 == 1 octave
[int[]] $linesArray = @(0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23)
[int[]] $chordsArray = @(0, 0, 7)
[int[]] $notesArray = @(2, 4, 8, 16) # 16 == 1/16, 8 == 1/8
[bool] $chordMode = $FALSE
# [int] $shortestNote = 16 
# [int] $longestNote = 2
# [int] $notes = $maxBar * $shortestNote
# [int] $xGap = ($endX-$startX)/$notes
# [int] $yGap = ($endY-$startY)/$fullLines
[int] $interval = 1 # msec 
[int] $tempo = 120
[int] $times = 1

class CevioNote{
    [int] $startX = 0
    [int] $startY = 0
    [int] $width = 33
    [string] $char = 'a'

    [string] init($x, $y, $w, $ch){
        $this.startX = $x
        $this.startY = $y
        $this.width = $w
        $this.char = $ch
        Write-Host $this.startX, $this.startY, $this.width, $this.char
        return ''
    }
}

$notesObject = New-Object CevioNote
$notesObject.init(3, 3, 35, 'i')
