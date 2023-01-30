class Zombie
    inherit Actor

    name := "zombie"

    description := "Run! It's a zombie!"

    dirImages (ord(Direction.UP)) := Pic.FileNew ("Images/zombieu.bmp")
    dirImages (ord(Direction.DOWN)) := Pic.FileNew ("Images/zombied.bmp")
    dirImages (ord(Direction.LEFT)) := Pic.FileNew ("Images/zombiel.bmp")
    dirImages (ord(Direction.RIGHT)) := Pic.FileNew ("Images/zombier.bmp")

    text (0) := "Zombie: *uuuurrrrggg...*"
    text (1) := "Zombie: Brrraaaainnnsssss!!!"
    text (2) := "Zombie: *Hissssss!*"

    xPos := 300
    yPos := 400

    xRad := 15
    yRad := 20

    hp := 120
    maxHp := 120
    xpGain := 120
    goldGain := 250
    combatLvl := 10
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 10
    totalLvl := round ((combatLvl + archeryLvl) / 2)

    body procedure detectCollision
        if xPos > 640 then
            setXPos(640)
        elsif xPos < 30 then
            setXPos(30)
        end if
        if yPos < 180 then
            setYPos(180)
        elsif yPos > 570 then
            setYPos(570)
        end if
    end detectCollision
end Zombie