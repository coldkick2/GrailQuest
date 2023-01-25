class TwoHanded
    inherit Item
    name := "Two-Handed Sword"
    description := "This is purchased at the shop in the castle."
    wieldText := "You wield your two-handed sword, it improves your attack force significantly."
    unobtainedText := "You don't have a two-handed sword."
    cost := 1000
    power := 15
    hitSound := "Sounds/2hhit.wav"
    boughtpic := Pic.FileNew ("Images/2h bought.bmp")
    invpic := Pic.FileNew ("Images/2h-inv.bmp")
    pic := Pic.FileNew ("Images/2h.bmp")
end TwoHanded
