class Troll
    inherit Enemy

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
end Troll