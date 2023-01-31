class Item
    export description, style, wieldText, unobtainedText, name, cost, power, boughtpic, invpic, pic, obtained, setObtained, hitSound, parrySound

    var description : string
    var style : string
    var wieldText : string
    var unobtainedText : string
    var name : string
    var cost : int
    var power : int
    var boughtpic : int
    var invpic : int
    var pic : int
    var hitSound : string := "Sounds/swordhit.wav"
    var parrySound := "Sounds/bladeparry.wav"
    var obtained : boolean := false
    procedure setObtained (b : boolean)
        obtained := b
    end setObtained
end Item
