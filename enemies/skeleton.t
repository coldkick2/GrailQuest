 class Skeleton
    inherit Enemy

    description := "An undead skeleton...creepy!"

    dirImages (ord(direction.UP)) := Pic.FileNew ("Images/skeletonu.bmp")
    dirImages (ord(direction.DOWN)) := Pic.FileNew ("Images/skeletond.bmp")
    dirImages (ord(direction.LEFT)) := Pic.FileNew ("Images/skeletonl.bmp")
    dirImages (ord(direction.RIGHT)) := Pic.FileNew ("Images/skeletonr.bmp")

    text (1) := "Skeleton: *Creak*"
    text (2) := "Skeleton: You can't kill bones!"
    text (3) := "Skeleton: None shall pass!"

    xPos := 200
    yPos := 400

    hp := 30
    combatLvl := 3
    archeryLvl := 1
    dmgMin := 0
    dmgMax := 3
    totalLvl := round ((combatLvl + archeryLvl) / 2)
end Skeleton