class Goblin
    inherit Enemy

    dirImages (ord(direction.UP)) := Pic.FileNew ("Images/goblinu.bmp")
    dirImages (ord(direction.DOWN)) := Pic.FileNew ("Images/goblind.bmp")
    dirImages (ord(direction.LEFT)) := Pic.FileNew ("Images/goblinl.bmp")
    dirImages (ord(direction.RIGHT)) := Pic.FileNew ("Images/goblinr.bmp")

    text (1) := "Goblin: *Grrrrr*"
    text (2) := "Goblin: I didn't steal it!"
    text (3) := "Goblin: Die human!"

    xPos := 400
    yPos := 300

    hp := 10
    maxHp := 10
    combatLvl := 1
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 1
    totalLvl := round ((combatLvl + archeryLvl) / 2)
end Goblin