class Peasant
    inherit Actor
    export inCottage, setInCottage

    name := "peasant"

    description := "A humble peasant."

    dirImages (ord(Direction.UP)) := Pic.FileNew ("Images/peasantu.bmp")
    dirImages (ord(Direction.DOWN)) := Pic.FileNew ("Images/peasantd.bmp")
    dirImages (ord(Direction.LEFT)) := Pic.FileNew ("Images/peasantl.bmp")
    dirImages (ord(Direction.RIGHT)) := Pic.FileNew ("Images/peasantr.bmp")

    text (0) := "Peasant: *sigh*"
    text (1) := "Peasant: Nice day ain't it?"
    text (2) := "Peasant: ...might do some fishin' t'day..."

    xPos := 600
    yPos := 100

    xRad := 10
    yRad := 15

    var inCottage : boolean := false
    hp := 70
    maxHp := 70
    xpGain := 70
    goldGain := 100
    combatLvl := 7
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 7
    totalLvl := round ((combatLvl + archeryLvl) / 2)

    proc setInCottage(b : boolean)
        inCottage := b
    end setInCottage

    body procedure detectCollision
    end detectCollision
end Peasant
