[int] $startX = 226
[int] $startY = 394
[int] $endX = 1276
[int] $endY = 1015
[int] $maxBar = 8
[int] $barWidth = 80 # 80 / 128 ?
[int] $noteHeight = 24
[int] $lines = 14 # 7 == 1 octave
# [int] $fullLines = 24 # 12 == 1 octave
[int[]] $linesArray = @(0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23)
[int[]] $chordsArray = @(0, 0, 7)
[int[]] $notesArray = @(2, 4, 8, 16) # 16 == 1/16, 8 == 1/8
[bool] $chordMode = $FALSE
[int] $endToStart = 3 # the distance from the click end point to start
# [int] $shortestNote = 16 
# [int] $longestNote = 2
# [int] $notes = $maxBar * $shortestNote
# [int] $xGap = ($endX-$startX)/$notes
# [int] $yGap = ($endY-$startY)/$fullLines
[int] $interval = 3 # msec 
[int] $tempo = 120
[int] $times = 1

# declare .NET Framework
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# declare Windows API
$signature=@'
[DllImport("user32.dll",CharSet=CharSet.Auto,CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
# $SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru
$SendMouseEvent = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru
$MouseMove = 0x00000001
$MouseLeftDown = 0x0002
$MouseLeftUp = 0x0004

# back to the previous window
# ALT + TAB (move to the previous window)
[System.Windows.Forms.SendKeys]::SendWait("%{TAB}")
Start-Sleep -m 3000

class CevioNote{
    [int] $startX = 0
    [int] $startY = 0
    [int] $width = 33
    [string] $char = 'a'

    init($x, $y, $w, $ch){
        $this.startX = $x
        $this.startY = $y
        $this.width = $w
        $this.char = $ch
        Write-Host $this.startX, $this.startY, $this.width, $this.char
    }

    # ste == start to end, ets == end to start
    # writeNote($ets, $ms, $SendMouseClick){
    #     [int] $ste = $this.width - $ets
    #     [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($this.startX, $this.startY)
    #     Start-Sleep -m $ms
    #     $SendMouseClick::mouse_event(0x0002, 0, 0, 0, 0);
    #     Start-Sleep -m $ms
    #     [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($this.startX + $ste, $this.startY)
    #     Start-Sleep -m $ms
    #     $SendMouseClick::mouse_event(0x0004, 0, 0, 0, 0);
    #     Start-Sleep -m $ms
    #     [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($this.startX + $this.width, $this.startY)
    #     Start-Sleep -m $ms
    # }
}

function varDump($array){
    foreach($item in $array){
        Write-Host $item
    }
}

function writeNote($x, $y, $w, $ets){
    [int] $end = $x + $ste
    [int] $ste = $w - $ets
    [int] $next = $x + $w
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
    Start-Sleep -m $interval
    $SendMouseEvent::mouse_event($MouseLeftDown, 0, 0, 0, 0);
    # Start-Sleep -m $interval
    # [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($end, $y)
    $SendMouseEvent::mouse_event($MouseMove, $w, 0, 0, 0)
    # Start-Sleep -m $interval
    $SendMouseEvent::mouse_event($MouseLeftUp, 0, 0, 0, 0);
    Start-Sleep -m $interval
    # [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($next, $y)
    # Start-Sleep -m $interval
    
    [int[]] $tempArray = @($end, $ste, $next)
    varDump $tempArray
}

$notesObject = New-Object CevioNote
$notesObject.init($startX, $startY, $barWidth/16, 'i')
# $notesObject.writeNote($startX, $startY, $barWidth/16, 'i')
writeNote $startX $startY $barWidth $endToStart