class Enemy
    import direction
    export alive, description, dir, dirImages, hp, move, talk, text, xPos, yPos, dmgMin, dmgMax, combatLvl, archeryLvl, respawnCounter, totalLvl, setHp, setAlive, setRespawnCounter, setMove, setDir, setXPos, setYPos, setTalk
    var alive : boolean := true
    var description : string
    var dir : int := ord(direction.DOWN)
    var dirImages : array 0 .. 3 of int
    var hp : int
    var move : boolean := false
    var talk : boolean := true
    var text : array 1 .. 3 of string
    var xPos : int
    var yPos : int
    var dmgMin : int
    var dmgMax : int
    var combatLvl : int := 0
    var archeryLvl : int := 0
    var totalLvl : int := round ((combatLvl + archeryLvl) / 2)
    var respawnCounter : int := 0
    procedure setHp (i : int)
	    hp := i
    end setHp
    procedure setAlive(b : boolean)
	    alive := b
    end setAlive
    procedure setRespawnCounter(i : int)
	    respawnCounter := i
    end setRespawnCounter
    procedure setMove(b : boolean)
	    move := b
    end setMove
    procedure setDir(i : int)
	    dir := i
    end setDir
    procedure setXPos(i : int)
	    xPos := i
    end setXPos
    procedure setYPos(i : int)
	    yPos := i
    end setYPos
    procedure setTalk(b : boolean)
	    talk := b
    end setTalk
end Enemy
