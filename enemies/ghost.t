class Ghost
    inherit Enemy

    description := "OoOOOOooooOOooooO..."

    dirImages (ord(direction.UP)) := Pic.FileNew ("Images/ghostu.bmp")
    dirImages (ord(direction.DOWN)) := Pic.FileNew ("Images/ghostd.bmp")
    dirImages (ord(direction.LEFT)) := Pic.FileNew ("Images/ghostl.bmp")
    dirImages (ord(direction.RIGHT)) := Pic.FileNew ("Images/ghostr.bmp")

    text (1) := "Ghost: *o00ooo0oo*"
    text (2) := "Ghost: The dead call for you!"
    text (3) := "Ghost: Leave this place mortal!"

    xPos := 200
    yPos := 400

    hp := 70
    maxHp := 70
    combatLvl := 7
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 7
    totalLvl := round ((combatLvl + archeryLvl) / 2)
end Ghost
