class Goblin
    inherit Enemy

    dirImages (1) := Pic.FileNew ("Images/goblinu.bmp")
    dirImages (2) := Pic.FileNew ("Images/goblind.bmp")
    dirImages (3) := Pic.FileNew ("Images/goblinl.bmp")
    dirImages (4) := Pic.FileNew ("Images/goblinr.bmp")

    text (1) := "Goblin: *Grrrrr*"
    text (2) := "Goblin: I didn't steal it!"
    text (3) := "Goblin: Die human!"

    xPos := 400
    yPos := 300

    hp := 10
    combatLvl := 1
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 1
    totalLvl := round ((combatLvl + archeryLvl) / 2)
end Goblin