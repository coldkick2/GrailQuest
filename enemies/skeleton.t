class Skeleton
    inherit Enemy

    description := "An undead skeleton...creepy!"

    dirImages (1) := Pic.FileNew ("Images/skeletonu.bmp")
    dirImages (2) := Pic.FileNew ("Images/skeletond.bmp")
    dirImages (3) := Pic.FileNew ("Images/skeletonl.bmp")
    dirImages (4) := Pic.FileNew ("Images/skeletonr.bmp")

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