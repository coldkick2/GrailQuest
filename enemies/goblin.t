class Goblin
    inherit Enemy

    dirImages (ord(Direction.UP)) := Pic.FileNew ("Images/goblinu.bmp")
    dirImages (ord(Direction.DOWN)) := Pic.FileNew ("Images/goblind.bmp")
    dirImages (ord(Direction.LEFT)) := Pic.FileNew ("Images/goblinl.bmp")
    dirImages (ord(Direction.RIGHT)) := Pic.FileNew ("Images/goblinr.bmp")

    text (0) := "Goblin: *Grrrrr*"
    text (1) := "Goblin: I didn't steal it!"
    text (2) := "Goblin: Die human!"

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