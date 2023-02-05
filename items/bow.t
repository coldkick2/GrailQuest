class Bow
  inherit Item
  name := "Bow"
  description := "This is purchased at the shop in the castle."
  style := "archery"
  wieldText := "You wield your bow...You can now perform ranged attacks."
  unobtainedText := "You don't have a bow."
  cost := 300
  power := 5
  hitSound := "Sounds/bowhit.wav"
  parrySound := "Sounds/bladeparry.wav"
  boughtpic := Pic.FileNew ("Images/bow bought.bmp")
  invpic := Pic.FileNew ("Images/bow-inv.bmp")
  pic := Pic.FileNew ("Images/bow.bmp")
end Bow
