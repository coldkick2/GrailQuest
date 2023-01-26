class Ghost
    inherit Enemy

    description := "OoOOOOooooOOooooO..."

    dirImages (ord(Direction.UP)) := Pic.FileNew ("Images/ghostu.bmp")
    dirImages (ord(Direction.DOWN)) := Pic.FileNew ("Images/ghostd.bmp")
    dirImages (ord(Direction.LEFT)) := Pic.FileNew ("Images/ghostl.bmp")
    dirImages (ord(Direction.RIGHT)) := Pic.FileNew ("Images/ghostr.bmp")

    text (0) := "Ghost: *o00ooo0oo*"
    text (1) := "Ghost: The dead call for you!"
    text (2) := "Ghost: Leave this place mortal!"

    xPos := 300
    yPos := 450

    hp := 70
    maxHp := 70
    combatLvl := 7
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 7
    totalLvl := round ((combatLvl + archeryLvl) / 2)
end Ghost
