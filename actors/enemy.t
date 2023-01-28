class Enemy
    import Direction
    export alive, description, detectCollision, dir, dirImages, goldGain, lvlClr, xpGain, hp, maxHp, move, talk, talkCounter, talkCounterGoal, text, xPos, yPos, xRad, yRad, dmgMin, dmgMax, combatLvl, archeryLvl, respawnCounter, totalLvl, newTalkCounterGoal, setHp, setAlive, setRespawnCounter, setMove, setDir, setXPos, setYPos, setTalk, setTalkCounter, setLvlClr
    var alive : boolean := true
    var description : string
    var dir : int := ord(Direction.DOWN)
    var dirImages : array 0 .. 3 of int
    var hp : int
    var maxHp : int
    var goldGain : int
    var xpGain : int
    var move : boolean := false
    var talk : boolean := true
    var text : array 0 .. 2 of string
    var xPos : int
    var yPos : int
    var xRad : int
    var yRad : int
    var dmgMin : int
    var dmgMax : int
    var combatLvl : int := 0
    var archeryLvl : int := 0
    var totalLvl : int := round ((combatLvl + archeryLvl) / 2)
    var lvlClr : int
    var respawnCounter : int := 0
    var talkCounter : int := 0
    var talkCounterGoal : int := Rand.Int(500,1000)
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
    procedure setLvlClr(playerLvl : int)
	if playerLvl > totalLvl then
	    lvlClr := brightgreen
	elsif playerLvl = totalLvl then
	    lvlClr := yellow
	elsif playerLvl < totalLvl then
	    lvlClr := brightred
	end if
    end setLvlClr
    procedure setTalkCounter(i : int)
        talkCounter := i
    end setTalkCounter
    procedure newTalkCounterGoal
        talkCounterGoal := Rand.Int(500, 1000)
    end newTalkCounterGoal
    deferred procedure detectCollision
end Enemy
