class BattleAxe
    inherit Item
    name := "Battle Axe"
    description := "This is purchased at the shop in the castle."
    wieldText := "You wield your battleaxe, it is heavy and improves your attack force somewhat."
    unobtainedText := "You don't have a battleaxe."
    cost := 500
    power := 10
    hitSound := "Sounds/battleaxehit.wav"
    boughtpic := Pic.FileNew ("Images/battleaxe bought.bmp")
    invpic := Pic.FileNew ("Images/battleaxe-inv.bmp")
    pic := Pic.FileNew ("Images/battleaxe.bmp")
end BattleAxe
