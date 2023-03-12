class CevioNote{
    [int] $x = 960
    [int] $y = 540
    [int] $width = 96
    [string] $char = '‚ '

    init(){
        $this.x = $args[0]
        $this.y = $args[1]
        $this.width = $args[2]
        $this.char = $args[3]
        Write-Host $this.x, $this.y, $this.width, $this.char
    }
}

$cn = [CevioNote]::new()
return $cn
