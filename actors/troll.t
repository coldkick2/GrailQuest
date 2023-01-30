class Troll
    inherit Actor

    name := "troll"

    description := "...looks hungry..."

    dirImages (ord(Direction.UP)) := Pic.FileNew ("Images/trollu.bmp")
    dirImages (ord(Direction.DOWN)) := Pic.FileNew ("Images/trolld.bmp")
    dirImages (ord(Direction.LEFT)) := Pic.FileNew ("Images/trolll.bmp")
    dirImages (ord(Direction.RIGHT)) := Pic.FileNew ("Images/trollr.bmp")

    text (0) := "Troll: *grunt*"
    text (1) := "Troll: Crush human!"
    text (2) := "Troll: Cook human!"

    xPos := 300
    yPos := 400

    xRad := 15
    yRad := 20

    hp := 180
    maxHp := 180
    xpGain := 180
    goldGain := 300
    combatLvl := 20
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 20
    totalLvl := round ((combatLvl + archeryLvl) / 2)

    body procedure detectCollision
        if xPos > 650 then
            setXPos(650)
        elsif xPos < 30 then
            setXPos(30)
        end if
        if yPos < 30 then
            setYPos(30)
        elsif yPos > 570 then
            setYPos(570)
        end if
        if yPos > 280 and yPos < 390 then
            if xPos > 315 and xPos < 320 then     %if approaching fire from left
                setXPos(315)
            elsif xPos < 455 and xPos > 450 then     %if approaching fire from right
                setXPos(455)
            end if
        end if
        if xPos > 315 and xPos < 455 then
            if yPos > 280 and yPos < 285 then     %if approaching fire from bottom
                setYPos(280)
            elsif yPos < 390 and yPos > 385 then     %if approaching fire from top
                setYPos(390)
            end if
        end if
    end detectCollision
end Troll