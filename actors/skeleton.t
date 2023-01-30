class Skeleton
    inherit Actor

    name := "skeleton"

    description := "An undead skeleton...creepy!"

    dirImages (ord(Direction.UP)) := Pic.FileNew ("Images/skeletonu.bmp")
    dirImages (ord(Direction.DOWN)) := Pic.FileNew ("Images/skeletond.bmp")
    dirImages (ord(Direction.LEFT)) := Pic.FileNew ("Images/skeletonl.bmp")
    dirImages (ord(Direction.RIGHT)) := Pic.FileNew ("Images/skeletonr.bmp")

    text (0) := "Skeleton: *Creak*"
    text (1) := "Skeleton: You can't kill bones!"
    text (2) := "Skeleton: None shall pass!"

    xPos := 200
    yPos := 400

    xRad := 15
    yRad := 20

    hp := 30
    maxHp := 30
    xpGain := 30
    goldGain := 50
    combatLvl := 3
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 3
    totalLvl := round ((combatLvl + archeryLvl) / 2)

    body procedure detectCollision
        if xPos > 200 then
            setXPos(200)
        end if
    end detectCollision
end Skeleton
