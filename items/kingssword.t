class KingsSword
    inherit Item
    name := "The King's Sword"
    description := "This sword was provided to you by your king."
    style := "combat"
    wieldText := "You wield the sword provided by your king."
    unobtainedText := ""
    cost := 0
    obtained := true
    power := 0
    hitSound := "Sounds/swordhit.wav"
    parrySound := "Sounds/bladeparry.wav"
    boughtpic := 0
    invpic := Pic.FileNew ("Images/king's sword-inv.bmp")
    pic := 0
end KingsSword
