class Zombie
    inherit Enemy

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

    hp := 120
    maxHp := 120
    combatLvl := 10
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 10
    totalLvl := round ((combatLvl + archeryLvl) / 2)
end Zombie