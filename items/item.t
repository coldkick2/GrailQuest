class Item
    export description, wieldText, unobtainedText, name, cost, power, boughtpic, invpic, pic, obtained, setObtained, hitSound

    var description : string
    var wieldText : string
    var unobtainedText : string
    var name : string
    var cost : int
    var power : int
    var boughtpic : int
    var invpic : int
    var pic : int
    var hitSound : string := "Sounds/swordhit.wav"
    var obtained : boolean := false
    procedure setObtained (b : boolean)
        obtained := b
    end setObtained
end Item
