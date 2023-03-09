# force this script to run with administrator privileges
# if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `".\autoCevio.ps1`"" -Verb RunAs; exit }
# Write-Host "Hello World!!"
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')){
    Start-Process -FilePath PowerShell.exe -ArgumentList "-NoLogo -ExecutionPolicy Bypass -File $($MyInvocation.MyCommand.Path)" -Verb RunAs
    Exit
}



# change window
add-type -assembly microsoft.visualbasic
[microsoft.visualbasic.interaction]::AppActivate("CeVIO AI")
# [microsoft.visualbasic.interaction]::AppActivate("CLIP STUDIO PAINT")

[int] $startX = 482
[int] $startY = 650
[int] $endX = 1276
[int] $endY = 1015
[int] $maxBar = 2
[int] $barWidth = 96 # 80 / 128 ?
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
[int] $interval = 300 # msec 
[int] $tempo = 120
[int] $times = 1

# disable mouse temporary
$Win32 = &{
$cscode = @"
[DllImport("User32.dll")]
public static extern bool BlockInput(
bool fBlockIt
);
"@
return (add-type -memberDefinition $cscode -name "Win32ApiFunctions" -passthru)
}
$Win32::BlockInput($TRUE)
# Write-Host "disable mouse"

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
# [System.Windows.Forms.SendKeys]::SendWait("%{TAB}")
# Start-Sleep -m 3
# [System.Windows.Forms.SendKeys]::SendWait("%{TAB}")
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
    [int] $distance = 35 # 95-96/43 (SynthV.note.length)
    # [int] $ste = $w - $ets
    [int] $next = $x + $w
    $SendMouseEvent::mouse_event($MouseLeftDown, 0, 0, 0, 0);
    Start-Sleep -m $interval
    # [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($end, $y)
    $SendMouseEvent::mouse_event($MouseMove, $distance, 0, 0, 0)
    Start-Sleep -m $interval
    $SendMouseEvent::mouse_event($MouseLeftUp, 0, 0, 0, 0);
    Start-Sleep -m $interval
    $SendMouseEvent::mouse_event($MouseMove, -15, 0, 0, 0)
    Start-Sleep -m $interval
    $SendMouseEvent::mouse_event($MouseLeftDown, 0, 0, 0, 0);
    $SendMouseEvent::mouse_event($MouseLeftUp, 0, 0, 0, 0);
    $SendMouseEvent::mouse_event($MouseLeftDown, 0, 0, 0, 0);
    $SendMouseEvent::mouse_event($MouseLeftUp, 0, 0, 0, 0);
    [System.Windows.Forms.SendKeys]::SendWait("ki")
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    Start-Sleep -m $interval
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($next, $y)
    # $SendMouseEvent::mouse_event($MouseMove, 10, 14, 0, 0) # 16/10
    Start-Sleep -m $interval
    
    [int[]] $tempArray = @($w, $distance)
    varDump $tempArray
}

$notesObject = New-Object CevioNote
$notesObject.init($startX, $startY, $barWidth/16, 'i')
# $notesObject.writeNote($startX, $startY, $barWidth/16, 'i')

[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($startX, $startY)
Start-Sleep -m $interval

writeNote $startX $startY $barWidth $endToStart
writeNote ($startX+$barWidth) ($startY+24) $barWidth $endToStart
writeNote ($startX+$barWidth+$barWidth) $startY $barWidth $endToStart
writeNote ($startX+$barWidth+$barWidth+$barWidth) ($startY-24) $barWidth $endToStart
writeNote ($startX+$barWidth+$barWidth+$barWidth+$barWidth) $startY $barWidth $endToStart
writeNote ($startX+$barWidth+$barWidth+$barWidth+$barWidth+$barWidth) ($startY+24) $barWidth $endToStart
writeNote ($startX+$barWidth+$barWidth+$barWidth+$barWidth+$barWidth+$barWidth) $startY $barWidth $endToStart


$Win32::BlockInput($FALSE)
Write-Output "enabled mouse"

# 230305 NOTE
# It is too difficult to calculate the distance of the mouse moving.
# Especially short notes.
# I guess that need an array has adjustment values of each note length.
# I will try to change the width scale from 8 bars to 4 bars and add the moving page function.