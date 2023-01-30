class Hero
    inherit Actor

    import Item

    export destination, frameNumber, movementFrames, weapon, setDestination, setFrameNumber, setWeapon

    var destination : boolean := false

    var frameNumber : int := 0

    var movementFrames : array 0 .. 3, 0 .. 2 of int
    movementFrames(ord(Direction.UP), 0) := Pic.FileNew ("Images/warrior_new1u.bmp")
    movementFrames(ord(Direction.UP), 1) := Pic.FileNew ("Images/warrior_new2u.bmp")
    movementFrames(ord(Direction.UP), 2) := Pic.FileNew ("Images/warrior_new3u.bmp")
    movementFrames(ord(Direction.DOWN), 0) := Pic.FileNew ("Images/warrior_new1d.bmp")
    movementFrames(ord(Direction.DOWN), 1) := Pic.FileNew ("Images/warrior_new2d.bmp")
    movementFrames(ord(Direction.DOWN), 2) := Pic.FileNew ("Images/warrior_new3d.bmp")
    movementFrames(ord(Direction.LEFT), 0) := Pic.FileNew ("Images/warrior_new1l.bmp")
    movementFrames(ord(Direction.LEFT), 1) := Pic.FileNew ("Images/warrior_new2l.bmp")
    movementFrames(ord(Direction.LEFT), 2) := Pic.FileNew ("Images/warrior_new3l.bmp")
    movementFrames(ord(Direction.RIGHT), 0) := Pic.FileNew ("Images/warrior_new1r.bmp")
    movementFrames(ord(Direction.RIGHT), 1) := Pic.FileNew ("Images/warrior_new2r.bmp")
    movementFrames(ord(Direction.RIGHT), 2) := Pic.FileNew ("Images/warrior_new3r.bmp")

    var weapon : pointer to Item := kingsSword

    procedure setDestination(b : boolean)
        destination := b
    end setDestination

    procedure setFrameNumber(i : int)
        frameNumber := i
    end setFrameNumber

    procedure setWeapon(w : pointer to Item)
        weapon := w
    end setWeapon
end Hero