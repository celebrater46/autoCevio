[int] $x = $args[0]
[int] $y = $args[1]
[int] $width = $args[2]
[string] $char = $args[3]

class CevioNote{
    [int] $x = 960
    [int] $y = 540
    [int] $width = 96
    [string] $char = '‚ '

    CevioNote($x, $y, $width, $char){
        $this.x = $x
        $this.y = $y
        $this.width = $width
        $this.char = $char
        Write-Host $this.x, $this.y, $this.width, $this.char
    }
}

$cn = [CevioNote]::new($x, $y, $width, $char)
return $cn
