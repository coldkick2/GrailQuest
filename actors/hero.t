class Hero
  inherit Actor

  import Item

  export attacking, destination, frameNumber, follow, followTarget, movementFrames, gold, setGold, weapon, setDestination, setFrameNumber, setWeapon, setAttacking

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

  yPos := 300
  xPos := 400

  var followTarget : pointer to Actor

  var weapon : pointer to Item := kingsSword

  var gold : int := 300

  var combatXp : int := 0

  var archeryXp : int := 0

  var attacking : boolean := false

  procedure setGold(i : int)
    gold := i
  end setGold

  procedure setDestination(b : boolean)
    destination := b
  end setDestination

  procedure setFrameNumber(i : int)
    frameNumber := i
  end setFrameNumber

  procedure follow(actor: pointer to Actor)
    followTarget := actor
  end follow

  procedure setWeapon(w : pointer to Item)
    weapon := w
  end setWeapon

  procedure setAttacking(b : boolean)
    attacking := b
  end setAttacking
end Hero