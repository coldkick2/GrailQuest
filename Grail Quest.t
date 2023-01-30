/*
 ---Grail Quest---
 An S.P.I. Games Production
 Last Updated January 24, 2023
 <><><><><><><><><>
 Grail Quest is an adventure role playing game set in the medieval times where the player searches
 the lands in an ultimate quest to find the holy grail. The player can kill enemies for experience and gold
 to buy items with that will assist them in their quest for the grail.
 <><><><><><><><><>
*/
%--------------------------------------------------------------

type Direction : enum (UP, DOWN, LEFT, RIGHT) 

include "scenes/index.t"
include "items/index.t"
include "actors/index.t"

setscreen ("position:middle,centre,graphics:500;400,offscreenonly,nobuttonbar,nocursor")
var loadpic : int := Pic.FileNew ("Images/opening screen - loading.bmp") %loading screen
var font5 : int := Font.New ("Courier:12")
var record1, record2 : int %records
var percent : real := 0 %load percent
var version : string := "V - GQ2023.01.24"
var xloadanimation, yloadanimation : int := 50
var loaddotsize : array 1 .. 9 of int
loaddotsize (1) := 2
loaddotsize (2) := 3
loaddotsize (3) := 4
loaddotsize (4) := 5
loaddotsize (5) := 6
loaddotsize (6) := 7
loaddotsize (7) := 8
loaddotsize (8) := 9
loaddotsize (9) := 2
var finishedloading : boolean := false

%Items
var kingsSword: ^KingsSword
new KingsSword, kingsSword

var twoHanded: ^TwoHanded
new TwoHanded, twoHanded

var battleAxe: ^BattleAxe
new BattleAxe, battleAxe

var bow: ^Bow
new Bow, bow

%Enemies
var goblin: ^Goblin
new Goblin, goblin

var skeleton: ^Skeleton
new Skeleton, skeleton

var ghost: ^Ghost
new Ghost, ghost

var zombie: ^Zombie
new Zombie, zombie

var troll: ^Troll
new Troll, troll

var peasant: ^Peasant
new Peasant, peasant

process loadanimation
    loop
      drawfilloval (50, 50, 9, 9, black)
      drawfilloval (50, 75, 9, 9, black)
      drawfilloval (50, 100, 9, 9, black)
      drawfilloval (75, 100, 9, 9, black)
      drawfilloval (100, 100, 9, 9, black)
      drawfilloval (100, 75, 9, 9, black)
      drawfilloval (100, 50, 9, 9, black)
      drawfilloval (75, 50, 9, 9, black)
      for d : 1 .. 9
	drawfilloval (xloadanimation, yloadanimation, loaddotsize (d), loaddotsize (d), red)
	if yloadanimation > 25 and yloadanimation < 100 and xloadanimation = 50 then
	  yloadanimation := yloadanimation + 25
	elsif yloadanimation = 100 and xloadanimation > 25 and xloadanimation < 100 then
	  xloadanimation := xloadanimation + 25
	elsif yloadanimation > 50 and xloadanimation > 75 then
	  yloadanimation := yloadanimation - 25
	elsif yloadanimation = 50 and xloadanimation > 50 then
	  xloadanimation := xloadanimation - 25
	end if
	View.Update
      end for
      Time.DelaySinceLast (50)
      exit when finishedloading
    end loop
end loadanimation

fork loadanimation

Pic.Draw (loadpic, 0, 0, picCopy)
Font.Draw (version, 170, 50, font5, yellow)
drawfillbox (95, 185, 405, 215, black)
Font.Draw ("Loading arrays...", 105, 195, font5, white)
View.Update
%>>>VARIABLE TABLE<<<
%--------------------
%*Characters*
%-------------
%Player
%right
var picr : array 1 .. 3 of int
picr (1) := Pic.FileNew ("Images/warrior_new1r.bmp")
picr (2) := Pic.FileNew ("Images/warrior_new2r.bmp")
picr (3) := Pic.FileNew ("Images/warrior_new3r.bmp")
% %left
var picl : array 1 .. 3 of int
picl (1) := Pic.FileNew ("Images/warrior_new1l.bmp")
picl (2) := Pic.FileNew ("Images/warrior_new2l.bmp")
picl (3) := Pic.FileNew ("Images/warrior_new3l.bmp")
%up                                                   29x29
var picu : array 1 .. 3 of int
picu (1) := Pic.FileNew ("Images/warrior_new1u.bmp")
picu (2) := Pic.FileNew ("Images/warrior_new2u.bmp")
picu (3) := Pic.FileNew ("Images/warrior_new3u.bmp")
%down
var picd : array 1 .. 3 of int
picd (1) := Pic.FileNew ("Images/warrior_new1d.bmp")
picd (2) := Pic.FileNew ("Images/warrior_new2d.bmp")
picd (3) := Pic.FileNew ("Images/warrior_new3d.bmp")

%Rat
var ratpic : array 1 .. 10 of int
ratpic (1) := Pic.FileNew ("Images/ratu.bmp") %up
ratpic (2) := Pic.FileNew ("Images/ratd.bmp") %down
ratpic (3) := Pic.FileNew ("Images/ratl.bmp") %left
ratpic (4) := Pic.FileNew ("Images/ratr.bmp") %right
ratpic (5) := Pic.FileNew ("Images/ratd.bmp") %down
ratpic (6) := Pic.FileNew ("Images/ratd.bmp") %down    5x15
ratpic (7) := Pic.FileNew ("Images/ratd.bmp") %down
ratpic (8) := Pic.FileNew ("Images/ratd.bmp") %down
ratpic (9) := Pic.FileNew ("Images/ratd.bmp") %down
ratpic (10) := Pic.FileNew ("Images/ratd.bmp") %down
%Cat
var catpic : array 1 .. 10 of int
catpic (1) := Pic.FileNew ("Images/blackcatu.bmp") %up
catpic (2) := Pic.FileNew ("Images/blackcatd.bmp") %down
catpic (3) := Pic.FileNew ("Images/blackcatl.bmp") %left
catpic (4) := Pic.FileNew ("Images/blackcatr.bmp") %right
catpic (5) := Pic.FileNew ("Images/blackcatd.bmp") %down
catpic (6) := Pic.FileNew ("Images/blackcatd.bmp") %down    23x18
catpic (7) := Pic.FileNew ("Images/blackcatd.bmp") %down
catpic (8) := Pic.FileNew ("Images/blackcatd.bmp") %down
catpic (9) := Pic.FileNew ("Images/blackcatd.bmp") %down
catpic (10) := Pic.FileNew ("Images/blackcatd.bmp") %down
%Chat
var chatentry : array 1 .. 5 of string
chatentry (1) := "Press the 'Shift' key to enter text into the chat window"
chatentry (2) := "Use the arrow in the top right corner of this window to toggle chat history"
chatentry (3) := "You can store a maximum of 5 entries in the chat history at once"
chatentry (4) := "The oldest entry will be discarded when a sixth entry is submitted"
chatentry (5) := ""

%Cat text
var cattext : array 1 .. 3 of string
cattext (1) := "Cat: *Hisssss!*"
cattext (2) := "Cat: *Miiiaaaooowww!*"
cattext (3) := "Cat: *Mew...*"
%Rat text
var rattext : array 1 .. 3 of string
rattext (1) := "Rat: *squeak!*"
rattext (2) := "Rat: *nibble*"
rattext (3) := "Rat: *rustle*"


%--------------------------------------------------------------
%*Other*
%--------
drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading fonts...", 105, 195, font5, white)
View.Update
var font1 : int := Font.New ("Old English Text MT:20")
var font2 : int := Font.New ("Times New Roman:12")
var font3 : int := Font.New ("Old English Text MT:30")
var font4 : int := Font.New ("Times New Roman:7")
var font6 : int := Font.New ("MS Sans Serif:11")
var font7 : int := Font.New ("Courier New:8")
var font8 : int := Font.New ("Old English Text MT:12")
var font9 : int := Font.New ("Courier New:30")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var stoneback : int := Pic.FileNew ("Images/stoneback.bmp")
var cottage_pic : int := Pic.FileNew ("Images/cottage.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var stoneback_wall : int := Pic.FileNew ("Images/stoneback-grey-wall.bmp")
var thatchroof : int := Pic.FileNew ("Images/thatch roof.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var castle_entrance : int := Pic.FileNew ("Images/castle entrance.bmp")
var castle_entrance_all : int := Pic.FileNew ("Images/castle entrance - all.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var outside_entrancepic : int := Pic.FileNew ("Images/outside.bmp")
var outside_entrancepic_all : int := Pic.FileNew ("Images/outside - all.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var shop_pic : int := Pic.FileNew ("Images/shop entrance.bmp")
var shop_pic_all : int := Pic.FileNew ("Images/shop entrance - all.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var cottagekey_pic : int := Pic.FileNew ("Images/cottagekey.bmp")
var chat_window_pic : int := Pic.FileNew ("Images/chat window.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var tree : int := Pic.FileNew ("Images/tree.bmp")  %242x257
var in_cottage_pic : int := Pic.FileNew ("Images/in cottage.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var battleaxe_bought : int := Pic.FileNew ("Images/battleaxe bought.bmp")
var cursor_moveto : int := Pic.FileNew ("Images/cursor - move-to.bmp")
var cursor_attack : int := Pic.FileNew ("Images/cursor - attack.bmp")
var cursor_item : int := Pic.FileNew ("Images/cursor - item.bmp")
var cursor_up : int := Pic.FileNew ("Images/cursor - up.bmp")
var cursor_down : int := Pic.FileNew ("Images/cursor - down.bmp")
var cursor_kwh_true : int := Pic.FileNew ("Images/cursor - kwh2 - true.bmp")
var cursor_kwh_false : int := Pic.FileNew ("Images/cursor - kwh2 - false.bmp")
var cursor_ck_true : int := Pic.FileNew ("Images/cursor - ck - true.bmp")
var cursor_ck_false : int := Pic.FileNew ("Images/cursor - ck - false.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var twohanded_bought : int := Pic.FileNew ("Images/2h bought.bmp")
var warriordeadgreypic : int := Pic.FileNew ("Images/warriordeadgrey.bmp")
var warriordeadblackpic : int := Pic.FileNew ("Images/warriordeadblack.bmp")
var warriorresurrectedpic : int := Pic.FileNew ("Images/warriorresurrected.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var bow_bought : int := Pic.FileNew ("Images/bow bought.bmp")
var witch_house_pic : int := Pic.FileNew ("Images/witch house.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var dark_forest_pic : int := Pic.FileNew ("Images/dark forest.bmp")
var dead_trees : int := Pic.FileNew ("Images/dead trees.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var topbar : int := Pic.FileNew ("Images/top bar.bmp")
var dragon_slain : int := Pic.FileNew ("Images/you slay the dragon.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var westhall : int := Pic.FileNew ("Images/west hall 2.bmp")
var westhall_all : int := Pic.FileNew ("Images/west hall 2 - all.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var key_wh2 : int := Pic.FileNew ("Images/key west hall 2.bmp")  %21x21
var darkoverlay : int := Pic.FileNew ("Images/darkness overlay - torch.bmp") %800x600

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var west_river_pic : int := Pic.FileNew ("Images/west river.bmp")
var logo : int := Pic.FileNew ("Images/credits logo.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var east_of_westriver_pic : int := Pic.FileNew ("Images/east of 'west river'.bmp")
var incastletrapdoor_pic : int := Pic.FileNew ("Images/trapdoor area.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var mappic50 : int := Pic.FileNew ("Images/fullmap 50.bmp")
var hall_all : int := Pic.FileNew ("Images/hall - all.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var mappic100 : int := Pic.FileNew ("Images/fullmap.bmp")
var subcastletunnel_pic : int := Pic.FileNew ("Images/subcastle tunnel.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var location : int := Pic.FileNew ("Images/you are here.bmp")
var subcastletunnel2_pic : int := Pic.FileNew ("Images/subcastle tunnel2.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var centrebtn : int := Pic.FileNew ("Images/centre.bmp")
var trolldungeon_pic : int := Pic.FileNew ("Images/troll dungeon.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var returnbtn : int := Pic.FileNew ("Images/return.bmp")
var stonefloor_pic : int := Pic.FileNew ("Images/stone floor.bmp")
var cursor_normal : int := Pic.FileNew ("Images/cursor - normal.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var scalebtn : int := Pic.FileNew ("Images/scale.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var kingsswordinvpic : int := kingsSword -> invpic

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var battleaxeinvpic : int := Pic.FileNew ("Images/battleaxe-inv.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var twohandedinvpic : int := Pic.FileNew ("Images/2h-inv.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var bowinvpic : int := Pic.FileNew ("Images/bow-inv.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var westriver_northcorner_pic : int := Pic.FileNew ("Images/west river-northwest corner.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var mountains_pic : int := Pic.FileNew ("Images/mountains.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var lair_entrance_pic : int := Pic.FileNew ("Images/lair entrance.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var dragons_lair_pic : int := Pic.FileNew ("Images/dragon's lair.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var dragondead : int := Pic.FileNew ("Images/dragon dead.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var grailpic : int := Pic.FileNew ("Images/grail.bmp") %21x24

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var creditspic : int := Pic.FileNew ("Images/opening screen - credits.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var playpic : int := Pic.FileNew ("Images/opening screen - play.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var exitpic : int := Pic.FileNew ("Images/opening screen - exit.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var intro : int := Pic.FileNew ("Images/opening screen.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var quittomenu_yes : int := Pic.FileNew ("Images/quit to menu - yes.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var quittomenu_no : int := Pic.FileNew ("Images/quit to menu - no.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var quittomenu : int := Pic.FileNew ("Images/quit to menu.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent), 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var creditslist : int := Pic.FileNew ("Images/creditsbackground.bmp") %500x1500
var crypt_pic : int := Pic.FileNew ("Images/crypt.bmp") %800x600
var grailinvpic : int := Pic.FileNew ("Images/grailinv.bmp") %16x18
var info : int := Pic.FileNew ("Images/info screen2.bmp") %600x400
var cemetery_pic : int := Pic.FileNew ("Images/cemetery.bmp") %800x600

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent) - 10, 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update
percent := percent + 2.5
var quit_highlight : int := Pic.FileNew ("Images/quit-highlight.bmp")
var crypt_rope_pic : int := Pic.FileNew ("Images/crypt-rope.bmp") %800x600
var stoneback_grey : int := Pic.FileNew ("Images/stoneback-grey.bmp") %800x600
var healthpack : int := Pic.FileNew ("Images/healthpack.bmp")
var buybutton : int := Pic.FileNew ("Images/buy button.bmp")
var arrows : int := Pic.FileNew ("Images/arrows.bmp")
var leavebutton : int := Pic.FileNew ("Images/leave button.bmp")
var morebutton : int := Pic.FileNew ("Images/more button.bmp")
var battleaxepic : int := Pic.FileNew ("Images/battleaxe.bmp")
var twohandedpic : int := Pic.FileNew ("Images/2h.bmp")
var bowpic : int := Pic.FileNew ("Images/bow.bmp")
var platebodypic : int := Pic.FileNew ("Images/platebody.bmp")
var platebody_bought : int := Pic.FileNew ("Images/platebody bought.bmp")
var platelegspic : int := Pic.FileNew ("Images/platelegs.bmp")
var platelegs_bought : int := Pic.FileNew ("Images/platelegs bought.bmp")
var fullhelmpic : int := Pic.FileNew ("Images/fullhelm.bmp")
var fullhelm_bought : int := Pic.FileNew ("Images/fullhelm bought.bmp")
var backbutton : int := Pic.FileNew ("Images/back button.bmp")

drawfillbox (100, 190, 400, 210, darkgrey)
drawfillbox (100, 190, 100 + round (3 * percent) - 10, 210, brightred)
Font.Draw ("Loading images..." + realstr (percent, 0) + "%", 105, 195, font5, white)
View.Update

drawfillbox (100, 190, 300, 210, brightred)
Font.Draw ("Loading booleans...", 105, 195, font5, white)
View.Update
var grail : boolean := false %holy grail obtained
var up : boolean := true %character image cycling
var battleaxe : boolean := false %battleaxe item obtained
var twohanded : boolean := false %twohanded sword item obtained
var bowObtained : boolean := false %bow item obtained
var key_west_hall : boolean := false %west hall key obtained
var cottagekey : boolean := false %cottage key obtained
var ratalive : boolean := true %rat alive
var dragonhead1alive : boolean := true %dragon head 1 alive
var dragonhead2alive : boolean := true %dragon head 2 alive
var dragonhead3alive : boolean := true %dragon head 3 alive
var exitgame : boolean := false %takes the user out of the game and to main menu if true
var closewindow : boolean := false %closes program if true
var swordon : boolean := true %sword sound effect can be played again if false
var victory : boolean := false %player is victorious if true
var mapscalebtn_on : boolean := true %map scale can be toggled again if false
var music_on : boolean := false %music is on if true
var stopmusic : boolean := false %stops music when true
var destination : boolean := false %player has a destination when true
var ratmove : boolean := false %rat has been assigned a movement when true
var catmove : boolean := false %cat has been assigned a movement when true
var scalehotkey : boolean := true %scale hotkey can be pressed again when true
var attacking : boolean := false %player is under attack when true
var rope : boolean := false %player has the crypt rope when true
var songhotkey : boolean := true %next song hotkey can be pressed again when true
var newdest : boolean := true %a new destination can be selected when true
var platebody : boolean := false %platebody item obtained
var platelegs : boolean := false %platelegs item obtained
var fullhelm : boolean := false %fullhelm item obtained
var buyhp : boolean := false %healthpacks can be selected again in shop when true
var buyarrow : boolean := false %arrows can be selected again in shop when true
var kingsswordlist : boolean := false %king's sword list is down when true
var battleaxelist : boolean := false %battleaxe list is down when true
var twohandedlist : boolean := false %twohanded sword list is down when true
var bowlist : boolean := false %bow list is down when true
var loadnew : boolean := false %new game will be loaded if true
var backtomenu : boolean := false %(for 'back' button) return to main menu if true
var raisechatwindow : boolean := false %chat window will hide if true
var lowerchatwindow : boolean := false %chat window will drop down if true
var slaycutsceneviewed : boolean := false %true if dragon slaying cutscene has been viewed
var introplayed : boolean := false %true if 'Grail Quest' word animation has been viewed
var playerincottage : boolean := false %player is in cottage if true
var returntomenu : boolean := false %return to in-game menu if true (after viewing user manual through in-game menu)
var loadsavedgame : boolean := false %true when user decides to load a saved game
var linkfollowed : boolean := false %true if link on opening screen has been followed
var editmodeenabled : boolean := false %true if edit mode is enabled
var movecharacter : boolean := false %true if a destination has been typed
var movetopreviousscene : boolean := false %true if destination typed does not exist
var soundhotkey : boolean := true %true if sound hotkey can be pressed
var cattalk : boolean := true %true if cat can talk
var rattalk : boolean := true %true if rat can talk
var toggleready : boolean := true %true if mousebutton lifted
var sfx_on : boolean := true %sound effects on/off
var playmusic_on : boolean := true %music on/off
var autosave : boolean := false %if true, game will save automatically
var hotkey, move, mapscroll : array char of boolean %hotkey: hotkeys    move: character movement    mapscroll: map movement

drawfillbox (100, 190, 350, 210, brightred)
Font.Draw ("Loading values...", 105, 195, font5, white)
View.Update
var delayspeed : int := 30 %credits speed
var gold : int := 300 %player gold
var picnum : int := 1 %character image cycling number
var x : int := 400 %character x coordinate
var y : int := 300 %character y coordinate
var xm : int %mouse x coordinate
var ym : int %mouse y coordinate
var button : int %mouse button
buttonchoose ("multibutton")
mousewhere (xm, ym, button) %finds mouse location and button data
var xdest : int := xm %x coordinate of character destination
var ydest : int := ym %y coordinate of character destination
var left : int := button mod 10 % left = 0 or 1
var middle : int := (button - left) mod 100 % middle = 0 or 10
var right : int := button - middle - left % right = 0 or 100
var xpic : int %x coordinate of map
var ypic : int %y coordinate of map
var xdiff : int %distance from x coordinate of map to x coordinate of mouse
var ydiff : int %distance from y coordinate of map to y coordinate of mouse
var archeryxp : int := 0 %archer experience
var archerylvl : int := ((round ((sqrt (archeryxp)) div 3)) + 1) %archery level
var combatxp : int := 0 %combat experience
var combatlvl : int := ((round ((sqrt (combatxp)) div 3)) + 1) %combat level
var xrat : int := 300 %x coordinate of rat
var yrat : int := 300 %y coordinate of rat
var rrat : int := 2 %rat picture number
var xcat : int := 400 %x coordinate of cat
var ycat : int := 450 %y coordinate of cat
var rcat : int := 2 %cat picture number
var ycredits : int := 50 %y coordinate of credits
var hitpoints : int := 100 %character hitpoints
var dragonhead1hp : int := 300 %dragon head 1 hitpoints
var dragonhead2hp : int := 300 %dragon head 2 hitpoints
var dragonhead3hp : int := 300 %dragon head 3 hitpoints
var hpcounter : int := 0 %hitpoints counter
var dragonhead1returncounter : int := 0 %dragon head 1 respawn counter
var dragonhead2returncounter : int := 0 %dragon head 2 respawn counter
var dragonhead3returncounter : int := 0 %dragon head 3 respawn counter
var ratreturncounter : int := 0 %rat respawn counter
var bonus : int := 0 %weapon bonus
var healthpacks : int := 0 %number of healthpacks
var arrownum : int := 50 %number of arrows
var totalLvl : int := round ((combatlvl + archerylvl) / 2) %total level
var dh1totallvl : int := round ((30 + 1) / 2) %dragon head 1 total level
var dh2totallvl : int := round ((30 + 1) / 2) %dragon head 2 total level
var dh3totallvl : int := round ((30 + 1) / 2) %dragon head 3 total level
var dh1lvlclr : int %dragon head 1 level colour
var dh2lvlclr : int %dragon head 2 level colour
var dh3lvlclr : int %dragon head 3 level colour
var barheight : int := 540 %height of NPC name box
var shopscreen : int := 1 %shop interface number
var defence : int := 0 %player defence
var ychat : int := 0 %y coordiante of chat window
var xgrail : int := -50 %x coordinate of 'Grail' intro text
var xquest : int := 501 %x coordinate of 'Quest' intro text
var cattalkcounter : int := 0 %counts to cattalkcountergoal to make cattalk true
var cattalkcountergoal : int := Rand.Int (500, 1000) %the number cattalkcounter must reach to make cattalk true
var rattalkcounter : int := 0 %counts to rattalkcountergoal to make rattalk true
var rattalkcountergoal : int := Rand.Int (500, 1000) %the number rattalkcounter must reach to make rattalk true
var autosavecounter : int := 0 %counts to 'autosavefrequency'
var autosavefrequency : int := 9 %frequency at which game autosaves
var sliderx : int := 310 %autosave slider x position
var xcottagekey : int := 750 %x coordinate of cottage key
var ycottagekey : int := 500 %y coordinate of cottage key
var xkey_west_hall : int := 490 %x coordinate of west hall key
var ykey_west_hall : int := 35 %y coordinate of west hall key
var damagedealt : int := 0 %damage dealt to opponent by player on specific strike
var damagetaken : int := 0 %damage taken by player on specific strike
var splashradius1 : real := 1 %splash radius of splash 1 at cottage scene
var splashradius2 : real := 1 %splash radius of splash 2 at cottage scene
var splashradius3 : real := 1 %splash radius of splash 3 at cottage scene
var ycreditsbackground : real := -1600 %y coordinate of credits background
var xsplash1 : int := Rand.Int (500, 560) %splash x coordinate of splash 1 at cottage scene
var xsplash2 : int := Rand.Int (500, 560) %splash x coordinate of splash 2 at cottage scene
var xsplash3 : int := Rand.Int (500, 560) %splash x coordinate of splash 3 at cottage scene
var ysplash1 : int := Rand.Int (315, 370) %splash y coordinate of splash 1 at cottage scene
var ysplash2 : int := Rand.Int (315, 370) %splash y coordinate of splash 2 at cottage scene
var ysplash3 : int := Rand.Int (315, 370) %splash y coordinate of splash 3 at cottage scene
var weapon : pointer to Item := kingsSword %equipped player weapon
var equipped : string
var scene : string := "" %current scene
var goto : string := "" %scene redirection
var text : string := "Your quest begins...you seek the Holy Grail." %top bar text
var mapscale : string := "50" %map scale
var menubutton : string := "" %highlighted main menu button
var follow : pointer to Enemy %NPC the character is following
var armour : string := "" %armour worn by player
var chatchar : string (1) := "" %entered chat character
var chattext : string := "" %chat entry text (combination of entered chat characters)
var ingamemenubutton : string := "" %in game menu button that is highlighted
var charlastdirection : Direction := Direction.DOWN %last direction faced by character
var sfxtoggle : string := "on" %sound effects on/off
var musictoggle : string := "on" %music on/off
var autosavetoggle : string := "off" %autosave on/off

drawfillbox (100, 190, 400, 210, brightgreen)
Font.Draw ("Loading Complete!", 105, 195, font5, black)
finishedloading := true
View.Update
%------------------------------------------
%>>>END OF VARIABLE TABLE<<<
%------------------------------------------
%>>PROGRAM<<<
%------------------------------------------

proc getInfo(item : pointer to Item)
    loop
      Pic.Draw (info, 100, 100, picMerge)
      drawfillbox (150, 150, 650, 450, black)
      Font.Draw (item -> name, 150, 420, font3, brightred)
      Font.Draw (item -> description, 150, 390, font1, brightred)
      Font.Draw ("Attack advantage: +" + intstr(item -> power), 150, 360, font1, brightred)
      Pic.Draw (returnbtn, 630, 100, picMerge)
      buttonchoose ("multibutton")
      mousewhere (xm, ym, button)
      left := button mod 10         % left = 0 or 1
      middle := (button - left) mod 100         % middle = 0 or 10
      right := button - middle - left         % right = 0 or 100
      if xm > 629 and xm < 701 and ym > 99 and ym < 171 and left = 1 then
	return
      end if
      View.Update
    end loop
end getInfo

proc usermanual
    colourback (black)
    cls
    loop
      Font.Draw ("User Manual", 10, 630, font3, yellow)
      Font.Draw ("-=Hotkeys=-", 10, 600, font6, yellow)
      Font.Draw ("n - next song", 20, 580, font6, grey)
      Font.Draw ("m - open world map", 20, 560, font6, grey)
      drawline (25, 500, 25, 555, grey)
      drawline (20, 555, 25, 555, grey)
      Font.Draw ("s - toggle scale 50%/100%", 30, 540, font6, grey)
      Font.Draw ("c - centre map", 30, 520, font6, grey)
      Font.Draw ("r - return to game", 30, 500, font6, grey)
      Font.Draw ("p - pause", 20, 480, font6, grey)
      Font.Draw ("r - resume game (if paused)", 20, 460, font6, grey)
      Font.Draw ("h - heal (uses player's healthpacks)", 20, 440, font6, grey)
      Font.Draw ("i - information/user manual (current page)", 20, 420, font6, grey)
      Font.Draw ("s - toggle sound effects and music", 20, 400, font6, grey)
      Font.Draw ("Shift - enter chat text", 350, 580, font6, grey)
      Font.Draw ("Esc - menu", 350, 560, font6, grey)
      Font.Draw ("-=Movement=-", 10, 380, font6, yellow)
      Font.Draw ("-Mouse" + "(click to set destination)", 20, 360, font6, grey)
      Font.Draw ("-Arrow keys (use combinations of horizontal and vertical to move diagonally)", 20, 340, font6, grey)
      Font.Draw ("-=Attacking=-", 10, 320, font6, yellow)
      Font.Draw ("-Automatic when in range of attacking (this range is larger when bow is equipped).", 20, 300, font6, grey)
      Font.Draw ("-Maximum Damage = skill level (of skill in use) + bonus of weapon used.", 20, 280, font6, grey)
      Font.Draw ("-=Levelling=-", 10, 260, font6, yellow)
      Font.Draw ("-Skill level = [square root (Exp) / 3] + 1", 20, 240, font6, grey)
      Font.Draw ("-Total level = [(archery + combat) / 2]", 20, 220, font6, grey)
      Font.Draw ("-=Buying Items=-", 10, 200, font6, yellow)
      Font.Draw ("-There is a shop in the west wing of the castle.", 20, 180, font6, grey)
      Font.Draw ("-Click the buy button next to an item to buy it...some items, such as weapons,", 20, 160, font6, grey)
      Font.Draw (" have only a single supply - if you die they return to the shop's stock.", 20, 140, font6, grey)
      Font.Draw ("-=World Map=-", 10, 120, font6, yellow)
      Font.Draw ("-You can scroll across the map by moving your mouse to the edges/corners of the map,", 20, 100, font6, grey)
      Font.Draw (" using the arrow keys (8 directions possible - see 'Movement'), or clicking and dragging the map.", 20, 80, font6, grey)
      Font.Draw ("-" + "(See above for map hotkeys)", 20, 60, font6, grey)
      Font.Draw ("-=Completing the Game=-", 10, 40, font6, yellow)
      Font.Draw ("-After obtaining the grail you must bring it to the king who is at the castle entrance.", 20, 20, font6, grey)
      Pic.Draw (returnbtn, 720, 10, picMerge)
      buttonchoose ("multibutton")
      mousewhere (xm, ym, button)
      left := button mod 10         % left = 0 or 1
      middle := (button - left) mod 100         % middle = 0 or 10
      right := button - middle - left         % right = 0 or 100
      if xm > 719 and xm < 791 and ym > 9 and ym < 71 and left = 1 then
	return
      end if
      View.Update
    end loop
end usermanual

proc talk
    Pic.Draw (topbar, 0, 600, picCopy)
    Font.Draw (" " + intstr (gold), 45, 640, font2, black)
    Font.Draw ("Def.", 145, 645, font4, black)
    Font.Draw (intstr (defence), 150, 636, font4, black)
    Font.Draw (" Lvl.: " + intstr (archerylvl) + ", Exp.: " + intstr (archeryxp), 591, 640, font2, black)
    Font.Draw (" Lvl.: " + intstr (combatlvl) + ", Exp.: " + intstr (combatxp), 590, 614, font2, black)
    Font.Draw (intstr (hitpoints) + "/100", 370, 640, font2, black)
    drawfillbox (524 - hitpoints, 640, 524, 650, red)
    Font.Draw (text, 14, 614, font2, black)
    Font.Draw ("x " + intstr (healthpacks), 169, 636, font4, black)
    Font.Draw (mapscale + "%", 545, 535, font2, blue)
    if key_west_hall then             %if the player has the key to the door in the 2nd west hall
      Pic.Draw (key_wh2, 97, 636, picMerge)
    end if
    if cottagekey then
      Pic.Draw (cottagekey_pic, 119, 635, picMerge)
    end if
    if battleAxe -> obtained then
      Pic.Draw (battleAxe -> invpic, 213, 635, picMerge)
    end if
    if twoHanded -> obtained then
      Pic.Draw (twoHanded -> invpic, 235, 635, picMerge)
    end if
    if bow -> obtained then
      Pic.Draw (bow -> invpic, 258, 635, picMerge)
    end if
    if grail then
      Pic.Draw (grailinvpic, 285, 636, picMerge)
    end if
    if weapon = kingsSword then
      drawbox (190, 634, 212, 656, red)
    elsif weapon = battleAxe then
      drawbox (212, 634, 234, 656, red)
    elsif weapon = twoHanded then
      drawbox (234, 634, 257, 656, red)
    elsif weapon = bow then
      drawbox (257, 634, 280, 656, red)
    end if
    if grail then
      Pic.Draw (grailinvpic, 285, 636, picMerge)
    end if
    Pic.Draw (info, 100, 100, picMerge)
    %conversation
    loop
		drawfillbox (150, 150, 650, 450, black)
		Font.Draw ("Talking to Peasant...", 150, 420, font3, grey)
		Font.Draw ("Say:", 150, 390, font3, grey)
		if xm > 150 and xm < 650 and ym > 360 and ym < 390 then
			Font.Draw ("Hello", 150, 360, font1, brightgreen)
			if left = 1 then
				loop
					drawfillbox (150, 150, 650, 450, black)
					Font.Draw ("Talking to Peasant...", 150, 420, font3, grey)
					Font.Draw ("Peasant responds:", 150, 390, font3, grey)
					Font.Draw ("Hello, how can I help you?", 150, 360, font1, yellow)
					Font.Draw ("Say:", 150, 330, font3, grey)
					if xm > 150 and xm < 650 and ym > 300 and ym < 330 then
						Font.Draw ("Where is the King?", 150, 300, font1, brightgreen)
						Font.Draw ("Where is the Holy Grail?", 150, 270, font1, brightred)
						Font.Draw ("I'm fine thank you, goodbye.", 150, 240, font1, brightred)
						if left = 1 then
							loop
								drawfillbox (150, 150, 650, 450, black)
								Font.Draw ("Talking to Peasant...", 150, 420, font3, grey)
								Font.Draw ("Peasant responds:", 150, 390, font3, grey)
								Font.Draw ("The King is at the castle entrance.", 150, 360, font1, yellow)
								Font.Draw ("Say:", 150, 330, font3, grey)
								if xm > 150 and xm < 650 and ym > 210 and ym < 240 then
									Font.Draw ("Thank you for your help.", 150, 210, font1, brightgreen)
									if left = 1 then
										exit
									end if
								else
									Font.Draw ("Thank you for your help.", 150, 210, font1, brightred)
								end if
								Pic.Draw (returnbtn, 630, 100, picMerge)
								buttonchoose ("multibutton")
								mousewhere (xm, ym, button)
								left := button mod 10                                 % left = 0 or 1
								middle := (button - left) mod 100                                 % middle = 0 or 10
								right := button - middle - left                                 % right = 0 or 100
								if xm > 629 and xm < 701 and ym > 99 and ym < 171 and left = 1 then
									return
								end if
								View.Update
							end loop
						end if
					elsif xm > 150 and xm < 650 and ym > 270 and ym < 300 then
						Font.Draw ("Where is the King?", 150, 300, font1, brightred)
						Font.Draw ("Where is the Holy Grail?", 150, 270, font1, brightgreen)
						Font.Draw ("I'm fine thank you, goodbye.", 150, 240, font1, brightred)
						if left = 1 then
							loop
								drawfillbox (150, 150, 650, 450, black)
								Font.Draw ("Talking to Peasant...", 150, 420, font3, grey)
								Font.Draw ("Peasant responds:", 150, 390, font3, grey)
								Font.Draw ("No one is sure...", 150, 360, font1, yellow)
								Font.Draw ("legend says a dragon guards it!", 150, 330, font1, yellow)
								Font.Draw ("Say:", 150, 300, font3, grey)
								if xm > 150 and xm < 650 and ym > 210 and ym < 240 then
									Font.Draw ("Thank you for your help.", 150, 210, font1, brightgreen)
									if left = 1 then
										exit
									end if
								else
									Font.Draw ("Thank you for your help.", 150, 210, font1, brightred)
								end if
								Pic.Draw (returnbtn, 630, 100, picMerge)
								buttonchoose ("multibutton")
								mousewhere (xm, ym, button)
								left := button mod 10                                 % left = 0 or 1
								middle := (button - left) mod 100                                 % middle = 0 or 10
								right := button - middle - left                                 % right = 0 or 100
								if xm > 629 and xm < 701 and ym > 99 and ym < 171 and left = 1 then
									return
								end if
								View.Update
							end loop
						end if
					elsif xm > 150 and xm < 650 and ym > 240 and ym < 270 then
						Font.Draw ("Where is the Holy Grail?", 150, 270, font1, brightred)
						Font.Draw ("Where is the King?", 150, 300, font1, brightred)
						Font.Draw ("I'm fine thank you, goodbye.", 150, 240, font1, brightgreen)
						if left = 1 then
							return
						end if
					else
						Font.Draw ("Where is the Holy Grail?", 150, 270, font1, brightred)
						Font.Draw ("Where is the King?", 150, 300, font1, brightred)
						Font.Draw ("I'm fine thank you, goodbye.", 150, 240, font1, brightred)
					end if
					Pic.Draw (returnbtn, 630, 100, picMerge)
					buttonchoose ("multibutton")
					mousewhere (xm, ym, button)
					left := button mod 10                     % left = 0 or 1
					middle := (button - left) mod 100                     % middle = 0 or 10
					right := button - middle - left                     % right = 0 or 100
					if xm > 629 and xm < 701 and ym > 99 and ym < 171 and left = 1 then
						return
					end if
					View.Update
				end loop
			end if
		else
			Font.Draw ("Hello", 150, 360, font1, brightred)
		end if
		Pic.Draw (returnbtn, 630, 100, picMerge)
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)
		left := button mod 10         % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		if xm > 629 and xm < 701 and ym > 99 and ym < 171 and left = 1 then
			return
		end if
		View.Update
    end loop
end talk

proc enterchat
    drawfillbox (100, 275, 700, 325, black)
    drawfillbox (105, 280, 695, 320, grey)
    drawline (110 + (length (chattext) * 5), 303, 110 + (length (chattext) * 5), 315, black)
    Font.Draw ("Press 'Enter' to submit text and return to game.", 515, 285, font4, black)
    View.Update
    loop
		drawfillbox (100, 275, 700, 325, black)
		drawfillbox (105, 280, 695, 320, grey)
		getch (chatchar)
		if ord (chatchar) = 8 and length (chattext) > 0 then
			chattext := chattext (1 .. * -1)
		else
			if (ord (chatchar) > 47 and ord (chatchar) < 58) or (ord (chatchar) > 64 and ord (chatchar) < 91) or (ord (chatchar) > 96 and ord (chatchar) < 123) or ord (chatchar) = 32 then
				if length (chattext) < 75 then
					chattext := chattext + chatchar
				end if
			end if
		end if
		Font.Draw (chattext, 110, 305, font7, black)
		drawline (110 + (length (chattext) * 7), 303, 110 + (length (chattext) * 7), 315, black)
		Font.Draw ("Press 'Enter' to submit text and return to game.", 515, 285, font4, black)
		View.Update
		exit when ord (chatchar) = 10
    end loop
    if chattext = "1333999999999ENTEREDITMODE" then
		editmodeenabled := true
    end if
    if editmodeenabled then
		if chattext = "GOLD" then
			gold := gold + 10000
		elsif chattext = "COMBAT" then
			combatxp := 99999
		elsif chattext = "ARCHERY" then
			archeryxp := 99999
		elsif chattext = "RIGHT" then
			x := x + 50
		elsif chattext = "LEFT" then
			x := x - 50
		elsif chattext = "UP" then
			y := y + 50
		elsif chattext = "DOWN" then
			y := y - 50
		elsif chattext = "BATTLEAXE" then
			battleAxe -> setObtained(true)
		elsif chattext = "2H" then
			twoHanded -> setObtained(true)
		elsif chattext = "BOW" then
			bow -> setObtained(true)
		elsif chattext = "HEALTHPACKS" then
			healthpacks := healthpacks + 100
		elsif chattext = "ARROWS" then
			arrownum := arrownum + 1000
		elsif chattext = "ALL ARMOUR" then
			fullhelm := true
			platebody := true
			platelegs := true
		elsif chattext = "FULLHELM" then
			fullhelm := true
		elsif chattext = "PLATEBODY" then
			platebody := true
		elsif chattext = "PLATELEGS" then
			platelegs := true
		elsif chattext = "KWH" then
			key_west_hall := true
		elsif chattext = "CK" then
			cottagekey := true
		elsif chattext = "GRAIL" then
			grail := true
		end if
		if length (chattext) > 5 then
			if chattext (1 .. 4) = "GOTO" then
			goto := chattext (6 .. *)
			movecharacter := true
			chattext := ""
			return
			end if
		end if
    end if
    if chattext ~= "" then
		chattext := "You: " + chattext
    end if
    if chatentry (5) ~= "" and chattext ~= "" then
		for chatnum : 2 .. 5
			chatentry (chatnum - 1) := chatentry (chatnum)
		end for
		chatentry (5) := chattext
    else
		for chatnum : 1 .. 5
			if chatentry (chatnum) = "" and chattext ~= "" then
				chatentry (chatnum) := chattext
				exit
			end if
		end for
    end if
    chattext := ""
end enterchat

process swords
    Music.PlayFile ("Sounds/sword.wav")
end swords

process playHitSound
	Music.PlayFile(weapon -> hitSound)
end playHitSound

process purchase
    Music.PlayFile ("Sounds/buy.wav")
end purchase

process creditsmusic
    Music.PlayFile ("Music/NightFallsOnLondon.mp3")
end creditsmusic

process portcullis
    Music.PlayFile ("Sounds/gate.wav")
end portcullis

process door
    Music.PlayFile ("Sounds/door.wav")
end door

process stonedoor
    Music.PlayFile ("Sounds/stonedoor.wav")
end stonedoor

process music
    if stopmusic then
		  music_on := false
		  stopmusic := false
		  return
    end if

    music_on := true

    if victory then
		  Music.PlayFile ("Music/WON1.mp3")
      return
    end if

		Music.PlayFile ("Music/(fine layers of) slaysenflite.mp3")
		Music.PlayFile ("Music/chocolate outline.mp3")
	  Music.PlayFile ("Music/hoping for real betterness.mp3")
		Music.PlayFile ("Music/never mind the slacks and bashers.mp3")
		Music.PlayFile ("Music/the ballad of ace lebaron.mp3")
		Music.PlayFile ("Music/eat your potatoes.mp3")
  
    music_on := false
end music

proc options
    drawfillbox (150, 150, 650, 450, black)
    Font.Draw ("Options", 150, 420, font3, brightred)
    Font.Draw ("Sound Effects:", 170, 350, font6, grey)
    drawfillbox (280, 350, 290, 360, darkgrey)
    drawfillbox (282, 352, 288, 358, grey)
    Font.Draw ("Music:", 170, 300, font6, grey)
    drawfillbox (280, 300, 290, 310, darkgrey)
    drawfillbox (282, 302, 288, 308, grey)
    Font.Draw ("Auto-save:", 170, 250, font6, grey)
    Font.Draw ("--Frequency--", 310, 270, font6, grey)
    Font.Draw ("Less              More", 300, 230, font6, grey)
    Font.Draw ("*A higher setting may cause lagg.", 415, 250, font6, brightred)
    drawfillbox (280, 250, 290, 260, darkgrey)
    drawfillbox (282, 252, 288, 258, grey)
    %slider tray
    drawfillbox (300, 250, 400, 260, darkgrey)
    drawfillbox (302, 252, 398, 258, grey)
    %slider
    drawfillbox (sliderx - 3, 247, sliderx + 3, 263, yellow)

    loop
		if sfxtoggle = "on" then
			drawline (285, 352, 288, 358, green)
			drawline (282, 355, 285, 352, green)
		elsif sfxtoggle = "off" then
			drawline (282, 352, 288, 358, brightred)
			drawline (282, 358, 288, 352, brightred)
		end if
		if musictoggle = "on" then
			drawline (285, 302, 288, 308, green)
			drawline (282, 305, 285, 302, green)
		elsif musictoggle = "off" then
			drawline (282, 302, 288, 308, brightred)
			drawline (282, 308, 288, 302, brightred)
		end if
		if autosavetoggle = "on" then
			drawline (285, 252, 288, 258, green)
			drawline (282, 255, 285, 252, green)
			%slider
			drawfillbox (sliderx - 3, 247, sliderx + 3, 263, yellow)
		elsif autosavetoggle = "off" then
			drawline (282, 252, 288, 258, brightred)
			drawline (282, 258, 288, 252, brightred)
			%slider
			drawfillbox (sliderx - 3, 247, sliderx + 3, 263, darkgrey)
		end if
		if xm > 280 and xm < 290 and ym > 350 and ym < 360 and left = 1 and toggleready then
			toggleready := false
			if sfxtoggle = "on" then
				sfxtoggle := "off"
				sfx_on := false
				drawfillbox (280, 350, 290, 360, darkgrey)
				drawfillbox (282, 352, 288, 358, grey)
				drawline (282, 352, 288, 358, brightred)
				drawline (282, 358, 288, 352, brightred)
			elsif sfxtoggle = "off" then
				sfxtoggle := "on"
				sfx_on := true
				fork swords
				drawfillbox (280, 350, 290, 360, darkgrey)
				drawfillbox (282, 352, 288, 358, grey)
				drawline (285, 352, 288, 358, green)
				drawline (282, 355, 285, 352, green)
			end if
		elsif xm > 280 and xm < 290 and ym > 300 and ym < 310 and left = 1 and toggleready then
			toggleready := false
			if musictoggle = "on" then
				musictoggle := "off"
				playmusic_on := false
				stopmusic := true
				Music.PlayFileStop
				drawfillbox (280, 300, 290, 310, darkgrey)
				drawfillbox (282, 302, 288, 308, grey)
				drawline (282, 302, 288, 308, brightred)
				drawline (282, 308, 288, 302, brightred)
			elsif musictoggle = "off" then
				musictoggle := "on"
				playmusic_on := true
				fork music
				drawfillbox (280, 300, 290, 310, darkgrey)
				drawfillbox (282, 302, 288, 308, grey)
				drawline (285, 302, 288, 308, green)
				drawline (282, 305, 285, 302, green)
			end if
		elsif xm > 280 and xm < 290 and ym > 250 and ym < 260 and left = 1 and toggleready then
			toggleready := false
			if autosavetoggle = "on" then
				autosavetoggle := "off"
				autosave := false
				drawfillbox (280, 250, 290, 260, darkgrey)
				drawfillbox (282, 252, 288, 258, grey)
				drawline (282, 252, 288, 258, brightred)
				drawline (282, 258, 288, 252, brightred)
			elsif autosavetoggle = "off" then
				autosavetoggle := "on"
				autosave := true
				drawfillbox (280, 250, 290, 260, darkgrey)
				drawfillbox (282, 252, 288, 258, grey)
				drawline (285, 252, 288, 258, green)
				drawline (282, 255, 285, 252, green)
			end if
		elsif left = 0 then
			toggleready := true
		end if
		if xm > sliderx - 3 and xm < sliderx + 3 and ym > 247 and ym < 263 and autosavetoggle = "on" then
			if left = 1 then
				loop
					buttonchoose ("multibutton")
					mousewhere (xm, ym, button)
					left := button mod 10 % left = 0 or 1
					middle := (button - left) mod 100 % middle = 0 or 10
					right := button - middle - left % right = 0 or 100
					if xm > 305 and xm <= 315 then
						sliderx := 310
						autosavefrequency := 9
					elsif xm > 315 and xm <= 325 then
						sliderx := 320
						autosavefrequency := 8
					elsif xm > 325 and xm <= 335 then
						sliderx := 330
						autosavefrequency := 7
					elsif xm > 335 and xm <= 345 then
						sliderx := 340
						autosavefrequency := 6
					elsif xm > 345 and xm <= 355 then
						sliderx := 350
						autosavefrequency := 5
					elsif xm > 355 and xm <= 365 then
						sliderx := 360
						autosavefrequency := 4
					elsif xm > 365 and xm <= 375 then
						sliderx := 370
						autosavefrequency := 3
					elsif xm > 375 and xm <= 385 then
						sliderx := 380
						autosavefrequency := 2
					elsif xm > 385 and xm <= 395 then
						sliderx := 390
						autosavefrequency := 1
					end if
					drawfillbox (300, 247, 400, 263, black)
					drawfillbox (300, 250, 400, 260, darkgrey)
					drawfillbox (302, 252, 398, 258, grey)
					drawfillbox (sliderx - 3, 247, sliderx + 3, 263, yellow)
					View.Update
					exit when left = 0
				end loop
			end if
		end if
		Pic.Draw (returnbtn, 580, 150, picMerge)
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)
		left := button mod 10         % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		if xm > 579 and xm < 651 and ym > 149 and ym < 221 and left = 1 then
			return
		end if
		View.Update
    end loop
end options

process menumusic
    Music.PlayFile ("Music/Menu Music.mp3")
end menumusic

proc gqintro
    Pic.DrawSpecial (intro, 0, 0, picCopy, picFadeIn, 1000)
    setscreen ("position:middle,centre,graphics:500;400,offscreenonly,nobuttonbar,nocursor,title:Grail Quest")
    for x : 1 .. 289
		if xgrail < 105 then
			xgrail := xgrail + 1
		end if
		if x = 155 then
			fork stonedoor
		end if
		Pic.Draw (intro, 0, 0, picCopy)
		Font.Draw ("G r a i l", xgrail, 140, font3, grey)
		if x > 50 then
			xquest := xquest - 1
		end if
		Font.Draw ("Q u e s t", xquest, 140, font3, grey)
		View.Update
		Time.DelaySinceLast (5)
    end for
    fork stonedoor
    introplayed := true
end gqintro

proc credits
    ycredits := 50
    ycreditsbackground := -1600
    setscreen ("position:middle,centre,graphics:500;400,offscreenonly,nobuttonbar,nocursor")
    loop
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		if left = 1 then
			delayspeed := 5
		else
			delayspeed := 27
		end if
		Pic.Draw (creditslist, 0, round (ycreditsbackground), picMerge)

		Font.Draw ("Grail Quest", 10, ycredits, font3, white)

		Font.Draw ("Project Manager", 10, ycredits - 50, font1, white)
		Font.Draw ("Sean Sciberras 'Srlancelot39'", 20, ycredits - 70, font2, white)

		Font.Draw ("Head Programmer", 10, ycredits - 120, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 140, font2, white)

		Font.Draw ("Assistant Programmers", 10, ycredits - 190, font1, white)
		Font.Draw ("Leo LeBlanc 'SNIPERDUDE'", 20, ycredits - 210, font2, white)
		Font.Draw ("Cody Johnson 'Coldkick'", 20, ycredits - 230, font2, white)

		Font.Draw ("Scene Artists", 10, ycredits - 280, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 300, font2, white)
		Font.Draw ("Cody Johnson", 20, ycredits - 320, font2, white)

		Font.Draw ("Character Artists", 10, ycredits - 370, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 390, font2, white)

		Font.Draw ("Item Artists", 10, ycredits - 440, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 460, font2, white)
		Font.Draw ("Leo LeBlanc", 20, ycredits - 480, font2, white)

		Font.Draw ("Interface Artists", 10, ycredits - 530, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 550, font2, white)
		Font.Draw ("Leo LeBlanc", 20, ycredits - 570, font2, white)

		Font.Draw ("Interface Developer", 10, ycredits - 620, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 640, font2, white)

		Font.Draw ("Testing and Debugging", 10, ycredits - 690, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 710, font2, white)
		Font.Draw ("Michael Sciberras", 20, ycredits - 730, font2, white)
		Font.Draw ("Adam Eaton 'Jesus'", 20, ycredits - 750, font2, white)
		Font.Draw ("Andy Heller", 20, ycredits - 770, font2, white)
		Font.Draw ("Leo LeBlanc", 20, ycredits - 790, font2, white)
		Font.Draw ("Cody Johnson", 20, ycredits - 810, font2, white)

		Font.Draw ("Character Image Cycling", 10, ycredits - 860, font1, white)
		Font.Draw ("David McNiven 'Shourix'", 20, ycredits - 880, font2, white)

		Font.Draw ("Plot and Storyline Development", 10, ycredits - 930, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 950, font2, white)

		Font.Draw ("Code Commenting", 10, ycredits - 1000, font1, white)
		Font.Draw ("Sean Sciberras", 20, ycredits - 1020, font2, white)

		Font.Draw ("Music", 10, ycredits - 1070, font1, white)
		Font.Draw ("===Credits===", 20, ycredits - 1090, font2, white)
		Font.Draw ("Night Falls on London - Mike Scott", 20, ycredits - 1110, font2, white)

		Font.Draw ("===In-Game===", 20, ycredits - 1160, font2, white)
		Font.Draw ("Eat Your Potatoes - Ensemble Studios - Age of Mythology", 20, ycredits - 1180, font2, white)
		Font.Draw ("Chocolate Outline - Ensemble Studios - Age of Mythology", 20, ycredits - 1200, font2, white)
		Font.Draw ("Hoping For Real Betterness - Ensemble Studios - Age of Mythology", 20, ycredits - 1220, font2, white)
		Font.Draw ("Never Mind The Slacks And Bashers - Ensemble Studios - Age of Mythology", 20, ycredits - 1240, font2, white)
		Font.Draw ("The Ballad Of Ace Lebaron - Ensemble Studios - Age of Mythology", 20, ycredits - 1260, font2, white)
		Font.Draw ("Fine Layers Of Slaysenflite - Ensemble Studios - Age of Mythology", 20, ycredits - 1280, font2, white)
		Font.Draw ("Won1 - Ensemble Studios - Age of Empires (Kings)", 20, ycredits - 1300, font2, white)
		Font.Draw ("Open - Ensemble Studios - Age of Empires (Kings)", 20, ycredits - 1320, font2, white)

		Font.Draw ("Sound Effects", 10, ycredits - 1370, font1, white)
		Font.Draw ("Button Highlight (sword) - criterionmud.net", 20, ycredits - 1390, font2, white)
		Font.Draw ("Combat sword - microsoft.com", 20, ycredits - 1410, font2, white)
		Font.Draw ("Combat battleaxe - mine.nu", 20, ycredits - 1430, font2, white)
		Font.Draw ("Combat bow - microsoft.com", 20, ycredits - 1450, font2, white)
		Font.Draw ("Combat two-handed sword - livjm.ac.uk", 20, ycredits - 1470, font2, white)
		Font.Draw ("Shop Purchase (coins) - rozziland.com", 20, ycredits - 1490, font2, white)
		Font.Draw ("Gate - sounddogs.com", 20, ycredits - 1510, font2, white)
		Font.Draw ("Key - soundjay.com", 20, ycredits - 1530, font2, white)

		Font.Draw ("Images", 10, ycredits - 1580, font1, white)
		Font.Draw ("stone floor - blogspot.com", 20, ycredits - 1600, font2, white)
		Font.Draw ("'Ye Olde Shoppe' wood - hongkiat.com", 20, ycredits - 1620, font2, white)

		Font.Draw ("Special Thanks To", 10, ycredits - 1670, font1, white)
		Font.Draw ("Angela Beer", 20, ycredits - 1690, font2, white)

		Font.Draw ("Download Hosted By", 10, ycredits - 1740, font1, white)
		Font.Draw ("Sean's Computer Science", 20, ycredits - 1760, font2, white)
		Font.Draw ("http://sites.google.com/seanscomputerscience", 20, ycredits - 1780, font2, white)


		Font.Draw ("S", 220, ycredits - 1850, font9, white)
		Font.Draw ("P", 225, ycredits - 1865, font9, white)
		Font.Draw ("I", 230, ycredits - 1880, font9, white)
		drawline (218, ycredits - 1845, 228, ycredits - 1885, white) %'\' -_\
		drawline (218, ycredits - 1845, 218 + 27, ycredits - 1845, white) %\ '-' _\
		drawline (228, ycredits - 1885, 255, ycredits - 1885, white) %\- '_' \
		drawline (245, ycredits - 1845, 255, ycredits - 1885, white) %\-_ '\'

		Font.Draw ("S.P.I. Games", 110, ycredits - 1950, font9, white)


		Font.Draw ("Copyright 2007-2023 Sciberras Programming Inc. All rights reserved.", 40, ycredits - 1990, font2, white)
		%Pic.Draw (logo, 30, ycredits - 1990, picCopy)

		View.Update
		exit when ycredits > 2040
		ycredits := ycredits + 1
		ycreditsbackground := ycreditsbackground + 0.5
		Time.DelaySinceLast (delayspeed)
    end loop
    Time.DelaySinceLast (3000)
end credits

proc map
    xdiff := 0
    ydiff := 0
    if mapscale = "100" then
		xpic := -3200
		ypic := -600
    elsif mapscale = "50" then
		xpic := -1200
		ypic := -300
    end if
    loop
	Input.KeyDown (hotkey)
	text := "Click and drag, use arrow keys, or move cursor to edges to explore the map."
	buttonchoose ("multibutton")
	mousewhere (xm, ym, button)
	left := button mod 10               % left = 0 or 1
	middle := (button - left) mod 100         % middle = 0 or 10
	right := button - middle - left         % right = 0 or 100
	if left = 1 and (xm < 729 or xm > 793 or ym < 608 or ym > 658) and xm > -1 and xm < 801 and ym > -1 and ym < 601 then
	    xpic := xm - xdiff
	    ypic := ym - ydiff
	else
	    xdiff := xm - xpic
	    ydiff := ym - ypic
	end if
	if mapscale = "50" then
	    if xm > 0 and xm < 30 and ym > 570 and ym < 600 then             %NW
			if xpic < 200 then
				xpic := xpic + 5
			end if
			if ypic > -1100 then
				ypic := ypic - 5
			end if
	    elsif xm > 770 and xm < 800 and ym > 570 and ym < 600 then             %NE
			if xpic > -1800 then
				xpic := xpic - 5
			end if
			if ypic > -1100 then
				ypic := ypic - 5
			end if
	    elsif xm > 770 and xm < 800 and ym > 0 and ym < 30 then             %SE
			if xpic > -1800 then
				xpic := xpic - 5
			end if
			if ypic < 200 then
				ypic := ypic + 5
			end if
	    elsif xm > 0 and xm < 30 and ym > 0 and ym < 30 then             %SW
			if xpic < 200 then
				xpic := xpic + 5
			end if
			if ypic < 200 then
				ypic := ypic + 5
			end if
	    elsif xm > 0 and xm < 30 and ym > 0 and ym < 600 then             %W
			if xpic < 200 then
				xpic := xpic + 5
			end if
			elsif xm > 770 and xm < 800 and ym > 0 and ym < 600 then             %E
			if xpic > -1800 then
				xpic := xpic - 5
			end if
	    elsif ym > 570 and ym < 600 and xm > 0 and xm < 800 then             %N
			if ypic > -1100 then
				ypic := ypic - 5
			end if
	    elsif ym > 0 and ym < 30 and xm > 0 and xm < 800 then             %S
			if ypic < 200 then
				ypic := ypic + 5
			end if
	    end if
	    if left = 0 then
			Input.KeyDown (mapscroll)
			if mapscroll (KEY_LEFT_ARROW) and mapscroll (KEY_DOWN_ARROW) then
				xpic := xpic + 3                     %left
				ypic := ypic + 3                     %down
			elsif mapscroll (KEY_RIGHT_ARROW) and mapscroll (KEY_UP_ARROW) then
				xpic := xpic - 3                     %right
				ypic := ypic - 3                     %up
			elsif mapscroll (KEY_LEFT_ARROW) and mapscroll (KEY_UP_ARROW) then
				xpic := xpic + 3                     %left
				ypic := ypic - 3                     %up
			elsif mapscroll (KEY_RIGHT_ARROW) and mapscroll (KEY_DOWN_ARROW) then
				xpic := xpic - 3                     %right
				ypic := ypic + 3                     %down
			elsif mapscroll (KEY_LEFT_ARROW) then
				xpic := xpic + 4                     %left
			elsif mapscroll (KEY_RIGHT_ARROW) then
				xpic := xpic - 4                     %right
			elsif mapscroll (KEY_UP_ARROW) then
				ypic := ypic - 4                     %up
			elsif mapscroll (KEY_DOWN_ARROW) then
				ypic := ypic + 4                     %down
			end if
	    end if
	    if xpic > 200 then
			xpic := 200
	    elsif xpic < -1800 then
			xpic := -1800
	    end if
	    if ypic > 200 then
			ypic := 200
	    elsif ypic < -1100 then
			ypic := -1100
	    end if
	    drawfillbox (0, 0, 800, 600, black)
	    Pic.Draw (mappic50, xpic, ypic, picMerge)
	    if scene = "outside entrance" then
			Pic.Draw (location, xpic + round (x / 2) + 1600, ypic + round (y / 2) + 600, picMerge)
	    elsif scene = "castle entrance" then
			Pic.Draw (location, xpic + round (x / 2) + 1600, ypic + round (y / 2) + 300, picMerge)
	    elsif scene = "south of entrance" then
			Pic.Draw (location, xpic + round (x / 2) + 1600, ypic + round (y / 2), picMerge)
	    elsif scene = "east hall" then
			Pic.Draw (location, xpic + round (x / 2) + 1800, ypic + round (y / 2) + 300, picMerge)
	    elsif scene = "in-castle trapdoor" then
			Pic.Draw (location, xpic + round (x / 2) + 1800, ypic + round (y / 2), picMerge)
	    elsif scene = "shop" then
			Pic.Draw (location, xpic + round (x / 2) + 1200, ypic + round (y / 2) + 300, picMerge)
	    elsif scene = "in shop" then
			Pic.Draw (location, xpic + round (x / 2) + 1200, ypic + round (y / 2) + 300, picMerge)
	    elsif scene = "west hall" then
			Pic.Draw (location, xpic + round (x / 2) + 800, ypic + round (y / 2) + 300, picMerge)
	    elsif scene = "west river" then
			Pic.Draw (location, xpic + round (x / 2) + 800, ypic + round (y / 2) + 600, picMerge)
	    elsif scene = "cemetery" then
			Pic.Draw (location, xpic + round (x / 2) + 400, ypic + round (y / 2) + 600, picMerge)
	    elsif scene = "dark forest" then
			Pic.Draw (location, xpic + round (x / 2) + 400, ypic + round (y / 2) + 900, picMerge)
	    elsif scene = "witch house" then
			Pic.Draw (location, xpic + round (x / 2) + 0, ypic + round (y / 2) + 900, picMerge)
	    elsif scene = "east of 'west river'" then
			Pic.Draw (location, xpic + round (x / 2) + 1200, ypic + round (y / 2) + 600, picMerge)
	    elsif scene = "west river-north corner" then
			Pic.Draw (location, xpic + round (x / 2) + 800, ypic + round (y / 2) + 900, picMerge)
	    elsif scene = "mountains" then
			Pic.Draw (location, xpic + round (x / 2) + 1200, ypic + round (y / 2) + 900, picMerge)
	    elsif scene = "cottage" then
			Pic.Draw (location, xpic + round (x / 2) + 1600, ypic + round (y / 2) + 900, picMerge)
	    elsif scene = "lair entrance" then
			Pic.Draw (location, xpic + round (x / 2) + 1200, ypic + round (y / 2) + 1200, picMerge)
	    elsif scene = "dragon's lair" then
			Pic.Draw (location, xpic + round (x / 2) + 1200, ypic + round (y / 2) + 1500, picMerge)
	    end if
	elsif mapscale = "100" then         %if scale is 100%
	    if xm > 0 and xm < 30 and ym > 570 and ym < 600 then             %NW
			if xpic < 200 then
				xpic := xpic + 5
			end if
			if ypic > -2600 then
				ypic := ypic - 5
			end if
	    elsif xm > 770 and xm < 800 and ym > 570 and ym < 600 then             %NE
			if xpic > -4200 then
				xpic := xpic - 5
			end if
			if ypic > -2600 then
				ypic := ypic - 5
			end if
	    elsif xm > 770 and xm < 800 and ym > 0 and ym < 30 then             %SE
			if xpic > -4200 then
				xpic := xpic - 5
			end if
			if ypic < 200 then
				ypic := ypic + 5
			end if
	    elsif xm > 0 and xm < 30 and ym > 0 and ym < 30 then             %SW
			if xpic < 200 then
				xpic := xpic + 5
			end if
			if ypic < 200 then
				ypic := ypic + 5
			end if
	    elsif xm > 0 and xm < 30 and ym > 0 and ym < 600 then             %W
			if xpic < 200 then
				xpic := xpic + 5
			end if
			elsif xm > 770 and xm < 800 and ym > 0 and ym < 600 then             %E
			if xpic > -4200 then
				xpic := xpic - 5
			end if
	    elsif ym > 570 and ym < 600 and xm > 0 and xm < 800 then             %N
			if ypic > -2600 then
				ypic := ypic - 5
			end if
	    elsif ym > 0 and ym < 30 and xm > 0 and xm < 800 then             %S
			if ypic < 200 then
				ypic := ypic + 5
			end if
	    end if
	    if left = 0 then
			Input.KeyDown (mapscroll)
			if mapscroll (KEY_LEFT_ARROW) and mapscroll (KEY_DOWN_ARROW) then
				xpic := xpic + 3                     %left
				ypic := ypic + 3                     %down
			elsif mapscroll (KEY_RIGHT_ARROW) and mapscroll (KEY_UP_ARROW) then
				xpic := xpic - 3                     %right
				ypic := ypic - 3                     %up
			elsif mapscroll (KEY_LEFT_ARROW) and mapscroll (KEY_UP_ARROW) then
				xpic := xpic + 3                     %left
				ypic := ypic - 3                     %up
			elsif mapscroll (KEY_RIGHT_ARROW) and mapscroll (KEY_DOWN_ARROW) then
				xpic := xpic - 3                     %right
				ypic := ypic + 3                     %down
			elsif mapscroll (KEY_LEFT_ARROW) then
				xpic := xpic + 4                     %left
			elsif mapscroll (KEY_RIGHT_ARROW) then
				xpic := xpic - 4                     %right
			elsif mapscroll (KEY_UP_ARROW) then
				ypic := ypic - 4                     %up
			elsif mapscroll (KEY_DOWN_ARROW) then
				ypic := ypic + 4                     %down
			end if
	    end if
	    if xpic > 200 then
			xpic := 200
	    elsif xpic < -4200 then
			xpic := -4200
	    end if
	    if ypic > 200 then
			ypic := 200
	    elsif ypic < -2600 then
			ypic := -2600
	    end if
	    drawfillbox (0, 0, 800, 600, black)
	    Pic.Draw (mappic100, xpic, ypic, picMerge)
	    if scene = "outside entrance" then
			Pic.Draw (location, xpic + round (x / 1) + 3200, ypic + round (y / 1) + 1200, picMerge)
	    elsif scene = "castle entrance" then
			Pic.Draw (location, xpic + round (x / 1) + 3200, ypic + round (y / 1) + 600, picMerge)
	    elsif scene = "south of entrance" then
			Pic.Draw (location, xpic + round (x / 1) + 3200, ypic + round (y / 1), picMerge)
	    elsif scene = "east hall" then
			Pic.Draw (location, xpic + round (x / 1) + 4000, ypic + round (y / 1) + 600, picMerge)
	    elsif scene = "in-castle trapdoor" then
			Pic.Draw (location, xpic + round (x / 1) + 4000, ypic + round (y / 1), picMerge)
	    elsif scene = "shop" then
			Pic.Draw (location, xpic + round (x / 1) + 2400, ypic + round (y / 1) + 600, picMerge)
	    elsif scene = "in shop" then
			Pic.Draw (location, xpic + round (x / 1) + 2400, ypic + round (y / 1) + 600, picMerge)
	    elsif scene = "west hall" then
			Pic.Draw (location, xpic + round (x / 1) + 1600, ypic + round (y / 1) + 600, picMerge)
	    elsif scene = "west river" then
			Pic.Draw (location, xpic + round (x / 1) + 1600, ypic + round (y / 1) + 1200, picMerge)
	    elsif scene = "cemetery" then
			Pic.Draw (location, xpic + round (x / 1) + 800, ypic + round (y / 1) + 1200, picMerge)
	    elsif scene = "dark forest" then
			Pic.Draw (location, xpic + round (x / 1) + 800, ypic + round (y / 1) + 1800, picMerge)
	    elsif scene = "witch house" then
			Pic.Draw (location, xpic + round (x / 1) + 0, ypic + round (y / 1) + 1800, picMerge)
	    elsif scene = "east of 'west river'" then
			Pic.Draw (location, xpic + round (x / 1) + 2400, ypic + round (y / 1) + 1200, picMerge)
	    elsif scene = "west river-north corner" then
			Pic.Draw (location, xpic + round (x / 1) + 1600, ypic + round (y / 1) + 1800, picMerge)
	    elsif scene = "mountains" then
			Pic.Draw (location, xpic + round (x / 1) + 2400, ypic + round (y / 1) + 1800, picMerge)
	    elsif scene = "cottage" then
			Pic.Draw (location, xpic + round (x / 1) + 3200, ypic + round (y / 1) + 1800, picMerge)
	    elsif scene = "lair entrance" then
			Pic.Draw (location, xpic + round (x / 1) + 2400, ypic + round (y / 1) + 2400, picMerge)
	    elsif scene = "dragon's lair" then
			Pic.Draw (location, xpic + round (x / 1) + 2400, ypic + round (y / 1) + 3000, picMerge)
	    end if
	end if
	Font.Draw ("World Map", 50, 550, font1, red)
	Pic.Draw (returnbtn, 725, 525, picMerge)
	Pic.Draw (centrebtn, 625, 525, picMerge)
	Pic.Draw (scalebtn, 525, 525, picMerge)
	Pic.Draw (topbar, 0, 600, picCopy)
	Font.Draw (" " + intstr (gold), 45, 640, font2, black)
	Font.Draw ("Def.", 145, 645, font4, black)
	Font.Draw (intstr (defence), 150, 636, font4, black)
	Font.Draw (" Lvl.: " + intstr (archerylvl) + ", Exp.: " + intstr (archeryxp), 591, 640, font2, black)
	Font.Draw (" Lvl.: " + intstr (combatlvl) + ", Exp.: " + intstr (combatxp), 590, 614, font2, black)
	Font.Draw (intstr (hitpoints) + "/100", 370, 640, font2, black)
	drawfillbox (524 - hitpoints, 640, 524, 650, red)
	Font.Draw (text, 14, 614, font2, black)
	Font.Draw ("x " + intstr (healthpacks), 169, 636, font4, black)
	Font.Draw (mapscale + "%", 545, 535, font2, blue)
	if key_west_hall then         %if the player has the key to the door in the 2nd west hall
	    Pic.Draw (key_wh2, 97, 636, picMerge)
	end if
	if cottagekey then
	    Pic.Draw (cottagekey_pic, 119, 635, picMerge)
	end if
	if battleAxe -> obtained then
	    Pic.Draw (battleAxe -> invpic, 213, 635, picMerge)
	end if
	if twoHanded -> obtained then
	    Pic.Draw (twoHanded -> invpic, 235, 635, picMerge)
	end if
	if bow -> obtained then
	    Pic.Draw (bow -> invpic, 258, 635, picMerge)
	end if
	if grail then
	    Pic.Draw (grailinvpic, 285, 636, picMerge)
	end if
	if weapon = kingsSword then
	    drawbox (190, 634, 212, 656, red)
	elsif weapon = battleAxe then
	    drawbox (212, 634, 234, 656, red)
	elsif weapon = twoHanded then
	    drawbox (234, 634, 257, 656, red)
	elsif weapon = bow then
	    drawbox (257, 634, 280, 656, red)
	end if
	if grail then
	    Pic.Draw (grailinvpic, 285, 636, picMerge)
	end if
	%xm as main
	if xm < 0 then
	    if ym < 0 then
			Pic.Draw (cursor_normal, 0, 0, picMerge)
	    elsif ym > 600 then
			Pic.Draw (cursor_normal, 0, 600, picMerge)
	    else
			Pic.Draw (cursor_normal, 0, ym, picMerge)
	    end if
	elsif xm > 800 then
	    if ym < 0 then
			Pic.Draw (cursor_normal, 800, 0, picMerge)
	    elsif ym > 600 then
			Pic.Draw (cursor_normal, 800, 600, picMerge)
	    else
			Pic.Draw (cursor_normal, 800, ym, picMerge)
	    end if
	else
	    %ym as submain
	    if ym < 0 then
			if xm < 0 then
				Pic.Draw (cursor_normal, 0, 0, picMerge)
			elsif xm > 800 then
				Pic.Draw (cursor_normal, 800, 0, picMerge)
			else
				Pic.Draw (cursor_normal, xm, 0, picMerge)
			end if
	    elsif ym > 600 then
			if xm < 0 then
				Pic.Draw (cursor_normal, 0, 600, picMerge)
			elsif xm > 800 then
				Pic.Draw (cursor_normal, 800, 600, picMerge)
			else
				Pic.Draw (cursor_normal, xm, 600, picMerge)
			end if
	    else
			Pic.Draw (cursor_normal, xm, ym, picMerge)
	    end if
	end if
	%ym as main
	if ym < 0 then
	    if xm < 0 then
			Pic.Draw (cursor_normal, 0, 0, picMerge)
	    elsif xm > 800 then
			Pic.Draw (cursor_normal, 800, 0, picMerge)
	    else
			Pic.Draw (cursor_normal, xm, 0, picMerge)
	    end if
	elsif ym > 600 then
	    if xm < 0 then
			Pic.Draw (cursor_normal, 0, 600, picMerge)
	    elsif xm > 800 then
			Pic.Draw (cursor_normal, 800, 600, picMerge)
	    else
			Pic.Draw (cursor_normal, xm, 600, picMerge)
	    end if
	else
	    %xm as submain
	    if xm < 0 then
			if ym < 0 then
				Pic.Draw (cursor_normal, 0, 0, picMerge)
			elsif ym > 600 then
				Pic.Draw (cursor_normal, 0, 600, picMerge)
			else
				Pic.Draw (cursor_normal, 0, ym, picMerge)
			end if
	    elsif xm > 800 then
			if ym < 0 then
				Pic.Draw (cursor_normal, 800, 0, picMerge)
			elsif ym > 600 then
				Pic.Draw (cursor_normal, 800, 600, picMerge)
			else
				Pic.Draw (cursor_normal, 800, ym, picMerge)
			end if
	    else
			Pic.Draw (cursor_normal, xm, ym, picMerge)
	    end if
	end if
	View.Update
	if (xm > 724 and xm < 796 and ym > 524 and ym < 596 and left = 1) or hotkey ('r') then
	    text := "You fold away your map and continue exploring."
	    exit
	elsif (xm > 624 and xm < 696 and ym > 524 and ym < 596 and left = 1) or hotkey ('c') then
	    if mapscale = "50" then
			xpic := -1200
			ypic := -300
	    elsif mapscale = "100" then
			xpic := -3200
			ypic := -600
	    end if
	elsif ((xm > 524 and xm < 596 and ym > 524 and ym < 596 and left = 1) or (hotkey ('s') and scalehotkey)) and mapscalebtn_on then
	    if mapscale = "50" then
			mapscale := "100"
	    else
			mapscale := "50"
	    end if
	    scalehotkey := false
	    mapscalebtn_on := false
	end if
	if ~ (xm > 524 and xm < 596 and ym > 524 and ym < 596 and left = 1) then
	    mapscalebtn_on := true
	end if
	if ~ hotkey ('s') then
	    scalehotkey := true
	end if
    end loop
end map

proc reset(var go_to : string)
	setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
	Pic.Draw (warriordeadgreypic, 0, 0, picCopy)
	Pic.DrawSpecial (warriordeadblackpic, 0, 0, picCopy, picFadeIn, 3000)
	Pic.DrawSpecial (warriorresurrectedpic, 0, 0, picCopy, picFadeIn, 3000)
	Pic.DrawSpecial (castle_entrance_all, 0, 0, picCopy, picFadeIn, 3000)
	setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
	attacking := false
	text := "You die...a monk resurrects you and warns you to be more careful..."
	go_to := "castle entrance"
	battleAxe -> setObtained(false)
	twoHanded -> setObtained(false)
	bow -> setObtained(false)
	platebody := false
	platelegs := false
	fullhelm := false
	key_west_hall := false
	cottagekey := false
	x := 400
	y := 100
	arrownum := 0
	gold := 0
	hitpoints := 25
	healthpacks := 0
	weapon := kingsSword
end reset

proc restoreInv
	battleAxe -> setObtained(battleaxe)
	twoHanded -> setObtained(twohanded)
	bow -> setObtained(bowObtained)
	if equipped = kingsSword -> name then
		weapon := kingsSword
	elsif equipped = battleAxe -> name then
		weapon := battleAxe
	elsif equipped = twoHanded -> name then
		weapon := twoHanded
	elsif equipped = bow -> name then
		weapon := bow
	end if
end restoreInv

proc save
		equipped := weapon -> name
    open : record1, "Grail Quest - records.gqr", write
    write : record1, grail, up, battleAxe -> obtained, twoHanded -> obtained, bow -> obtained, key_west_hall, cottagekey, dragonhead1alive, dragonhead2alive, dragonhead3alive,
	victory, music_on, stopmusic, destination, scalehotkey, attacking, rope, songhotkey, newdest,
	platebody, platelegs, fullhelm, buyhp, buyarrow, delayspeed, gold, picnum, x, y, xdest, ydest,
	xpic, ypic, xdiff, ydiff, archeryxp, combatxp,  hitpoints,
	dragonhead1hp,
	dragonhead2hp, dragonhead3hp, hpcounter, dragonhead1returncounter, dragonhead2returncounter, dragonhead3returncounter,
	bonus, healthpacks, arrownum, barheight, shopscreen, defence, equipped, scene, goto,
	text, mapscale, follow, armour, sfx_on, chatentry (1), chatentry (2), chatentry (3), chatentry (4), chatentry (5)
    close : record1
    drawdot (793, 602, brightgreen)
    drawdot (795, 602, brightgreen)
    drawdot (797, 602, brightgreen)
end save

proc load
    open : record1, "Grail Quest - records.gqr", read
    read : record1, grail, up, battleaxe, twohanded, bowObtained, key_west_hall, cottagekey, dragonhead1alive, dragonhead2alive, dragonhead3alive,
	victory, music_on, stopmusic, destination, scalehotkey, attacking, rope, songhotkey, newdest,
	platebody, platelegs, fullhelm, buyhp, buyarrow, delayspeed, gold, picnum, x, y, xdest, ydest,
	xpic, ypic, xdiff, ydiff, archeryxp, combatxp, hitpoints,
	dragonhead1hp,
	dragonhead2hp, dragonhead3hp, hpcounter, dragonhead1returncounter, dragonhead2returncounter, dragonhead3returncounter,
	bonus, healthpacks, arrownum, barheight, shopscreen, defence, equipped, scene, goto,
	text, mapscale, follow, armour, sfx_on, chatentry (1), chatentry (2), chatentry (3), chatentry (4), chatentry (5)
    close : record1
	restoreInv()
end load

proc drawHero
  if destination
    or move (KEY_LEFT_ARROW)
    or move (KEY_RIGHT_ARROW)
    or move (KEY_UP_ARROW)
    or move (KEY_DOWN_ARROW) then
    if picnum + 1 > 3 then
      picnum := 1
    else
      picnum := picnum + 1
    end if
  else
    picnum := 1
  end if

  case charlastdirection of
    label Direction.LEFT: Pic.Draw (picl (picnum), x, y, picMerge)
    label Direction.RIGHT: Pic.Draw (picr (picnum), x, y, picMerge)
    label Direction.UP: Pic.Draw (picu (picnum), x, y, picMerge) 
    label Direction.DOWN: Pic.Draw (picd (picnum), x, y, picMerge)
  end case
  Time.DelaySinceLast (30)
end drawHero

proc movement     %manipulates character movement input
  if ~ victory then
    Input.KeyDown (move)
		if xm > x - 1 and xm < x + 21 and ym > y - 1 and ym < y + 30 then
			Font.Draw ("You [Level " + intstr (totalLvl) + "]", x, y + 30, font2, white)
		end if
		if ym < 601 and ym > -1 and xm > -1 and xm < 801 then         %if mouse in playing screen then move character
			if xm < 787 or xm > 793 or ym < 585 or ym > 595 then
				if left = 1 and newdest then
					destination := true
					xdest := xm - 7
					ydest := ym
					follow := nil
					newdest := false
				elsif left = 0 then
					newdest := true
				end if
			end if
		end if
		if destination then
      if follow ~= nil then
        xdest := follow -> xPos
        ydest := follow -> yPos
      end if
			drawbox (xdest - 1, ydest - 8, xdest + 15, ydest + 8, brightred)
			if x + 8 > xdest + 3 and y > ydest + 3 then             %left/down
				x := x - 3
				y := y - 3
				charlastdirection := Direction.LEFT
			elsif x + 8 > xdest + 3 and y < ydest - 3 then             %left/up
				x := x - 3
				y := y + 3
				charlastdirection := Direction.LEFT
			elsif x + 8 < xdest - 3 and y > ydest + 3 then             %right/down
				x := x + 3
				y := y - 3
				charlastdirection := Direction.RIGHT
			elsif x + 8 < xdest - 3 and y < ydest - 3 then             %right/up
				x := x + 3
				y := y + 3
				charlastdirection := Direction.RIGHT
			elsif x + 8 > xdest + 4 then             %left
				x := x - 4
				charlastdirection := Direction.LEFT
			elsif x + 8 < xdest - 4 then             %right
				x := x + 4
				charlastdirection := Direction.RIGHT
			elsif y < ydest - 4 then             %up
				y := y + 4
				charlastdirection := Direction.UP
			elsif y > ydest + 4 then             %down
				y := y - 4
				charlastdirection := Direction.DOWN
			else
				if follow ~= peasant then
					destination := false
				end if
			end if
		elsif left = 0 then
			if move (KEY_LEFT_ARROW) and move (KEY_DOWN_ARROW) then
				x := x - 3                 %left
				y := y - 3                 %down
				charlastdirection := Direction.LEFT
			elsif move (KEY_RIGHT_ARROW) and move (KEY_UP_ARROW) then
				x := x + 3                 %right
				y := y + 3                 %up
				charlastdirection := Direction.RIGHT
			elsif move (KEY_LEFT_ARROW) and move (KEY_UP_ARROW) then
				x := x - 3                 %left
				y := y + 3                 %up
				charlastdirection := Direction.LEFT
			elsif move (KEY_RIGHT_ARROW) and move (KEY_DOWN_ARROW) then
				x := x + 3                 %right
				y := y - 3                 %down
				charlastdirection := Direction.RIGHT
			elsif move (KEY_LEFT_ARROW) then
				x := x - 4                 %left
				charlastdirection := Direction.LEFT
			elsif move (KEY_RIGHT_ARROW) then
				x := x + 4                 %right
				charlastdirection := Direction.RIGHT
			elsif move (KEY_UP_ARROW) then
				y := y + 4                 %up
				charlastdirection := Direction.UP
			elsif move (KEY_DOWN_ARROW) then
				y := y - 4                 %down
				charlastdirection := Direction.DOWN
      end if
		end if
    drawHero()
  end if
end movement

proc buyItem(item: pointer to Item)
	if ~ item -> obtained then
		if gold >= item -> cost then
			item -> setObtained(true)
			gold := gold - item -> cost
			Pic.Draw (item -> invpic, 235, 635, picMerge)
			View.Update()
			if sfx_on then
				fork purchase
			end if
		else
			text := "You need " + intstr (item -> cost - gold) + " more gold to cover the cost."
		end if
	end if
end buyItem

proc equipItem(item: pointer to Item)
	if item -> obtained then
		if weapon ~= item then
			weapon := item
			if sfx_on then
				fork playHitSound
			end if
			text := item -> wieldText
		end if
	else
		text := item -> unobtainedText
	end if
end equipItem

proc attack_enemy(enemy : pointer to Enemy, var go_to : string)
  if enemy -> alive then
    if xm > enemy -> xPos - 1 and xm < enemy -> xPos + 21 and ym > enemy -> yPos - 1 and ym < enemy -> yPos + 30 then
      if right = 100 then
        text := enemy -> description
      elsif left = 1 then
        destination := true
        follow := enemy
      end if
    end if
    if ((weapon -> style = "combat")
      and (abs ((enemy -> xPos + enemy -> xRad) - (x + 15)) < 20
      and abs ((enemy -> yPos + enemy -> yRad) - (y + 15)) < 20))
      or (weapon -> style = "archery"
      and (abs ((enemy -> xPos + enemy -> xRad) - (x + 15)) < 100
      and abs ((enemy -> yPos + enemy -> yRad) - (y + 15)) < 200)) then
      attacking := true
      if xdest = enemy -> xPos and ydest = enemy -> yPos then
        destination := false
      end if
      text := "You are attacking a " + enemy -> name + "!  Arrows left: " + intstr (arrownum) + "  Goblin: -" + intstr (damagedealt) + "HP  You: -" + intstr (damagetaken - defence) + "HP"
      if hpcounter = 20 or hpcounter = 40 then
        if hitpoints > 0 then
          if abs ((enemy -> xPos + enemy -> xRad) - (x + 15)) < 20 and abs ((enemy -> yPos + enemy -> yRad) - (y + 15)) < 20 then
            damagetaken := Rand.Int (enemy -> dmgMin, enemy -> dmgMax)
            if defence < damagetaken then
              hitpoints := hitpoints - (damagetaken - defence)
            end if
          end if
        else
          reset(go_to)
          return
        end if
        if enemy -> hp > 0 then
          %if using a combat attack style
          if weapon -> style = "combat" then
            %inflicts damage to enemy accoring to player's skill level
            damagedealt := Rand.Int (0, (combatlvl + bonus))
            enemy -> setHp(enemy -> hp - damagedealt)
            if enemy -> hp > 0 then
              enemy -> setAlive(true)
            else
              enemy -> setHp(0)
              text := "You defeat the " + enemy -> name + " and gain " + intstr(enemy -> xpGain) + " experience and " + intstr(enemy -> goldGain) + " gold."
              enemy -> setAlive(false)
              if gold <= 99989 then
                gold := gold + enemy -> goldGain
              else
                text := "You do not have room to carry any more gold!"
              end if
              if combatlvl < 100 then
                combatxp := combatxp + enemy -> xpGain
              else
                text := "You've mastered the art of combat and cannot gain further experience."
              end if
            end if
          %if using an archery attack style
          elsif weapon -> style = "archery" then
            %inflicts damage to enemy accoring to player's skill level
            if arrownum > 0 then
              arrownum := arrownum - 1
              damagedealt := Rand.Int (0, (archerylvl + bonus))
              enemy -> setHp(enemy -> hp - damagedealt)
              if enemy -> hp > 0 then
                enemy -> setAlive(true)
              else
                enemy -> setHp(0)
                text := "You defeat the " + enemy -> name + " and gain " + intstr(enemy -> xpGain) + " experience and " + intstr(enemy -> goldGain) + " gold."
                enemy -> setAlive(false)
                if gold <= 99989 then
                  gold := gold + enemy -> goldGain
                else
                  text := "You do not have room to carry any more gold!"
                end if
                if archerylvl < 100 then
                  archeryxp := archeryxp + enemy -> xpGain
                else
                  text := "You've mastered the art of archery and cannot gain further experience."
                end if
              end if
            else
              text := "You have run out of arrows!"
            end if
          end if
          if weapon -> style = "archery" then
            if arrownum > 0 then
              fork playHitSound
            end if
          else
            fork playHitSound
          end if
        end if
      end if
    else
      attacking := false
    end if
  else
    attacking := false
  end if
end attack_enemy

proc collision (var go_to : string)     %detects collisions with objects and buttons
    Input.KeyDown (hotkey)
    if ~ hotkey ('n') then
		songhotkey := true
    end if
    if hotkey ('n') and songhotkey then         %if 'n' key is pressed, stop current song (advance to next song)
		Music.PlayFileStop
		songhotkey := false
    elsif hotkey ('m') then
		map         %display map
    elsif hotkey ('p') or Window.GetActive ~= -1 then
		Pic.Draw (info, 100, 100, picMerge)
		Font.Draw ("Game Paused", 280, 300, font3, brightred)
		Font.Draw ("Press 'R' to resume game...", 235, 200, font1, brightred)
		View.Update
		loop
			Input.KeyDown (hotkey)
			exit when hotkey ('r')
		end loop
    elsif hotkey ('h') then
		if healthpacks > 0 then
			if hitpoints < 90 then
				hitpoints := hitpoints + 10
				healthpacks := healthpacks - 1
				text := "You use a health pack...it heals you slightly."
			else
				text := "You do not need healing at the moment."
			end if
		else
			text := "You do not have any health packs; you should buy some more."
		end if
    elsif hotkey ('i') then
		usermanual
    elsif hotkey (KEY_SHIFT) then
		enterchat
    end if
    if xm > 729 and xm < 793 and ym > 608 and ym < 658 and left = 1 then         %if map is to be opened
		map         %display map
    end if
    if xm > 140 and xm < 163 and ym > 633 and ym < 657 then         %displays list of worn armour
		drawfillbox (141, 620, 710, 630, grey)
		drawbox (141, 620, 710, 630, darkgrey)
		drawbox (140, 634, 163, 656, red)
		Font.Draw (armour, 145, 623, font4, black)
    end if
    if xm > 190 and xm < 212 and ym > 633 and ym < 657 then         %king's sword
		drawbox (190, 634, 212, 656, red)
		if left = 1 then         %if king's sword is selected
			equipItem(kingsSword)
		elsif right = 100 then
			kingsswordlist := true
			battleaxelist := false
			twohandedlist := false
			bowlist := false
		end if
    elsif xm > 212 and xm < 234 and ym > 633 and ym < 656 then         %battleaxe
		drawbox (212, 634, 234, 656, red)
		if left = 1 then         %if battleaxe is selected
			equipItem(battleAxe)
		elsif right = 100 then
			kingsswordlist := false
			battleaxelist := true
			twohandedlist := false
			bowlist := false
		end if
    elsif xm > 234 and xm < 257 and ym > 633 and ym < 656 then         %2h
		drawbox (234, 634, 257, 656, red)
		if left = 1 then         %if 2h is selected
			equipItem(twoHanded)
		elsif right = 100 then
			kingsswordlist := false
			battleaxelist := false
			twohandedlist := true
			bowlist := false
		end if
    elsif xm > 257 and xm < 280 and ym > 633 and ym < 656 then         %bow
		drawbox (257, 634, 280, 656, red)
		if left = 1 then         %if bow is selected
			equipItem(bow)
		elsif right = 100 then
			kingsswordlist := false
			battleaxelist := false
			twohandedlist := false
			bowlist := true
		end if
    elsif xm > 281 and xm < 304 and ym > 635 and ym < 656 and left = 1 then         %if grail is selected
		if ~ grail then
			text := "You must find the grail and return it to your king."
		else
			text := "You have found the grail!  You should return it to your king."
		end if
    elsif xm > 166 and xm < 189 and ym > 635 and ym < 656 and left = 1 then
		if healthpacks > 0 then
			if hitpoints < 90 then
				hitpoints := hitpoints + 10
				healthpacks := healthpacks - 1
				text := "You use a health pack...it heals you slightly."
			else
				text := "You do not need healing at the moment."
			end if
		else
			text := "You do not have any health packs; you should buy some more."
		end if
    elsif xm > 506 and xm < 531 and ym > 608 and ym < 632 then
	Pic.Draw (quit_highlight, 507, 608, picCopy)
	%xm as main
	if xm < 0 then
	    if ym < 0 then
			Pic.Draw (cursor_normal, 0, 0, picMerge)
	    elsif ym > 665 then
			Pic.Draw (cursor_normal, 0, 600, picMerge)
	    else
			Pic.Draw (cursor_normal, 0, ym, picMerge)
	    end if
	elsif xm > 800 then
	    if ym < 0 then
			Pic.Draw (cursor_normal, 800, 0, picMerge)
	    elsif ym > 665 then
			Pic.Draw (cursor_normal, 800, 600, picMerge)
	    else
			Pic.Draw (cursor_normal, 800, ym, picMerge)
	    end if
	else
	    %ym as submain
	    if ym < 0 then
			if xm < 0 then
				Pic.Draw (cursor_normal, 0, 0, picMerge)
			elsif xm > 800 then
				Pic.Draw (cursor_normal, 800, 0, picMerge)
			else
				Pic.Draw (cursor_normal, xm, 0, picMerge)
			end if
	    elsif ym > 665 then
			if xm < 0 then
				Pic.Draw (cursor_normal, 0, 665, picMerge)
			elsif xm > 800 then
				Pic.Draw (cursor_normal, 800, 665, picMerge)
			else
				Pic.Draw (cursor_normal, xm, 665, picMerge)
			end if
	    else
			Pic.Draw (cursor_normal, xm, ym, picMerge)
	    end if
	end if
	%ym as main
	if ym < 0 then
	    if xm < 0 then
			Pic.Draw (cursor_normal, 0, 0, picMerge)
	    elsif xm > 800 then
			Pic.Draw (cursor_normal, 800, 0, picMerge)
	    else
			Pic.Draw (cursor_normal, xm, 0, picMerge)
	    end if
	elsif ym > 665 then
	    if xm < 0 then
			Pic.Draw (cursor_normal, 0, 665, picMerge)
	    elsif xm > 800 then
			Pic.Draw (cursor_normal, 800, 665, picMerge)
	    else
			Pic.Draw (cursor_normal, xm, 665, picMerge)
	    end if
	else
	    %xm as submain
	    if xm < 0 then
			if ym < 0 then
				Pic.Draw (cursor_normal, 0, 0, picMerge)
			elsif ym > 665 then
				Pic.Draw (cursor_normal, 0, 665, picMerge)
			else
				Pic.Draw (cursor_normal, 0, ym, picMerge)
			end if
		elsif xm > 800 then
			if ym < 0 then
				Pic.Draw (cursor_normal, 800, 0, picMerge)
			elsif ym > 665 then
				Pic.Draw (cursor_normal, 800, 665, picMerge)
			else
				Pic.Draw (cursor_normal, 800, ym, picMerge)
			end if
		else
			Pic.Draw (cursor_normal, xm, ym, picMerge)
		end if
	end if
    end if
    if kingsswordlist then
		drawfillbox (147, 567, 215, 633, grey)
		drawfillbox (150, 570, 212, 630, black)
		if ym > 600 and ym < 630 then
			drawfillbox (150, 600, 212, 630, green)
			Font.Draw ("Wield", 155, 610, font2, yellow)
			Font.Draw ("Info.", 155, 580, font2, yellow)
			if left = 1 then
			equipItem(kingsSword)
			end if
		elsif ym > 570 and ym < 600 then
			drawfillbox (150, 570, 212, 600, green)
			Font.Draw ("Wield", 155, 610, font2, yellow)
			Font.Draw ("Info.", 155, 580, font2, yellow)
			if left = 1 then
				getInfo(kingsSword)
			end if
		end if
		Font.Draw ("Wield", 155, 610, font2, yellow)
		Font.Draw ("Info.", 155, 580, font2, yellow)
		if xm < 150 or xm > 212 then
			kingsswordlist := false
		end if
    elsif battleaxelist then
		drawfillbox (169, 567, 237, 633, grey)
		drawfillbox (172, 570, 234, 630, black)
		if ym > 600 and ym < 630 then
			drawfillbox (172, 600, 234, 630, green)
			Font.Draw ("Wield", 177, 610, font2, yellow)
			Font.Draw ("Info.", 177, 580, font2, yellow)
			if left = 1 then
				equipItem(battleAxe)
			end if
		elsif ym > 570 and ym < 600 then
			drawfillbox (172, 570, 234, 600, green)
			Font.Draw ("Wield", 177, 610, font2, yellow)
			Font.Draw ("Info.", 177, 580, font2, yellow)
			if left = 1 then
				getInfo(battleAxe)
			end if
		end if
		Font.Draw ("Wield", 177, 610, font2, yellow)
		Font.Draw ("Info.", 177, 580, font2, yellow)
		if xm < 172 or xm > 234 then
			battleaxelist := false
		end if
    elsif twohandedlist then
		drawfillbox (191, 567, 259, 633, grey)
		drawfillbox (194, 570, 256, 630, black)
		if ym > 600 and ym < 630 then
			drawfillbox (194, 600, 256, 630, green)
			Font.Draw ("Wield", 199, 610, font2, yellow)
			Font.Draw ("Info.", 199, 580, font2, yellow)
			if left = 1 then
				equipItem(twoHanded)
			end if
		elsif ym > 570 and ym < 600 then
			drawfillbox (194, 570, 256, 600, green)
			Font.Draw ("Wield", 199, 610, font2, yellow)
			Font.Draw ("Info.", 199, 580, font2, yellow)
			if left = 1 then
				getInfo(twoHanded)
			end if
		end if
		Font.Draw ("Wield", 199, 610, font2, yellow)
		Font.Draw ("Info.", 199, 580, font2, yellow)
		if xm < 194 or xm > 256 then
			twohandedlist := false
		end if
    elsif bowlist then
		drawfillbox (213, 567, 281, 633, grey)
		drawfillbox (216, 570, 278, 630, black)
		if ym > 600 and ym < 630 then
			drawfillbox (216, 600, 278, 630, green)
			Font.Draw ("Wield", 225, 610, font2, yellow)
			Font.Draw ("Info.", 225, 580, font2, yellow)
			if left = 1 then
				equipItem(bow)
			end if
		elsif ym > 570 and ym < 600 then
			drawfillbox (216, 570, 278, 600, green)
			Font.Draw ("Wield", 225, 610, font2, yellow)
			Font.Draw ("Info.", 225, 580, font2, yellow)
			if left = 1 then
				getInfo(bow)
			end if
		end if
		Font.Draw ("Wield", 225, 610, font2, yellow)
		Font.Draw ("Info.", 225, 580, font2, yellow)
		if xm < 216 or xm > 278 then
			bowlist := false
		end if
    end if
	bonus := weapon -> power
    if scene = "castle entrance" then         %if inside castle
		if y > 354 and (x < 284 or x > 457) then         %if colliding with wall but not entrance
			y := 354
		end if
		if x > 200 and x < 600 and y < 400 then
			if grail then
				Font.Draw ("You return the Holy Grail to your king...", 100, 300, font3, yellow)
				Font.Draw ("Quest Complete!", 300, 200, font3, yellow)
				text := "You return the Holy Grail to your king...Quest Complete!"
				if ~ victory then
					Music.PlayFileStop
				end if
				victory := true
			end if
		end if
    elsif scene = "south of entrance" then                         %if south of entrance
		if y < 30 then
			y := 30
		end if
		if x < 30 then
			x := 30
		end if
    elsif scene = "east hall" then                     %if east hall
		if y > 354 then
			y := 354
		end if
		if x > 770 then
			x := 770
		end if
    elsif scene = "in-castle trapdoor" then                 %if in-castle trapdoor
		if x > 770 then
			x := 770
		end if
		if y < 30 then
			y := 30
		end if
    elsif scene = "subcastle tunnel" then                 %if subcastle tunnel
		if y > 350 then
			y := 350
		elsif y < 230 then
			y := 230
		end if
    elsif scene = "subcastle tunnel2" then                     %if subcastle tunnel2
		if y > 350 then
			y := 350
		elsif y < 230 then
			y := 230
		end if
    elsif scene = "troll dungeon" then                         %if troll dungeon
		if y < 30 then
			y := 30
		elsif y > 570 then
			y := 570
		end if
		if x > 650 then
			x := 650
		elsif x < 30 and (y > 350 or y < 230) then
			x := 30
		end if
		if y > 280 and y < 390 then
			if x > 315 and x < 320 then     %if approaching fire from left
				x := 315
			elsif x < 455 and x > 450 then     %if approaching fire from right
				x := 455
			end if
		end if
		if x > 315 and x < 455 then
			if y > 280 and y < 285 then     %if approaching fire from bottom
				y := 280
			elsif y < 390 and y > 385 then     %if approaching fire from top
				y := 390
			end if
		end if
      attack_enemy(troll, go_to)
    elsif scene = "outside entrance" then         %if outside entrance
		%tree1
		if x > 100 and x < 110 and y > 65 and y < 120 then         % if coming from the left
			x := 100
		elsif x < 270 and x > 260 and y > 65 and y < 120 then         %if coming from the right
			x := 270
		elsif y < 120 and y > 110 and x > 100 and x < 270 then         %if coming from above
			y := 120
		elsif y > 65 and y < 80 and x > 100 and x < 270 then         %if coming from below
			y := 65
		end if
		%tree2
		if x > 500 and x < 510 and y > 15 and y < 60 then         % if coming from the left
			x := 500
		elsif x < 670 and x > 660 and y > 15 and y < 70 then         %if coming from the right
			x := 670
		elsif y < 70 and y > 60 and x > 500 and x < 670 then         %if coming from above
			y := 70
		elsif y > 15 and y < 30 and x > 500 and x < 670 then         %if coming from below
			y := 15
		end if
		%tree3
		if x > 300 and x < 310 and y > 265 and y < 320 then         %if coming from the left
			x := 300
		elsif x < 470 and x > 460 and y > 265 and y < 320 then         %if coming from the right
			x := 470
		elsif y < 320 and y > 310 and x > 300 and x < 470 then         %if coming from above
			y := 320
		elsif y > 265 and y < 280 and x > 300 and x < 470 then         %if coming from below
			y := 265
		end if
		if x > 770 then
			x := 770
		end if
		if y > 570 and x > 360 then
			y := 570
		end if
    elsif scene = "shop" then
		if y > 354 then         %if colliding with wall
			y := 354
		elsif y < 30 then
			y := 30
		end if
		if x > 470 and x < 480 and y > 200 then
			x := 470
		elsif x > 480 and y > 195 and y < 205 and not (x > 615 and x < 656) then
			y := 195
		end if
		if x > 700 and y > 195 then
			y := 195
		end if
    elsif scene = "in shop" then
		if shopscreen = 1 then
			if xm > 159 and xm < 241 and ym > 342 and ym < 389 and left = 1 then             %if battleaxe selected
				buyItem(battleAxe)
			elsif xm > 322 and xm < 404 and ym > 342 and ym < 389 and left = 1 then             %if 2h selected
				buyItem(twoHanded)
			elsif xm > 190 and xm < 272 and ym > 93 and ym < 140 then             %if healthpacks selected
				if left = 1 and buyhp then
					if gold >= 100 then
						gold := gold - 100
						Font.Draw ("x " + intstr (healthpacks), 169, 636, font4, yellow)
						View.Update
						if sfx_on then
							fork purchase
						end if
						healthpacks := healthpacks + 1
					else
						text := "You need " + intstr (100 - gold) + " more gold to cover the cost."
					end if
					buyhp := false
				elsif left = 0 then
					buyhp := true
				end if
			elsif xm > 527 and xm < 609 and ym > 342 and ym < 389 and left = 1 then             %if bow selected
				buyItem(bow)
			elsif xm > 454 and xm < 536 and ym > 95 and ym < 138 then             %if arrows selected
				if left = 1 and buyarrow then
					if gold >= 50 then
						gold := gold - 50
						arrownum := arrownum + 10
						if sfx_on then
							fork purchase
						end if
					else
						text := "You need " + intstr (50 - gold) + " more gold to cover the cost."
					end if
					buyarrow := false
				elsif left = 0 then
					buyarrow := true
				end if
			elsif xm > 718 and xm < 800 and ym > 46 and ym < 93 and left = 1 then
				shopscreen := 2
			elsif xm > 718 and xm < 801 and ym > 0 and ym < 47 and left = 1 then             %if player wants to leave the shop
				y := 150
				go_to := "shop"
				return
			end if
		elsif shopscreen = 2 then
			if xm > 149 and xm < 232 and ym > 249 and ym < 297 and left = 1 then             %platebody
				if ~ platebody then
					if gold >= 750 then
						gold := gold - 750
						platebody := true
						if sfx_on then
							fork purchase
						end if
					else
						text := "You need " + intstr (750 - gold) + " more gold to cover the cost."
					end if
				end if
			elsif xm > 399 and xm < 482 and ym > 249 and ym < 297 and left = 1 then             %platelegs
				if ~ platelegs then
					if gold >= 500 then
						gold := gold - 500
						platelegs := true
						if sfx_on then
							fork purchase
						end if
					else
						text := "You need " + intstr (500 - gold) + " more gold to cover the cost."
					end if
				end if
			elsif xm > 649 and xm < 730 and ym > 249 and ym < 297 and left = 1 then             %fullhelm
				if ~ fullhelm then
					if gold >= 400 then
						gold := gold - 400
						fullhelm := true
						if sfx_on then
							fork purchase
						end if
					else
						text := "You need " + intstr (400 - gold) + " more gold to cover the cost."
					end if
				end if
			end if
			if xm > 0 and xm < 82 and ym > 0 and ym < 47 and left = 1 then             %back
				shopscreen := 1
			end if
		end if
    elsif scene = "west hall" then
		if y > 354 then
			if x > 117 and x < 141 then
				if ~ key_west_hall then
					y := 354
					text := "The door is locked.  You should find the key..."
				end if
			else
				y := 354
			end if
		end if
		if y < 30 then
			y := 30
		end if
		if x < 30 then
			x := 30
		end if
    elsif scene = "west river" then
      if x > 210 and x < 220 then         %"west river"'s west edge
        x := 210
      end if
      if x > 480 and x < 490 then         %"west river"'s east edge
        x := 490
      end if
      %key west hall
      if x > xkey_west_hall - 5 and x < xkey_west_hall + 26 and y > ykey_west_hall - 5 and y < ykey_west_hall + 26 then
        key_west_hall := true
        text := "You find a battered iron key..."
      end if
      attack_enemy(skeleton, go_to)
    elsif scene = "cemetery" then
      if x > 530 and x < 548 and (y < 193 or y > 273) then         %if colliding with trees
        x := 548
      else         %if not within cemetery
        if y < 30 then             %if at bottom of scene
          y := 30
        end if
      end if
      if (y > 273 or y < 193) and x < 548 then
        if y > 273 then
          y := 273
        elsif y < 193 then
          y := 193
        end if
      end if
      attack_enemy(ghost, go_to)
    elsif scene = "crypt" then
      if x > 630 then
        x := 630
      end if
      if x < 30 then
        x := 30
      end if
      if y < 180 then
        y := 180
      end if
      if y > 570 then
        y := 570
      end if
      if x > 510 and x < 560 and y > 190 and y < 230 and ~ rope then
        rope := true
        text := "You find a rope and catch it on a rock on the surface...it seems secure."
      end if
      attack_enemy(zombie, go_to)
    elsif scene = "dark forest" then
		if x < 735 and y > 155 and y < 281 then         %north trees from the south
			y := 155
		end if
		if y > 155 and x > 720 and x < 735 then         %north trees from the east
			x := 735
		end if
		if y > 20 and y < 40 and x < 550 then         %south trees from the north
			y := 40
		end if
		if y < 40 and x > 540 and x < 550 then         %south trees from the east
			x := 550
		end if
		if y > 570 then
			y := 570
		end if
    elsif scene = "witch house" then
		if y < 210 then         %south trees form the north
			y := 210
		elsif y > 280 and y < 300 and x > 387 then         %northeast trees from the south
			y := 280
		end if
		if x > 387 and x < 400 and y > 280 then         %northeast trees from the west
			x := 387
		elsif x < 125 then         %west trees from the east
			x := 125
		end if
		if y > 465 then
			if x > 250 and x < 264 then
				text := "You don't think you should go in there..."
			end if
			y := 465
		end if
		if ratalive then
			if abs ((xcat + 23) - xrat) < 20 and abs ((ycat + 23) - yrat) < 20 then
				ratalive := false
				xrat := 0
				yrat := 0
			end if
		end if
    elsif scene = "east of 'west river'" then
      if y < 30 then         %bottom of screen
        y := 30
      end if  
		  attack_enemy(goblin, go_to)
    elsif scene = "west river-north corner" then
		%southeast side
		if x > 460 and x < 490 and y < 280 then         %moving west to water
			x := 490
		end if
		if y > 250 and y < 280 and x > 460 then         %moving north to water
			y := 250
		end if
		%northwest side
		if x > 210 and x < 220 and y < 520 then
			x := 210
		end if
		if y > 490 and y < 520 and x > 210 then
			y := 520
		end if
		%edges
		if y > 565 then         %top of screen
			y := 565
		end if
    elsif scene = "mountains" then
		if y > 250 and y < 280 then
			y := 250
		elsif y > 490 and y < 520 then
			y := 520
		end if
    elsif scene = "lair entrance" then
		if x < 30 then
			x := 30
		elsif x > 770 then
			x := 770
		end if
		if y > 395 and (x < 341 or x > 430) then
			y := 395
		end if
    elsif scene = "cottage" then
		if x > xcottagekey - 5 and x < xcottagekey + 26 and y > ycottagekey - 5 and y < ycottagekey + 26 and ~ cottagekey then
			cottagekey := true
			text := "You find a small, tarnished bronze key..."
		end if
		if y > 250 and y < 280 then
			y := 250
		elsif y > 490 and y < 520 then
			y := 520
		elsif y < 30 and x > 420 then
			y := 30
		elsif y > 570 then
			y := 570
		end if
		if x > 765 then
			x := 765
		end if
		if x > 505 and y > 66 and y < 168 then         %if player is in cottage
			playerincottage := true
		else
			playerincottage := false
		end if
		if peasant -> xPos > 505 and peasant -> yPos > 66 and peasant -> yPos < 168 then         %if peasant is in cottage
			peasant -> setInCottage(true)
		else
			peasant -> setInCottage(false)
		end if
		if x > 360 and x < 400 and (y < 75 or (y > 120 and y < 490)) then
			x := 360
		elsif x > 399 and x < 439 and (y < 75 or (y > 120 and y < 490)) then
			x := 439
		end if
		if y > 75 and y < 112 and x > 495 and x < 515 then
			if ~ cottagekey then
				text := "The door seems to be locked..."
				x := 495
			end if
		elsif (y > 56 and y < 76 and x > 495 and x < 515) or (y > 111 and y < 180 and x > 495 and x < 515) then
			x := 495
		end if
		if x > 495 then
			if y > 45 and y < 54 then             %if south of cottage
			y := 45
			elsif y > 169 and y < 180 then             %if north of cottage
			y := 180
			end if
		end if
		if x > 495 then
			if y > 53 and y < 73 then             %if inside at south wall
			y := 73
			end if
			if y > 160 and y < 180 then             %if inside at north wall
			y := 160
			end if
		end if
		if (x > 515 and x < 533 and y > 56 and y < 76) or (x > 515 and x < 533 and y > 111 and y < 180) then
			x := 533
		end if
		if xm > peasant -> xPos - 1 and xm < peasant -> xPos + 30 and ym > peasant -> yPos - 1 and ym < peasant -> yPos + 30 then
			if right = 100 then
				text := peasant -> description
			elsif left = 1 then
				destination := true
				follow := peasant
			end if
		end if
    elsif scene = "dragon's lair" then
		if dragonhead1alive or dragonhead2alive or dragonhead3alive then
			text := "Dragon Hitpoints: Head 1 = " + frealstr ((dragonhead1hp / 300) * 100, 0, 1) + "% Head 2 = " + frealstr ((dragonhead2hp / 300) * 100, 0, 1) + "% Head 3 = " +
			frealstr ((dragonhead3hp / 300) * 100, 0, 1) + "%"
		elsif ~ dragonhead1alive and ~ dragonhead2alive and ~ dragonhead3alive and ~ grail then
			text := "You slay the dragon! The Holy Grail lies before you..."
		end if
		if y > 570 then
			y := 570
		end if
		%left lava
		if x < 330 and x > 100 and y < 400 and y > 370 then         %if approaching left lava from top
			y := 400
		elsif x < 330 and x > 300 and y < 400 and y > 0 then         %if approaching left lava from side
			x := 330
		end if
		%right lava
		if x < 800 and x > 450 and y < 400 and y > 370 then         %if approaching right lava from top
			y := 400
		elsif x < 480 and x > 450 and y < 400 and y > 0 then         %if approaching right lava from side
			x := 450
		end if
		if x < 100 then         %left side
			x := 100
		elsif x > 670 then         %right side
			x := 670
		end if
		if x > 322 and x < 369 and y > 299 and y < 325 and ~ dragonhead1alive and ~ dragonhead2alive and ~ dragonhead3alive then
			grail := true
			text := "You take the Holy Grail...you should bring it to the king."
		end if
		if dragonhead1alive then
		if x > 180 and x < 220 and y > 500 and y < 550 then
				attacking := true
				if hpcounter = 20 or hpcounter = 40 then
				if hitpoints > 0 then
						damagetaken := Rand.Int (0, 30)
						if defence < damagetaken then
						hitpoints := hitpoints - (damagetaken - defence)
						end if
				else
						reset(go_to)
						return
				end if
				if dragonhead1hp > 0 then
						%if using a combat attack style
						if weapon -> style = "combat" then
						%inflicts damage to dragon accoring to player's skill level
						damagedealt := Rand.Int (0, (combatlvl + bonus))
						dragonhead1hp := dragonhead1hp - damagedealt
						if dragonhead1hp > 0 then
								dragonhead1alive := true
						else
								dragonhead1hp := 0
								dragonhead1alive := false
								if combatlvl < 100 then
								combatxp := combatxp + 100
								else
								text := "You've mastered the art of combat and cannot gain further experience."
								end if
						end if
						end if
						if weapon -> style = "archery" then
							if arrownum > 0 then
								fork playHitSound
							end if
						else
							fork playHitSound
						end if
				end if
				end if
		else
				attacking := false
		end if
		else
		attacking := false
		end if
		if dragonhead2alive then
		if x > 380 and x < 420 and y > 450 and y < 500 then
				attacking := true
				if hpcounter = 20 or hpcounter = 40 then
				if hitpoints > 0 then
						damagetaken := Rand.Int (0, 30)
						if defence < damagetaken then
						hitpoints := hitpoints - (damagetaken - defence)
						end if
				else
						reset(go_to)
						return
				end if
				if dragonhead2hp > 0 then
						%if using a combat attack style
						if weapon -> style = "combat" then
						%inflicts damage to dragon accoring to player's skill level
						damagedealt := Rand.Int (0, (combatlvl + bonus))
						dragonhead2hp := dragonhead2hp - damagedealt
						end if
						if dragonhead2hp > 0 then
						dragonhead1alive := true
						else
						dragonhead2hp := 0
						dragonhead2alive := false
						if combatlvl < 100 then
								combatxp := combatxp + 100
						else
								text := "You've mastered the art of combat and cannot gain further experience."
						end if
						end if
						if weapon -> style = "archery" then
							if arrownum > 0 then
								fork playHitSound
							end if
						else
							fork playHitSound
						end if
				end if
				end if
		else
				attacking := false
		end if
		else
		attacking := false
		end if
		if dragonhead3alive then
		if x > 580 and x < 620 and y > 500 and y < 550 then
				attacking := true
				if hpcounter = 20 or hpcounter = 40 then
				if hitpoints > 0 then
						damagetaken := Rand.Int (0, 30)
						if defence < damagetaken then
						hitpoints := hitpoints - (damagetaken - defence)
						end if
				else
						reset(go_to)
						return
				end if
				if dragonhead3hp > 0 then
						%if using a combat attack style
						if weapon -> style = "combat" then
							%inflicts damage to dragon accoring to player's skill level
							damagedealt := Rand.Int (0, (combatlvl + bonus))
							dragonhead3hp := dragonhead3hp - damagedealt
						end if
						if dragonhead3hp > 0 then
						dragonhead3alive := true
						else
							dragonhead3hp := 0
							dragonhead3alive := false
						if combatlvl < 100 then
								combatxp := combatxp + 100
						else
								text := "You've mastered the art of combat and cannot gain further experience."
						end if
						end if
						if weapon -> style = "archery" then
							if arrownum > 0 then
								fork playHitSound
							end if
						else
							fork playHitSound
						end if
				end if
				end if
		else
				attacking := false
		end if
		else
		attacking := false
		end if
    end if
end collision

process regenEnemy(enemy : pointer to Enemy)
  if enemy -> alive then
    if enemy -> hp < enemy -> maxHp then
      if hpcounter = 40 then
	if abs ((enemy -> xPos + 10) - (x + 15)) > 19 and abs ((enemy -> yPos + 15) - (y + 15)) > 19 then
	  enemy -> setHp(enemy -> hp + 1)
	end if
      end if
    end if
  else
    if enemy -> respawnCounter = 300 then
      enemy -> setRespawnCounter(0)
      enemy -> setAlive(true)
      enemy -> setHp(enemy -> maxHp)
    else
      enemy -> setRespawnCounter(enemy -> respawnCounter + 1)
    end if
  end if
end regenEnemy

proc drawscreen (var goto : string)         %generates graphics according to scene and conditions
    cls
    if gold > 99999 then         %if gold exceeds maximum amount
		gold := 99999         %set to maximum
		text := "You can't hold any more gold coins!...It seems you have plenty anyway."
    end if
    if platebody and platelegs and fullhelm then
		defence := 7         %3+2+1+1(bonus)
		armour := "You are wearing a full suit of armour to achieve an additional +1 defence bonus: Item (Def. #) - Fullhelm (1) + Platebody (3) + Platelegs (2) + 1 = 7"
    elsif platebody and platelegs and ~ fullhelm then
		defence := 5         %3+2
		armour := "You are wearing: Item (Def. #) - Platebody (3) + Platelegs (2) = 5"
    elsif platebody and ~ platelegs and fullhelm then
		defence := 4         %3+1
		armour := "You are wearing: Item (Def. #) -  Fullhelm (1) + Platebody (3) = 4"
    elsif platebody and ~ platelegs and ~ fullhelm then
		defence := 3         %3
		armour := "You are wearing: Item (Def. #) - Platebody (3) = 3"
    elsif ~ platebody and platelegs and fullhelm then
		defence := 3         %2+1
		armour := "You are wearing: Item (Def. #) -  Fullhelm (1) + Platelegs (2) = 3"
    elsif ~ platebody and platelegs and ~ fullhelm then
		defence := 2         %2
		armour := "You are wearing: Item (Def. #) -  Platelegs (2) = 2"
    elsif ~ platebody and ~ platelegs and fullhelm then
		defence := 1         %1
		armour := "You are wearing: Item (Def. #) -  Fullhelm (1) = 1"
    else
		defence := 0         %0
		armour := "You are not wearing any armour.  You can buy some at the shop."
    end if
    totalLvl := round ((combatlvl + archerylvl) / 2)
    dh1totallvl := round ((10 + 1) / 2)
    dh2totallvl := round ((10 + 1) / 2)
    dh3totallvl := round ((10 + 1) / 2)
    if playmusic_on then
		if ~ music_on then         %if music has finished, turn back on
			fork music
		end if
    end if
    if hpcounter = 40 then
		hpcounter := 0
    else
		hpcounter := hpcounter + 1
    end if
    %character
    if hitpoints < 100 then
		if hpcounter = 40 then
			if ~ attacking then
					hitpoints := hitpoints + 1
					damagedealt := 0
					damagetaken := 0
			end if
		end if
    end if
    fork regenEnemy(goblin)
    fork regenEnemy(skeleton)
    fork regenEnemy(ghost)
    fork regenEnemy(zombie)
    fork regenEnemy(troll)
    %rat
    if ~ ratalive then
		if ratreturncounter = 300 then
		ratreturncounter := 0
		ratalive := true
		xrat := Rand.Int (130, 400)
		yrat := Rand.Int (230, 450)
		else
		ratreturncounter := ratreturncounter + 1
		end if
    end if
    %dragonhead1
    if dragonhead1alive then
		if dragonhead1hp < 300 then
		if hpcounter = 40 then
				if ~ (x > 180 and x < 220) or not (y > 500 and y < 550) then
				dragonhead1hp := dragonhead1hp + 1
				end if
		end if
		end if
    else
		if dragonhead1returncounter = 500 then
		dragonhead1returncounter := 0
		dragonhead1alive := true
		dragonhead1hp := 300
		else
		if dragonhead2alive or dragonhead3alive then
				dragonhead1returncounter := dragonhead1returncounter + 1
		else
				dragonhead1returncounter := 0
		end if
		end if
    end if
    %dragonhead2
    if dragonhead2alive then
		if dragonhead2hp < 300 then
		if hpcounter = 40 then
				if ~ (x > 380 and x < 420) or not (y > 450 and y < 500) then
				dragonhead2hp := dragonhead2hp + 1
				end if
		end if
		end if
    else
		if dragonhead2returncounter = 500 then
		dragonhead2returncounter := 0
		dragonhead2alive := true
		dragonhead2hp := 300
		else
		if dragonhead1alive or dragonhead3alive then
				dragonhead2returncounter := dragonhead2returncounter + 1
		else
				dragonhead2returncounter := 0
		end if
		end if
    end if
    %dragonhead3
    if dragonhead3alive then
		if dragonhead3hp < 300 then
		if hpcounter = 40 then
				if ~ (x > 580 and x < 620) or not (y > 500 and y < 550) then
				dragonhead3hp := dragonhead3hp + 1
				end if
		end if
		end if
    else
		if dragonhead3returncounter = 500 then
		dragonhead3returncounter := 0
		dragonhead3alive := true
		dragonhead3hp := 300
		else
		if dragonhead1alive or dragonhead2alive then
				dragonhead3returncounter := dragonhead3returncounter + 1
		else
				dragonhead3returncounter := 0
		end if
		end if
    end if
    if scene = "castle entrance" then         %if in castle
		drawfillbox (283, 355, 458, 500, green)
		Pic.Draw (stoneback, 0, 0, picMerge)
		Pic.Draw (castle_entrance, 0, 0, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "south of entrance" then                     %if outside entrance
		Pic.Draw (stonefloor_pic, 0, 0, picCopy)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "east hall" then                     %if outside entrance
		Pic.Draw (hall_all, 0, 0, picCopy)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "in-castle trapdoor" then                 %if outside entrance
		Pic.Draw (incastletrapdoor_pic, 0, 0, picMerge)
		if xm > 700 and ym < 330 and ym > 250 then
			Pic.Draw (cursor_down, xm - 18, ym - 18, picMerge)
		else
			Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		end if
    elsif scene = "subcastle tunnel" then                 %if outside entrance
		Pic.Draw (subcastletunnel_pic, 0, 0, picMerge)
		if xm < 30 then
			Pic.Draw (cursor_up, xm - 18, ym - 18, picMerge)
		else
			Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		end if
    elsif scene = "subcastle tunnel2" then                     %if outside entrance
		Pic.Draw (subcastletunnel2_pic, 0, 0, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "troll dungeon" then                         %if outside entrance
		Pic.Draw (trolldungeon_pic, 0, 0, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		if troll -> alive then         %if troll is alive draw hitpoints box
		troll -> setLvlClr(totalLvl)
		if xm > troll -> xPos - 1 and xm < troll -> xPos + 32 and ym > troll -> yPos - 1 and ym < troll -> yPos + 41 then
				Font.Draw ("Troll [Level " + intstr (troll -> totalLvl) + "]", troll -> xPos, troll -> yPos + 67, font2, troll -> lvlClr)
		end if
		Pic.Draw (troll -> dirImages (troll -> dir), troll -> xPos, troll -> yPos, picMerge)
		if abs ((troll -> xPos + 10) - x + 15) < 200 and abs ((troll -> yPos + 15) - y + 15) < 200 and troll -> hp > 0 then
				drawfillbox (7, barheight - 3, 123, barheight + 53, troll -> lvlClr)
				drawfillbox (10, barheight, 120, barheight + 50, black)
				drawfillbox (115 - round ((troll -> hp / troll -> maxHp) * 100), barheight + 5, 115, barheight + 15, red)
				Font.Draw ("Troll", 15, barheight + 35, font2, troll -> lvlClr)
				Font.Draw ("Hitpoints: " + intstr (round ((troll -> hp / troll -> maxHp) * 100)) + "%", 15, barheight + 20, font2, troll -> lvlClr)
		end if
		end if
		if troll -> alive then
		if xm > troll -> xPos and xm < troll -> xPos + 15 and ym > troll -> yPos and ym < troll -> yPos + 15 then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
		end if
		end if
    elsif scene = "outside entrance" then             %if outside entrance
		Pic.Draw (outside_entrancepic, 0, 0, picCopy)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "shop" then             %if shop
		Pic.Draw (stoneback, 0, 0, picMerge)
		Pic.Draw (stoneback_wall, 0, 0, picMerge)
		Pic.Draw (shop_pic, 500, 200, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "in shop" then         %if in shop
		Pic.Draw (stoneback_grey, 0, 0, picMerge)
		if shopscreen = 1 then
			Pic.Draw (healthpack, 115, 100, picCopy)
			Pic.Draw (buybutton, 191, 94, picMerge)
			Pic.Draw (arrows, 280, 10, picMerge)
			Pic.Draw (buybutton, 455, 96, picMerge)
			Pic.Draw (leavebutton, 719, 1, picMerge)
			Pic.Draw (morebutton, 719, 47, picMerge)
			Pic.Draw (buybutton, 160, 343, picMerge)             %battleaxe
			Font.Draw ("Battleaxe: " + intstr(battleAxe -> cost) + " gold  Two-Handed sword: " + intstr(twoHanded -> cost) + " gold    Bow: " + intstr(bow -> cost) + " gold", 5, 550, font1, black)
			Font.Draw ("Healthpack: 100 gold           Arrows: 50 gold/15", 5, 290, font1, black)
		if battleAxe -> obtained then             %if battleaxe has been purchased
				Pic.Draw (battleAxe -> boughtpic, 119, 371, picMerge)
				Font.Draw ("Purchased", 120, 320, font1, brightgreen)
		else
				Pic.Draw (battleAxe -> pic, 119, 371, picMerge)
		end if
		Pic.Draw (buybutton, 323, 343, picMerge)             %2h
		if twoHanded -> obtained then             %if 2h has been purchased
				Pic.Draw (twoHanded -> boughtpic, 292, 348, picMerge)
				Font.Draw ("Purchased", 293, 320, font1, brightgreen)
		else
				Pic.Draw (twoHanded -> pic, 292, 348, picMerge)
			end if
		Pic.Draw (buybutton, 528, 343, picMerge)             %bow
		if bow -> obtained then             %if 2h has been purchased
				Pic.Draw (bow_bought, 452, 378, picMerge)
				Font.Draw ("Purchased", 528, 320, font1, brightgreen)
		else
				Pic.Draw (bowpic, 452, 378, picMerge)
		end if
		elsif shopscreen = 2 then
		Font.Draw ("Platebody: 750 gold      Platelegs: 500 gold     Fullhelm: 400 gold", 50, 570, font1, black)
		if platebody then
				Pic.Draw (platebody_bought, 50, 300, picMerge)
				Font.Draw ("Purchased", 50, 230, font1, brightgreen)
		else
				Pic.Draw (platebodypic, 50, 300, picMerge)
		end if
		Pic.Draw (buybutton, 150, 250, picMerge)
		if platelegs then
				Pic.Draw (platelegs_bought, 350, 300, picMerge)
				Font.Draw ("Purchased", 350, 230, font1, brightgreen)
		else
				Pic.Draw (platelegspic, 350, 300, picMerge)
		end if
		Pic.Draw (buybutton, 400, 250, picMerge)
		if fullhelm then
				Pic.Draw (fullhelm_bought, 600, 300, picMerge)
				Font.Draw ("Purchased", 650, 230, font1, brightgreen)
		else
				Pic.Draw (fullhelmpic, 600, 300, picMerge)
		end if
		Pic.Draw (buybutton, 650, 250, picMerge)
		Pic.Draw (backbutton, 1, 1, picMerge)
		end if
    elsif scene = "west hall" then         %if in second hall segment west of castle entrance
		Pic.Draw (stoneback, 0, 0, picMerge)
		Pic.Draw (westhall, 0, 0, picMerge)
		if xm > 117 and xm < 141 and ym > 354 and ym < 380 then
			if key_west_hall then
				Pic.Draw (cursor_kwh_true, xm - 18, ym - 18, picMerge)
			else
				Pic.Draw (cursor_kwh_false, xm - 18, ym - 18, picMerge)
			end if
		else
			Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		end if
    elsif scene = "west river" then         %if at west river
		Pic.Draw (west_river_pic, 0, 0, picMerge)
		if ~ key_west_hall then         %if key has not been taken
		Pic.Draw (key_wh2, 490, 35, picMerge)
		end if
		if skeleton -> alive then         %if skeleton is alive draw hitpoints box
			skeleton -> setLvlClr(totalLvl)
		if xm > skeleton -> xPos - 1 and xm < skeleton -> xPos + 32 and ym > skeleton -> yPos - 1 and ym < skeleton -> yPos + 41 then
				Font.Draw ("Skeleton [Level " + intstr (skeleton -> totalLvl) + "]", skeleton -> xPos, skeleton -> yPos + 41, font2, skeleton -> lvlClr)
		end if
		Pic.Draw (skeleton -> dirImages (skeleton -> dir), skeleton -> xPos, skeleton -> yPos, picMerge)
		if abs ((skeleton -> xPos + 10) - x + 15) < 200 and abs ((skeleton -> yPos + 15) - y + 15) < 200 and skeleton -> hp > 0 then
				drawfillbox (7, barheight - 3, 123, barheight + 53, skeleton -> lvlClr)
				drawfillbox (10, barheight, 120, barheight + 50, black)
				drawfillbox (115 - round ((skeleton -> hp / 30) * 100), barheight + 5, 115, barheight + 15, red)
				Font.Draw ("Skeleton", 15, barheight + 35, font2, skeleton -> lvlClr)
				Font.Draw ("Hitpoints: " + intstr (round ((skeleton -> hp / 30) * 100)) + "%", 15, barheight + 20, font2, skeleton -> lvlClr)
		end if
		end if
		if ~ key_west_hall then        %if key has not been taken
		if xm > xkey_west_hall - 5 and xm < xkey_west_hall + 26 and ym > ykey_west_hall - 5 and ym < ykey_west_hall + 26 then
				Pic.Draw (cursor_item, xm - 18, ym - 18, picMerge)
				Font.Draw ("key", xm, ym + 20, font2, brightblue)
		else
				Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		end if
		end if
		if skeleton -> alive then
		if xm > skeleton -> xPos and xm < skeleton -> xPos + 15 and ym > skeleton -> yPos and ym < skeleton -> yPos + 15 then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
		else
				Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		end if
		else
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		end if
    elsif scene = "cemetery" then
		Pic.Draw (cemetery_pic, 0, 0, picMerge)
		if ghost -> alive then         %if ghost is alive then draw hitpoints box
			ghost -> setLvlClr(totalLvl)
		if xm > ghost -> xPos - 1 and xm < ghost -> xPos + 32 and ym > ghost -> xPos - 1 and ym < ghost -> xPos + 41 then
				Font.Draw ("Ghost [Level " + intstr (ghost -> totalLvl) + "]", ghost -> xPos, ghost -> yPos + 41, font2, ghost -> lvlClr)
		end if
		Pic.DrawSpecial (ghost -> dirImages (ghost -> dir), ghost -> xPos, ghost -> yPos, picMerge, picBlend, 1)
		if abs ((ghost -> xPos + 10) - x + 15) < 200 and abs ((ghost -> yPos + 15) - y + 15) < 200 and ghost -> hp > 0 then
				drawfillbox (7, barheight - 3, 123, barheight + 53, ghost -> lvlClr)
				drawfillbox (10, barheight, 120, barheight + 50, black)
				drawfillbox (115 - round ((ghost -> hp / 70) * 100), barheight + 5, 115, barheight + 15, red)
				Font.Draw ("Ghost", 15, barheight + 35, font2, ghost -> lvlClr)
				Font.Draw ("Hitpoints: " + intstr (round ((ghost -> hp / 70) * 100)) + "%", 15, barheight + 20, font2, ghost -> lvlClr)
		end if
		end if
		if xm > 175 and xm < 250 and ym > 200 and ym < 265 then
			Pic.Draw (cursor_down, xm - 18, ym - 18, picMerge)
		else
			Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		end if
		if ghost -> alive then
			if xm > ghost -> xPos and xm < ghost -> xPos + 15 and ym > ghost -> yPos and ym < ghost -> yPos + 15 then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
			end if
		end if
    elsif scene = "crypt" then
		if ~ rope then
			Pic.Draw (crypt_pic, 0, 0, picCopy)
		else
			Pic.Draw (crypt_rope_pic, 0, 0, picCopy)
		end if
		if zombie -> alive then
			zombie -> setLvlClr(totalLvl)
		if xm > zombie -> xPos - 1 and xm < zombie -> xPos + 32 and ym > zombie -> yPos - 1 and ym < zombie -> yPos + 41 then
				Font.Draw ("Zombie [Level " + intstr (zombie -> totalLvl) + "]", zombie -> xPos, zombie -> yPos + 41, font2, zombie -> lvlClr)
		end if
			Pic.DrawSpecial (darkoverlay, x - 790, y - 590, picMerge, picBlend, 1)
			Pic.Draw (zombie -> dirImages (zombie -> dir), zombie -> xPos, zombie -> yPos, picMerge)
		if abs ((zombie -> xPos + 10) - x + 15) < 200 and abs ((zombie -> yPos + 15) - y + 15) < 200 and zombie -> hp > 0 then
				drawfillbox (7, barheight - 3, 123, barheight + 53, zombie -> lvlClr)
				drawfillbox (10, barheight, 120, barheight + 50, black)
				drawfillbox (115 - round ((zombie -> hp / 120) * 100), barheight + 5, 115, barheight + 15, red)
				Font.Draw ("Zombie", 15, barheight + 35, font2, zombie -> lvlClr)
				Font.Draw ("Hitpoints: " + intstr (round ((zombie -> hp / 120) * 100)) + "%", 15, barheight + 20, font2, zombie -> lvlClr)
		end if
		else
		Pic.DrawSpecial (darkoverlay, x - 790, y - 590, picMerge, picBlend, 1)
		end if
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		if rope then
			if xm > 150 and xm < 180 and ym > 250 and ym < 310 then
				Pic.Draw (cursor_up, xm - 18, ym - 18, picMerge)
			end if
		else
			if xm > 517 and xm < 560 and ym > 190 and ym < 230 then
				Pic.Draw (cursor_item, xm - 18, ym - 18, picMerge)
			end if
		end if
		if zombie -> alive then
			if xm > zombie -> xPos and xm < zombie -> xPos + 15 and ym > zombie -> yPos and ym < zombie -> yPos + 15 then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
			end if
		end if
    elsif scene = "dark forest" then
		Pic.Draw (dark_forest_pic, 0, 0, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "witch house" then
		Pic.Draw (witch_house_pic, 0, 0, picMerge)
		if ratalive then
			Pic.Draw (ratpic (rrat), xrat, yrat, picMerge)
		end if
		Pic.Draw (catpic (rcat), xcat, ycat, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "east of 'west river'" then         %if east of 'west river'
		Pic.Draw (east_of_westriver_pic, 0, 0, picMerge)
		if goblin -> alive then
			goblin -> setLvlClr(totalLvl)
		if xm > goblin -> xPos - 1 and xm < goblin -> xPos + 32 and ym > goblin -> yPos - 1 and ym < goblin -> yPos + 41 then
				Font.Draw ("Goblin [Level " + intstr (goblin -> totalLvl) + "]", goblin -> xPos, goblin -> yPos + 30, font2, goblin -> lvlClr)
		end if
		Pic.Draw (goblin -> dirImages(goblin -> dir), goblin -> xPos, goblin -> yPos, picMerge)
		if abs ((goblin -> xPos + 10) - x + 15) < 200 and abs ((goblin -> yPos + 15) - y + 15) < 200 and goblin -> hp > 0 then
				drawfillbox (7, barheight - 3, 123, barheight + 53, goblin -> lvlClr)
				drawfillbox (10, barheight, 120, barheight + 50, black)
				drawfillbox (115 - round ((goblin -> hp / 10) * 100), barheight + 5, 115, barheight + 15, red)
				Font.Draw ("Goblin", 15, barheight + 35, font2, goblin -> lvlClr)
				Font.Draw ("Hitpoints: " + intstr (round ((goblin -> hp / 10) * 100)) + "%", 15, barheight + 20, font2, goblin -> lvlClr)
		end if
		end if
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		if goblin -> alive then
		if xm > goblin -> xPos and xm < goblin -> xPos + 15 and ym > goblin -> yPos and ym < goblin -> yPos + 15 then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
		end if
		end if
    elsif scene = "west river-north corner" then
		Pic.Draw (westriver_northcorner_pic, 0, 0, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "mountains" then
		Pic.Draw (mountains_pic, 0, 0, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
    elsif scene = "cottage" then
		Pic.Draw (cottage_pic, 0, 0, picMerge)
		if x > 505 and y > 53 and y < 180 then
			Pic.Draw (in_cottage_pic, 519, 58, picMerge)
		end if
		if ~ cottagekey then
			Pic.Draw (cottagekey_pic, xcottagekey, ycottagekey, picMerge)
		end if
		drawoval (xsplash1, ysplash1, round (splashradius1), round (splashradius1), 55)
		drawoval (xsplash2, ysplash2, round (splashradius2), round (splashradius2), 55)
		drawoval (xsplash3, ysplash3, round (splashradius3), round (splashradius3), 55)
		if peasant -> xPos > 505 and peasant -> yPos > 53 and peasant -> yPos < 180 then
			if x > 505 and y > 53 and y < 180 then
				if xm > peasant -> xPos - 1 and xm < peasant -> xPos + 21 and ym > peasant -> yPos - 1 and ym < peasant -> yPos + 30 then
					Font.Draw ("Peasant", peasant -> xPos, peasant -> yPos + 30, font2, white)
				end if
				Pic.Draw (peasant -> dirImages (peasant -> dir), peasant -> xPos, peasant -> yPos, picMerge)
			end if
		else
			if xm > peasant -> xPos - 1 and xm < peasant -> xPos + 21 and ym > peasant -> yPos - 1 and ym < peasant -> yPos + 30 then
				Font.Draw ("Peasant", peasant -> xPos, peasant -> yPos + 30, font2, white)
			end if
			Pic.Draw (peasant -> dirImages (peasant -> dir), peasant -> xPos, peasant -> yPos, picMerge)
		end if
		if abs ((peasant -> xPos + 10) - x + 15) < 200 and abs ((peasant -> yPos + 15) - y + 15) < 200 then
		drawfillbox (7, barheight - 3, 123, barheight + 53, grey)             %barheight = 540
		drawfillbox (10, barheight, 120, barheight + 50, black)
		Font.Draw ("Peasant", 15, barheight + 35, font2, grey)
		if playerincottage = peasant -> inCottage then
				if xm > 13 and xm < 117 and ym > barheight + 3 and ym < barheight + 32 then
				drawfillbox (13, barheight + 3, 117, barheight + 32, brightgreen)
				Font.Draw ("Talk", 15, barheight + 5, font2, green)
				if left = 1 then
						talk
				end if
				else
				drawfillbox (13, barheight + 3, 117, barheight + 32, grey)
				Font.Draw ("Talk", 15, barheight + 5, font2, black)
				end if
		end if
		end if
		splashradius1 := splashradius1 + 0.1
		splashradius2 := splashradius2 + 0.1
		splashradius3 := splashradius3 + 0.1
		if splashradius1 > 5 then
			splashradius1 := 1
			xsplash1 := Rand.Int (500, 560)
			ysplash1 := Rand.Int (315, 370)
		end if
		if splashradius2 > 7 then
			splashradius2 := 1
			xsplash2 := Rand.Int (500, 560)
			ysplash2 := Rand.Int (315, 370)
		end if
		if splashradius3 > 10 then
			splashradius3 := 1
			xsplash3 := Rand.Int (500, 560)
			ysplash3 := Rand.Int (315, 370)
		end if
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		if xm > xcottagekey - 5 and xm < xcottagekey + 26 and ym > ycottagekey - 5 and ym < ycottagekey + 26 and ~ cottagekey then
			Pic.Draw (cursor_item, xm - 18, ym - 18, picMerge)
			Font.Draw ("key", xm, ym + 20, font2, brightblue)
		end if
		if ym > 75 and ym < 112 and xm > 495 and xm < 515 then
			if cottagekey then
				Pic.Draw (cursor_ck_true, xm - 18, ym - 18, picMerge)
			else
				Pic.Draw (cursor_ck_false, xm - 18, ym - 18, picMerge)
			end if
		end if
    elsif scene = "lair entrance" then
		Pic.Draw (lair_entrance_pic, 0, 0, picMerge)
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		if xm > 340 and xm < 460 and ym > 410 and ym < 450 then
			Pic.Draw (cursor_down, xm - 18, ym - 18, picMerge)
		end if
    elsif scene = "dragon's lair" then
		if ~ dragonhead1alive and ~ dragonhead2alive and ~ dragonhead3alive then
		Pic.Draw (dragondead, 0, 0, picMerge)
		if ~ grail then
				Pic.Draw (grailpic, 370, 300, picMerge)
		else
				Pic.Draw (grailinvpic, 285, 636, picMerge)
		end if
		if ~ slaycutsceneviewed then
				Pic.Draw (topbar, 0, 600, picCopy)
				Font.Draw (" " + intstr (gold), 45, 640, font2, black)
				Font.Draw ("Def.", 145, 645, font4, black)
				Font.Draw (intstr (defence), 150, 636, font4, black)
				Font.Draw (" Lvl.: " + intstr (archerylvl) + ", Exp.: " + intstr (archeryxp), 591, 640, font2, black)
				Font.Draw (" Lvl.: " + intstr (combatlvl) + ", Exp.: " + intstr (combatxp), 590, 614, font2, black)
				Font.Draw (intstr (hitpoints) + "/100", 370, 640, font2, black)
				drawfillbox (524 - hitpoints, 640, 524, 650, red)
				Font.Draw (text, 14, 614, font2, black)
				Font.Draw ("x " + intstr (healthpacks), 169, 636, font4, black)
				Font.Draw (mapscale + "%", 545, 535, font2, blue)
				if key_west_hall then                 %if the player has the key to the door in the 2nd west hall
				Pic.Draw (key_wh2, 97, 636, picMerge)
				end if
				if cottagekey then
					Pic.Draw (cottagekey_pic, 119, 635, picMerge)
				end if
				if battleAxe -> obtained then
					Pic.Draw (battleAxe -> invpic, 213, 635, picMerge)
				end if
				if twoHanded -> obtained then
					Pic.Draw (twoHanded -> invpic, 235, 635, picMerge)
				end if
				if bow -> obtained then
					Pic.Draw (bow -> invpic, 258, 635, picMerge)
				end if
				if grail then
					Pic.Draw (grailinvpic, 285, 636, picMerge)
				end if
				if weapon = kingsSword then
					drawbox (190, 634, 212, 656, red)
				elsif weapon = battleAxe then
					drawbox (212, 634, 234, 656, red)
				elsif weapon = twoHanded then
					drawbox (234, 634, 257, 656, red)
				elsif weapon = bow then
					drawbox (257, 634, 280, 656, red)
				end if
				if grail then
					Pic.Draw (grailinvpic, 285, 636, picMerge)
				end if
				View.Update
				setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
				Pic.DrawSpecial (dragon_slain, 0, 0, picMerge, picFadeIn, 1000)
				delay (3000)
				Pic.Draw (dragon_slain, 0, 0, picMerge)
				Pic.DrawSpecial (dragondead, 0, 0, picMerge, picFadeIn, 1000)
				setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
				slaycutsceneviewed := true
		end if
		else
		Pic.Draw (dragons_lair_pic, 0, 0, picMerge)
		end if
		Pic.Draw (cursor_moveto, xm - 18, ym - 18, picMerge)
		if xm > 340 and xm < 460 and ym < 50 then
			Pic.Draw (cursor_up, xm - 18, ym - 18, picMerge)
		end if
		if xm > 180 and xm < 220 and ym > 500 and ym < 550 then
			if dragonhead1alive then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
			end if
		elsif xm > 380 and xm < 420 and ym > 450 and ym < 500 then
			if dragonhead2alive then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
			end if
		elsif xm > 580 and xm < 620 and ym > 500 and ym < 550 then
			if dragonhead3alive then
				Pic.Draw (cursor_attack, xm - 18, ym - 18, picMerge)
			end if
		end if
    end if
    if scene ~= "in shop" then         %if the character is not in the shop then
		movement         %run character movement input manipulation
    end if
    %draw chat window
    if lowerchatwindow and ychat > 0 then
		ychat := ychat - 5
    elsif ychat = 0 then
		lowerchatwindow := false
    end if
    if raisechatwindow and ychat < 101 then
		ychat := ychat + 5
    elsif ychat > 100 then
		raisechatwindow := false
    end if
    Pic.DrawSpecial (chat_window_pic, 215, 505 + ychat, picMerge, picBlend, 1)
    if xm > 780 and xm < 800 and ym > 580 and ym < 600 then
		drawline (790, 585, 790, 595, brightgreen)         %vertical
		if (ychat > 100 or lowerchatwindow) and ~ raisechatwindow then
		%down arrow
		drawline (787, 590, 790, 585, brightgreen)             %topleft to bottomright
		drawline (793, 590, 790, 585, brightgreen)             %topright to bottomleft
		if left = 1 then
				lowerchatwindow := true
		end if
		elsif ((ychat >= 0 and ychat < 101) or raisechatwindow) and ~ lowerchatwindow then
			%up arrow
			drawline (790, 595, 793, 590, brightgreen)             %topleft to bottomright
			drawline (790, 595, 787, 590, brightgreen)             %topright to bottomleft
		if left = 1 then
				raisechatwindow := true
		end if
		end if
    else
		drawline (790, 585, 790, 595, black)         %vertical
		if (ychat > 100 or lowerchatwindow) and ~ raisechatwindow then
			%down arrow
			drawline (787, 590, 790, 585, black)             %topleft to bottomright
			drawline (793, 590, 790, 585, black)             %topright to bottomleft
		elsif ((ychat >= 0 and ychat < 101) or raisechatwindow) and ~ lowerchatwindow then
			%up arrow
			drawline (790, 595, 793, 590, black)             %topleft to bottomright
			drawline (790, 595, 787, 590, black)             %topright to bottomleft
		end if
    end if
    Font.Draw ("Chat history:", 221, 588 + ychat, font4, brightred)
    if editmodeenabled then
		chatentry (1) := "x: " + intstr (x) + "  y: " + intstr (y) + "  picnum: " + intstr (picnum) + "  last dir.: " + intstr(ord(charlastdirection))
		chatentry (2) := "xm: " + intstr (xm) + "  ym: " + intstr (ym) + "  left btn: " + intstr (left) + "  right btn: " + intstr (right)
		if movecharacter then
			chatentry (3) := "goto: " + goto + "  scene: " + scene + "  movecharacter: true"
		else
		chatentry (3) := "goto: " + goto + "  scene: " + scene + "  movecharacter: false"
		end if
		if goblin -> talk then
		chatentry (4) := "goblintalk: true" + "  goblintalkcounter: " + intstr (goblin -> talkCounter) + "  goblintalkcountergoal: " + intstr (goblin -> talkCounterGoal)
		else
		chatentry (4) := "goblintalk: false" + "  goblintalkcounter: " + intstr (goblin -> talkCounter) + "  goblintalkcountergoal: " + intstr (goblin -> talkCounterGoal)
		end if
		if sfx_on and playmusic_on then
		chatentry (5) := "sfx_on: true" + "playmusic_on: true"
		elsif ~ sfx_on and playmusic_on then
		chatentry (5) := "sfx_on: false" + "playmusic_on: true"
		elsif sfx_on and ~ playmusic_on then
		chatentry (5) := "sfx_on: true" + "playmusic_on: false"
		elsif ~ sfx_on and ~ playmusic_on then
		chatentry (5) := "sfx_on: false" + "playmusic_on: false"
		end if
    end if
    for chatnum : 1 .. 5
		Font.Draw (chatentry (chatnum), 225, 490 + (100 - chatnum * 15) + ychat, font7, yellow)
    end for
    %end of draw chat window
    archerylvl := ((round ((sqrt (archeryxp)) div 3)) + 1)
    combatlvl := ((round ((sqrt (combatxp)) div 3)) + 1)
    Pic.Draw (topbar, 0, 600, picCopy)
    Font.Draw (" " + intstr (gold), 45, 640, font2, black)
    Font.Draw ("Def.", 145, 645, font4, black)
    Font.Draw (intstr (defence), 150, 636, font4, black)
    Font.Draw (" Lvl.: " + intstr (archerylvl) + ", Exp.: " + intstr (archeryxp), 591, 640, font2, black)
    Font.Draw (" Lvl.: " + intstr (combatlvl) + ", Exp.: " + intstr (combatxp), 590, 614, font2, black)
    Font.Draw (intstr (hitpoints) + "/100", 370, 640, font2, black)
    drawfillbox (524 - hitpoints, 640, 524, 650, red)
    Font.Draw (text, 14, 614, font2, black)
    Font.Draw ("x " + intstr (healthpacks), 169, 636, font4, black)
    if key_west_hall then         %if the player has the key to the door in the 2nd west hall
		Pic.Draw (key_wh2, 97, 636, picMerge)
    end if
    if cottagekey then
		Pic.Draw (cottagekey_pic, 119, 635, picMerge)
    end if
    if battleAxe -> obtained then
		Pic.Draw (battleAxe -> invpic, 213, 635, picMerge)
    end if
    if twoHanded -> obtained then
		Pic.Draw (twoHanded -> invpic, 235, 635, picMerge)
    end if
    if bow -> obtained then
		Pic.Draw (bow -> invpic, 258, 635, picMerge)
    end if
    if grail then
		Pic.Draw (grailinvpic, 285, 636, picMerge)
    end if
    if weapon = kingsSword then
		drawbox (190, 634, 212, 656, red)
    elsif weapon = battleAxe then
		drawbox (212, 634, 234, 656, red)
    elsif weapon = twoHanded then
		drawbox (234, 634, 257, 656, red)
    elsif weapon = bow then
		drawbox (257, 634, 280, 656, red)
    end if
    Input.KeyDown (hotkey)
    if (xm > 506 and xm < 531 and ym > 608 and ym < 632 and left = 1) or hotkey (KEY_ESC) or returntomenu then         %if quit selected
		Pic.Draw (info, 100, 100, picMerge)
		returntomenu := false
		destination := false
		loop
		drawfillbox (150, 150, 650, 450, black)             %black background
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)
		left := button mod 10                   % left = 0 or 1
		middle := (button - left) mod 100             % middle = 0 or 10
		right := button - middle - left             % right = 0 or 100
		if xm > 160 and xm < 640 and ym > 410 and ym < 440 then             %quit to main menu
				if ingamemenubutton ~= "quit" then
				ingamemenubutton := "quit"
				drawfillbox (160, 410, 640, 440, darkgrey)             %quit to main menu
					Font.Draw ("Quit to Main Menu", 165, 415, font2, brightred)
					drawfillbox (160, 370, 640, 400, grey)             %save
					Font.Draw ("Save Game", 165, 375, font2, black)
					drawfillbox (160, 330, 640, 360, grey)             %manual
					Font.Draw ("User Manual", 165, 335, font2, black)
					drawfillbox (160, 290, 640, 320, grey)             %options
					Font.Draw ("Options", 165, 295, font2, black)
					drawfillbox (160, 250, 640, 280, grey)             %return
					Font.Draw ("Return to Game", 165, 255, font2, black)
					View.Update
				if swordon then
						fork swords
						swordon := false
				end if
				end if
				if left = 1 then
				loop
						buttonchoose ("multibutton")
						mousewhere (xm, ym, button)
						left := button mod 10                         % left = 0 or 1
						middle := (button - left) mod 100                         % middle = 0 or 10
						right := button - middle - left                         % right = 0 or 100
						drawfillbox (150, 150, 650, 450, black)                         %black background
						Font.Draw ("Are you sure you want to quit?", 160, 400, font2, brightred)
						if xm > 160 and xm < 640 and ym > 280 and ym < 310 then                         %yes
							drawfillbox (160, 280, 640, 310, darkgrey)                             %yes
							Font.Draw ("Yes", 165, 285, font2, brightblue)
							drawfillbox (160, 240, 640, 270, grey)                             %no
							Font.Draw ("No", 165, 245, font2, black)
							View.Update
						if swordon then
								fork swords
								swordon := false
						end if
						if left = 1 then
								exitgame := true
								Music.PlayFileStop
								stopmusic := true
								return
						end if
						elsif xm > 160 and xm < 640 and ym > 240 and ym < 270 then                         %no
							drawfillbox (160, 280, 640, 310, grey)                             %yes
							Font.Draw ("Yes", 165, 285, font2, black)
							drawfillbox (160, 240, 640, 270, darkgrey)                             %no
							Font.Draw ("No", 165, 245, font2, brightblue)
							View.Update
						if swordon then
								fork swords
								swordon := false
						end if
						if left = 1 then
								exit
						end if
						else
							drawfillbox (160, 280, 640, 310, grey)                             %yes
							Font.Draw ("Yes", 165, 285, font2, black)
							drawfillbox (160, 240, 640, 270, grey)                             %no
							Font.Draw ("No", 165, 245, font2, black)
							View.Update
							swordon := true
						end if
				end loop
				end if
		elsif xm > 160 and xm < 640 and ym > 370 and ym < 400 then              %save
				if ingamemenubutton ~= "save" then
				ingamemenubutton := "save"
				drawfillbox (160, 410, 640, 440, grey)             %quit to main menu
					Font.Draw ("Quit to Main Menu", 165, 415, font2, black)
					drawfillbox (160, 370, 640, 400, darkgrey)             %save
					Font.Draw ("Save Game", 165, 375, font2, brightblue)
					drawfillbox (160, 330, 640, 360, grey)             %manual
					Font.Draw ("User Manual", 165, 335, font2, black)
					drawfillbox (160, 290, 640, 320, grey)             %options
					Font.Draw ("Options", 165, 295, font2, black)
					drawfillbox (160, 250, 640, 280, grey)             %return
					Font.Draw ("Return to Game", 165, 255, font2, black)
					View.Update
				if swordon then
						fork swords
						swordon := false
				end if
				end if
				if left = 1 then
				loop
						buttonchoose ("multibutton")
						mousewhere (xm, ym, button)
						left := button mod 10                         % left = 0 or 1
						middle := (button - left) mod 100                         % middle = 0 or 10
						right := button - middle - left                         % right = 0 or 100
						drawfillbox (150, 150, 650, 450, black)                         %black background
						Font.Draw ("Saving your current game will overwrite the previously saved game!", 160, 400, font2, brightred)
						Font.Draw ("Are you sure you want to overwrite the file?", 160, 370, font2, brightred)
						if xm > 160 and xm < 640 and ym > 280 and ym < 310 then                         %yes
							drawfillbox (160, 280, 640, 310, darkgrey)                             %yes
							Font.Draw ("Yes, save my game", 165, 285, font2, brightblue)
							drawfillbox (160, 240, 640, 270, grey)                             %no
							Font.Draw ("Don't save", 165, 245, font2, black)
							View.Update
						if swordon then
								fork swords
								swordon := false
						end if
						if left = 1 then
								returntomenu := true
								save
								for : 1 .. 3
									Font.Draw ("Saving", 160, 340, font2, brightgreen)
									View.Update
									Time.Delay (50)
									Font.Draw ("Saving", 160, 340, font2, black)
									Font.Draw ("Saving.", 160, 340, font2, brightgreen)
									View.Update
									Time.Delay (50)
									Font.Draw ("Saving.", 160, 340, font2, black)
									Font.Draw ("Saving..", 160, 340, font2, brightgreen)
									View.Update
									Time.Delay (50)
									Font.Draw ("Saving..", 160, 340, font2, black)
									Font.Draw ("Saving...", 160, 340, font2, brightgreen)
									View.Update
									Time.Delay (50)
									Font.Draw ("Saving...", 160, 340, font2, black)
									View.Update
									Time.Delay (50)
								end for
								exit
						end if
						elsif xm > 160 and xm < 640 and ym > 240 and ym < 270 then                         %no
							drawfillbox (160, 280, 640, 310, grey)                             %yes
							Font.Draw ("Yes, save my game", 165, 285, font2, black)
							drawfillbox (160, 240, 640, 270, darkgrey)                             %no
							Font.Draw ("Don't save", 165, 245, font2, brightblue)
							View.Update
						if swordon then
								fork swords
								swordon := false
						end if
						if left = 1 then
								for : 1 .. 3
									Font.Draw ("Cancelling", 160, 340, font2, yellow)
									View.Update
									Time.Delay (50)
									Font.Draw ("Cancelling", 160, 340, font2, black)
									Font.Draw ("Cancelling.", 160, 340, font2, yellow)
									View.Update
									Time.Delay (50)
									Font.Draw ("Cancelling.", 160, 340, font2, black)
									Font.Draw ("Cancelling..", 160, 340, font2, yellow)
									View.Update
									Time.Delay (50)
									Font.Draw ("Cancelling..", 160, 340, font2, black)
									Font.Draw ("Cancelling...", 160, 340, font2, yellow)
									View.Update
									Time.Delay (50)
									Font.Draw ("Cancelling...", 160, 340, font2, black)
									View.Update
									Time.Delay (50)
								end for
								returntomenu := true
								exit
						end if
						else
							drawfillbox (160, 280, 640, 310, grey)                             %yes
							Font.Draw ("Yes, save my game", 165, 285, font2, black)
							drawfillbox (160, 240, 640, 270, grey)                             %no
							Font.Draw ("Don't save", 165, 245, font2, black)
							View.Update
							swordon := true
						end if
				end loop
				end if
		elsif xm > 160 and xm < 640 and ym > 330 and ym < 360 then              %manual
				if ingamemenubutton ~= "manual" then
					ingamemenubutton := "manual"
					drawfillbox (160, 410, 640, 440, grey)            %quit to main menu
					Font.Draw ("Quit to Main Menu", 165, 415, font2, black)
					drawfillbox (160, 370, 640, 400, grey)             %save
					Font.Draw ("Save Game", 165, 375, font2, black)
					drawfillbox (160, 330, 640, 360, darkgrey)             %manual
					Font.Draw ("User Manual", 165, 335, font2, yellow)
					drawfillbox (160, 290, 640, 320, grey)             %options
					Font.Draw ("Options", 165, 295, font2, black)
					drawfillbox (160, 250, 640, 280, grey)             %return
					Font.Draw ("Return to Game", 165, 255, font2, black)
					View.Update
				if swordon then
						fork swords
						swordon := false
				end if
				end if
				if left = 1 then
					returntomenu := true
					usermanual
					exit
				end if
		elsif xm > 160 and xm < 640 and ym > 290 and ym < 320 then                  %options
				if ingamemenubutton ~= "options" then
					ingamemenubutton := "options"
					drawfillbox (160, 410, 640, 440, grey)             %quit to main menu
					Font.Draw ("Quit to Main Menu", 165, 415, font2, black)
					drawfillbox (160, 370, 640, 400, grey)             %save
					Font.Draw ("Save Game", 165, 375, font2, black)
					drawfillbox (160, 330, 640, 360, grey)             %manual
					Font.Draw ("User Manual", 165, 335, font2, black)
					drawfillbox (160, 290, 640, 320, darkgrey)             %options
					Font.Draw ("Options", 165, 295, font2, purple)
					drawfillbox (160, 250, 640, 280, grey)             %return
					Font.Draw ("Return to Game", 165, 255, font2, black)
					View.Update
				if swordon then
						fork swords
						swordon := false
				end if
				end if
				if left = 1 then
					options
					returntomenu := true
				end if
		elsif xm > 160 and xm < 640 and ym > 250 and ym < 280 then              %return to game
				if ingamemenubutton ~= "return" then
					ingamemenubutton := "return"
					drawfillbox (160, 410, 640, 440, grey)             %quit to main menu
					Font.Draw ("Quit to Main Menu", 165, 415, font2, black)
					drawfillbox (160, 370, 640, 400, grey)             %save
					Font.Draw ("Save Game", 165, 375, font2, black)
					drawfillbox (160, 330, 640, 360, grey)             %manual
					Font.Draw ("User Manual", 165, 335, font2, black)
					drawfillbox (160, 290, 640, 320, grey)             %options
					Font.Draw ("Options", 165, 295, font2, black)
					drawfillbox (160, 250, 640, 280, darkgrey)             %return
					Font.Draw ("Return to Game", 165, 255, font2, brightgreen)
					View.Update
				if swordon then
						fork swords
						swordon := false
				end if
				end if
				if left = 1 then
					exit
				end if
		else
				if ingamemenubutton ~= "none" then
					ingamemenubutton := "none"
					drawfillbox (160, 410, 640, 440, grey)             %quit to main menu
					Font.Draw ("Quit to Main Menu", 165, 415, font2, black)
					drawfillbox (160, 370, 640, 400, grey)             %save
					Font.Draw ("Save Game", 165, 375, font2, black)
					drawfillbox (160, 330, 640, 360, grey)             %manual
					Font.Draw ("User Manual", 165, 335, font2, black)
					drawfillbox (160, 290, 640, 320, grey)             %options
					Font.Draw ("Options", 165, 295, font2, black)
					drawfillbox (160, 250, 640, 280, grey)             %return
					Font.Draw ("Return to Game", 165, 255, font2, black)
					View.Update
					swordon := true
				end if
		end if
		end loop
    end if
    if grail then
		Pic.Draw (grailinvpic, 285, 636, picMerge)
    end if
    if ym > 600 then
		Pic.Draw (cursor_normal, xm, ym, picMerge)
    end if
    collision (goto)         %run collision detection
    if goto = "shop" then         %if instructed to go to the shop scene then
		return         %return to the main program
    end if
    if autosave then
		if autosavecounter >= autosavefrequency then
		save
		autosavecounter := 1
		else
		autosavecounter := autosavecounter + 1
		end if
    end if
end drawscreen

proc move_actor(actor : pointer to Enemy)
  for : 1 .. 50
    case actor -> dir of
      label ord(Direction.UP): actor -> setYPos(actor -> yPos + 1)
      label ord(Direction.DOWN): actor -> setYPos(actor -> yPos - 1)
      label ord(Direction.LEFT): actor -> setXPos(actor -> xPos - 1)
      label ord(Direction.RIGHT): actor -> setXPos(actor -> xPos + 1)
    end case
    Time.DelaySinceLast (30)
  end for
end move_actor

process move_enemy(enemy : pointer to Enemy)
  if ~ enemy -> move then         %if enemy has not been assigned a movement
    enemy -> setMove(true)
    if enemy -> alive then
      if abs ((enemy -> xPos + enemy -> xRad) - x + 15) >= 200 or abs ((enemy -> yPos + enemy -> yRad) - y + 15) >= 200 then
	      enemy -> setDir(Rand.Int (0, 3))
	      if enemy -> dir = ord(Direction.UP) and enemy -> yPos < 550 then
	        move_actor(enemy)
	      elsif enemy -> dir = ord(Direction.DOWN) and enemy -> yPos > 50 then
	        move_actor(enemy)
	      elsif enemy -> dir = ord(Direction.LEFT) and enemy -> xPos > 50 then
	        move_actor(enemy)
	      elsif enemy -> dir = ord(Direction.RIGHT) and enemy -> xPos < 750 then
	        move_actor(enemy)
	      else
	        Time.DelaySinceLast (1500)
	      end if
      else
        if enemy -> yPos + enemy -> yRad < (y + 15) - 10 then
          enemy -> setDir(ord(Direction.UP))
          enemy -> setYPos(enemy -> yPos + 1)
        end if
        if enemy -> yPos + enemy -> yRad > (y + 15) + 10 then
          enemy -> setDir(ord(Direction.DOWN))
          enemy -> setYPos(enemy -> yPos - 1)
        end if
        if goblin -> xPos + enemy -> xRad < (x + 15) - 10 then
          enemy -> setDir(ord(Direction.RIGHT))
          enemy -> setXPos(enemy -> xPos + 1)
        end if
        if enemy -> xPos + enemy -> xRad > (x + 15) + 10 then
          enemy -> setDir(ord(Direction.LEFT))
          enemy -> setXPos(enemy -> xPos - 1)
        end if
      end if
      enemy -> detectCollision()
    end if
    enemy -> setMove(false)
  end if
end move_enemy

process talk_enemy(enemy : pointer to Enemy)
  if enemy -> alive then
    if enemy -> talk then
      chattext := enemy -> text (Rand.Int (0, 2))
      if chatentry (5) ~= "" and chattext ~= "" then
	for chatnum : 2 .. 5
	  chatentry (chatnum - 1) := chatentry (chatnum)
	end for
	chatentry (5) := chattext
      else
	for chatnum : 1 .. 5
	  if chatentry (chatnum) = "" and chattext ~= "" then
	    chatentry (chatnum) := chattext
	    exit
	  end if
	end for
      end if
      chattext := ""
      enemy -> setTalk(false)
      enemy -> setTalkCounter(0)
    end if
  end if
  enemy -> setTalkCounter(enemy -> talkCounter + 1)
  if enemy -> talkCounter = enemy -> talkCounterGoal then
    enemy -> setTalk(true)
    enemy -> newTalkCounterGoal()
  end if
end talk_enemy

process peasant_proc
    if ~ peasant -> move then         %if peasant has not been assigned a movement
      peasant -> setMove(true)
      peasant -> setDir(Rand.Int(0, 3))
      for : 1 .. 30
	case peasant -> dir of 
	  label ord(Direction.UP): peasant -> setXPos(peasant -> xPos + 1)
	  label ord(Direction.DOWN): peasant -> setXPos(peasant -> xPos - 1)
	  label ord(Direction.LEFT): peasant -> setYPos(peasant -> yPos - 1)
	  label ord(Direction.RIGHT): peasant -> setYPos(peasant -> yPos + 1)
	end case
	if peasant -> yPos > 250 and peasant -> yPos < 280 then
	  peasant -> setYPos(250)
	elsif peasant -> yPos > 490 and peasant -> yPos < 520 then
	  peasant -> setYPos(520)
	elsif peasant -> yPos < 30 and peasant -> xPos > 420 then
	  peasant -> setYPos(30)
	elsif peasant -> yPos > 570 then
	  peasant -> setYPos(570)
	end if
	if peasant -> xPos > 765 then
	  peasant -> setXPos(765)
	end if
	if peasant -> xPos > 360 and peasant -> xPos < 400 and (peasant -> yPos < 75 or (peasant -> yPos > 120 and peasant -> yPos < 490)) then
	  peasant -> setXPos(360)
	elsif peasant -> xPos > 399 and peasant -> xPos < 439 and (peasant -> yPos < 75 or (peasant -> yPos > 120 and peasant -> yPos < 490)) then
	  peasant -> setXPos(439)
	end if
	if (peasant -> yPos > 56 and peasant -> yPos < 76 and peasant -> xPos > 495 and peasant -> xPos < 515) or (peasant -> yPos > 111 and peasant -> yPos < 180 and peasant -> xPos > 495 and peasant -> xPos < 515) then
	  peasant -> setXPos(495)
	end if
	if peasant -> xPos > 495 then
	  if peasant -> yPos > 53 and peasant -> yPos < 58 then                     %if south of cottage
	    peasant -> setYPos(53)
	  elsif peasant -> yPos > 175 and peasant -> yPos < 180 then                     %if north of cottage
	    peasant -> setYPos(180)
	  end if
	end if
	if peasant -> xPos > 495 then
	  if peasant -> yPos > 58 and peasant -> yPos < 67 then                     %if inside at south wall
	    peasant -> setYPos(67)
	  end if
	  if peasant -> yPos > 167 and peasant -> yPos < 175 then                     %if inside at north wall
	    peasant -> setYPos(167)
	  end if
	end if
	if (peasant -> xPos > 515 and peasant -> xPos < 533 and peasant -> yPos > 56 and peasant -> yPos < 76) or (peasant -> xPos > 515 and peasant -> xPos < 533 and peasant -> yPos > 111 and peasant -> yPos < 180) then
	  peasant -> setXPos(533)
	end if
	if peasant -> dir = ord(Direction.UP) then
	  if peasant -> xPos < 30 then
	    peasant -> setXPos(30)
	  elsif peasant -> xPos > 770 then
	    peasant -> setXPos(770)
	  end if
	  if peasant -> yPos < 30 then
	    peasant -> setYPos(30)
	  end if
	end if
	Time.DelaySinceLast (10)
      end for
      peasant -> setMove(false)
    end if
end peasant_proc

process rat
    if ~ ratmove then         %if rat has not been assigned a movement
		ratmove := true
		if ratalive then
		if abs ((xrat + 15) - xcat + 23) >= 75 or abs ((yrat + 15) - ycat + 23) >= 75 then
				rrat := Rand.Int (1, 10)
				if rrat = 1 then
				if yrat < 350 then
						for : 1 .. 50
							yrat := yrat + 1
							Time.DelaySinceLast (30)
						end for
				end if
				elsif rrat = 2 then
				if yrat > 280 then
						for : 1 .. 50
							yrat := yrat - 1
							Time.DelaySinceLast (30)
						end for
				end if
				elsif rrat = 3 then
				if xrat > 180 then
						for : 1 .. 50
							xrat := xrat - 1
							Time.DelaySinceLast (30)
						end for
				end if
				elsif rrat = 4 then
				if xrat < 350 then
						for : 1 .. 50
							xrat := xrat + 1
							Time.DelaySinceLast (30)
						end for
				end if
				else
				Time.DelaySinceLast (30)
				end if
		else
				rrat := Rand.Int (1, 10)
				if rrat = 1 then
				if yrat < 350 then
						for : 1 .. 50
							yrat := yrat + 1
							Time.DelaySinceLast (10)
						end for
				end if
				elsif rrat = 2 then
				if yrat > 280 then
						for : 1 .. 50
							yrat := yrat - 1
							Time.DelaySinceLast (10)
						end for
				end if
				elsif rrat = 3 then
				if xrat > 180 then
						for : 1 .. 50
							xrat := xrat - 1
							Time.DelaySinceLast (10)
						end for
				end if
				elsif rrat = 4 then
				if xrat < 350 then
						for : 1 .. 50
							xrat := xrat + 1
							Time.DelaySinceLast (10)
						end for
				end if
				else
				Time.DelaySinceLast (10)
				end if
		end if
		if xrat > 400 then
				xrat := 400
		elsif xrat < 130 then
				xrat := 130
		end if
		if yrat < 230 then
				yrat := 230
		elsif yrat > 450 then
				yrat := 450
			end if
		end if
		ratmove := false
    end if
    if ratalive then
		if rattalk then
		chattext := rattext (Rand.Int (1, 3))
		if chatentry (5) ~= "" and chattext ~= "" then
				for chatnum : 2 .. 5
					chatentry (chatnum - 1) := chatentry (chatnum)
				end for
				chatentry (5) := chattext
		else
				for chatnum : 1 .. 5
					if chatentry (chatnum) = "" and chattext ~= "" then
						chatentry (chatnum) := chattext
						exit
					end if
				end for
		end if
			chattext := ""
			rattalk := false
			rattalkcounter := 0
		end if
    end if
    rattalkcounter := rattalkcounter + 1
    if rattalkcounter = rattalkcountergoal then
		rattalk := true
		rattalkcountergoal := Rand.Int (500, 1000)
    end if
end rat

process cat
    if ~ catmove then         %if cat has not been assigned a movement
		catmove := true
		if abs ((xcat + 23) - xrat + 15) >= 75 or abs ((ycat + 23) - yrat + 15) >= 75 then
		rcat := Rand.Int (1, 10)
		if rcat = 1 then
				if ycat < 350 then
					for : 1 .. 50
						ycat := ycat + 1
						Time.DelaySinceLast (30)
					end for
				end if
		elsif rcat = 2 then
				if ycat > 280 then
					for : 1 .. 50
						ycat := ycat - 1
						Time.DelaySinceLast (30)
					end for
				end if
		elsif rcat = 3 then
				if xcat > 180 then
					for : 1 .. 50
						xcat := xcat - 1
						Time.DelaySinceLast (30)
					end for
				end if
		elsif rcat = 4 then
				if xcat < 350 then
					for : 1 .. 50
						xcat := xcat + 1
						Time.DelaySinceLast (30)
					end for
				end if
		else
				Time.DelaySinceLast (30)
		end if
		else
			if yrat + 15 < (ycat + 23) then
				rcat := 2
				ycat := ycat - 1
			end if
			if yrat + 15 > (ycat + 23) then
				rcat := 1
				ycat := ycat + 1
			end if
			if xrat + 15 < (xcat + 23) then
				rcat := 3
				xcat := xcat - 1
			end if
			if xrat + 15 > (xcat + 23) then
				rcat := 4
				xcat := xcat + 1
			end if
		end if
		if xcat > 400 then
			xcat := 400
		elsif xcat < 130 then
			xcat := 130
		end if
		if ycat < 230 then
			ycat := 230
		elsif ycat > 450 then
			ycat := 450
		end if
		catmove := false
    end if
    if cattalk then
		chattext := cattext (Rand.Int (1, 3))
		if chatentry (5) ~= "" and chattext ~= "" then
			for chatnum : 2 .. 5
				chatentry (chatnum - 1) := chatentry (chatnum)
			end for
		chatentry (5) := chattext
		else
		for chatnum : 1 .. 5
				if chatentry (chatnum) = "" and chattext ~= "" then
					chatentry (chatnum) := chattext
					exit
				end if
		end for
		end if
		chattext := ""
		cattalk := false
		cattalkcounter := 0
    end if
    cattalkcounter := cattalkcounter + 1
    if cattalkcounter = cattalkcountergoal then
		cattalk := true
		cattalkcountergoal := Rand.Int (500, 1000)
    end if
end cat

proc in_castle (var go_to : string)         %when in the castle
    destination := false
    scene := "castle entrance"
    loop
		if y > 354 and x > 284 and x < 457 then         %if passing through entrance
			if sfx_on then
				fork portcullis
			end if
			go_to := "outside entrance"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (castle_entrance_all, 0, 0, picMerge)
			Pic.DrawSpecial (outside_entrancepic_all, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x < 30 then
			go_to := "shop"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (castle_entrance_all, 0, 0, picMerge)
			Pic.DrawSpecial (shop_pic_all, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x + 29 > 770 then
			go_to := "east hall"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (castle_entrance_all, 0, 0, picMerge)
			Pic.DrawSpecial (hall_all, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif y < 30 then
			go_to := "south of entrance"
			y := 570
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (castle_entrance_all, 0, 0, picMerge)
			Pic.DrawSpecial (stonefloor_pic, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end in_castle

proc south_of_entrance (var go_to : string)         %when in the castle
    destination := false
    scene := "south of entrance"
    loop
		if y > 570 then         %if passing through entrance
			go_to := "castle entrance"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (stonefloor_pic, 0, 0, picCopy)
			Pic.DrawSpecial (castle_entrance_all, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x + 29 > 770 then
			go_to := "in-castle trapdoor"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (stonefloor_pic, 0, 0, picCopy)
			Pic.DrawSpecial (incastletrapdoor_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end south_of_entrance

proc east_hall (var go_to : string)
    destination := false
    scene := "east hall"
    loop
		if x < 30 then
			go_to := "castle entrance"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (hall_all, 0, 0, picMerge)
			Pic.DrawSpecial (castle_entrance_all, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if y < 30 then
			go_to := "in-castle trapdoor"
			y := 570
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (hall_all, 0, 0, picMerge)
			Pic.DrawSpecial (incastletrapdoor_pic, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end east_hall

proc incastle_trapdoor (var go_to : string)         %when in the castle
    destination := false
    scene := "in-castle trapdoor"
    loop
		if y > 570 then         %if passing through entrance
			go_to := "east hall"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (incastletrapdoor_pic, 0, 0, picCopy)
			Pic.DrawSpecial (hall_all, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if         %return to the main program
		if x > 700 and y < 330 and y > 250 then
			go_to := "subcastle tunnel"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (incastletrapdoor_pic, 0, 0, picMerge)
			Pic.DrawSpecial (subcastletunnel_pic, 0, 0, picCopy, picFadeIn, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x < 30 then
			go_to := "south of entrance"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (incastletrapdoor_pic, 0, 0, picCopy)
			Pic.DrawSpecial (stonefloor_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end incastle_trapdoor

proc subcastle_tunnel (var go_to : string)         %when in the castle
    destination := false
    scene := "subcastle tunnel"
    loop
		if x < 30 then
			go_to := "in-castle trapdoor"
			x := 670
			y := 300
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (subcastletunnel_pic, 0, 0, picCopy)
			Pic.DrawSpecial (incastletrapdoor_pic, 0, 0, picCopy, picFadeIn, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x + 29 > 770 then
			go_to := "subcastle tunnel2"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (subcastletunnel_pic, 0, 0, picCopy)
			Pic.DrawSpecial (subcastletunnel2_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end subcastle_tunnel

proc subcastle_tunnel2 (var go_to : string)         %when in the castle
    destination := false
    scene := "subcastle tunnel2"
    loop
		if x < 30 then
			go_to := "subcastle tunnel"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (subcastletunnel2_pic, 0, 0, picCopy)
			Pic.DrawSpecial (subcastletunnel_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x + 29 > 770 then
			go_to := "troll dungeon"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (subcastletunnel2_pic, 0, 0, picCopy)
			Pic.DrawSpecial (trolldungeon_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end subcastle_tunnel2

proc troll_dungeon (var go_to : string)         %when in the castle
    destination := false
    scene := "troll dungeon"
    loop
		if x < 30 then
			go_to := "subcastle tunnel2"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (trolldungeon_pic, 0, 0, picCopy)
			Pic.DrawSpecial (subcastletunnel2_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		fork move_enemy(troll)
    fork talk_enemy(troll)
		View.Update
    end loop
end troll_dungeon

proc outside_entrance (var go_to : string)         %when outside entrance
    destination := false
    scene := "outside entrance"
    loop
		if y < 30 then
			if x > 284 and x < 457 then             %if entering castle
				if sfx_on then
					fork portcullis
				end if
				go_to := "castle entrance"
				y := 330
				setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
				Pic.Draw (outside_entrancepic_all, 0, 0, picMerge)
				Pic.DrawSpecial (castle_entrance_all, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
				setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
				return                 %return to the main program
			else
				y := 30
			end if
		elsif y > 570 then
			go_to := "cottage"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (outside_entrancepic_all, 0, 0, picMerge)
			Pic.DrawSpecial (cottage_pic, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if x < 30 then
			go_to := "east of 'west river'"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (outside_entrancepic_all, 0, 0, picMerge)
			Pic.DrawSpecial (east_of_westriver_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		Pic.Draw (tree, 100, 100, picMerge)         %tree1
		Pic.Draw (tree, 500, 50, picMerge)         %tree2
		Pic.Draw (tree, 300, 300, picMerge)         %tree3
		View.Update
    end loop
end outside_entrance

proc shop (var go_to : string)         %when near shop
    destination := false
    scene := "shop"
    loop
		if x < 30 then         %if leaving through west side of screen
			go_to := "west hall"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (shop_pic_all, 0, 0, picMerge)
			Pic.DrawSpecial (westhall_all, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x + 29 > 770 then
			go_to := "castle entrance"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (shop_pic_all, 0, 0, picMerge)
			Pic.DrawSpecial (castle_entrance_all, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		elsif x > 612 and x < 653 and y > 200 then         %if aligned with shop door
			go_to := "in shop"
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end shop

proc in_shop (var go_to : string)         %when in the shop
    destination := false
    scene := "in shop"
    loop
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if go_to = "shop" then         %if instructed to go to shop
			return             %return to the main program
		end if
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end in_shop

proc west_hall (var go_to : string)         %when in second hall segment west of castle entrance
    destination := false
    scene := "west hall"
    loop
		if x + 29 > 770 then
			go_to := "shop"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (westhall_all, 0, 0, picMerge)
			Pic.DrawSpecial (shop_pic_all, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x > 117 and x < 141 and y > 360 then
			if key_west_hall then
				if sfx_on then
					fork door
				end if
				go_to := "west river"
				y := 30
				setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
				Pic.Draw (westhall_all, 0, 0, picMerge)
				Pic.DrawSpecial (west_river_pic, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
				setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
				return                 %return to the main program
			else
				Font.Draw ("The door is locked; you should find the key...", 14, 614, font2, black)
			end if
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end west_hall

proc west_river (var go_to : string)         %when at west river
    destination := false
    scene := "west river"
    loop
		if y < 30 then
			if x > 117 and x < 141 then             %if aligned with door to second west hall
				if sfx_on then
					fork door
				end if
				go_to := "west hall"
				y := 360
				setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
				Pic.Draw (west_river_pic, 0, 0, picMerge)
				Pic.DrawSpecial (westhall_all, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
				setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
				return                 %return to the main program
			else
				y := 30
			end if
		end if
		if x < 30 then
			go_to := "cemetery"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (west_river_pic, 0, 0, picMerge)
			Pic.DrawSpecial (cemetery_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		elsif x + 29 > 770 then
			go_to := "east of 'west river'"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (west_river_pic, 0, 0, picMerge)
			Pic.DrawSpecial (east_of_westriver_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if y > 570 then
			go_to := "west river-north corner"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (west_river_pic, 0, 0, picMerge)
			Pic.DrawSpecial (westriver_northcorner_pic, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		fork move_enemy(skeleton)
    fork talk_enemy(skeleton)
		View.Update
    end loop
end west_river

proc cemetery (var go_to : string)         %when at west river
    destination := false
    scene := "cemetery"
    loop
		if x + 29 > 770 then
			go_to := "west river"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (cemetery_pic, 0, 0, picMerge)
			Pic.DrawSpecial (west_river_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if x < 251 then
			text := "You have broken into a crypt!"
			go_to := "crypt"
			x := 100
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (cemetery_pic, 0, 0, picMerge)
			if ~ rope then
			Pic.DrawSpecial (crypt_pic, 0, 0, picCopy, picFadeIn, 500)
			else
			Pic.DrawSpecial (crypt_rope_pic, 0, 0, picCopy, picFadeIn, 500)
			end if
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if y > 570 then
			go_to := "dark forest"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (cemetery_pic, 0, 0, picMerge)
			Pic.DrawSpecial (dark_forest_pic, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		fork move_enemy(ghost)
    fork talk_enemy(ghost)
		View.Update
    end loop
end cemetery

proc dark_forest (var go_to : string)         %when at west river
    destination := false
    scene := "dark forest"
    loop
		if x + 29 > 770 then
			go_to := "west river-north corner"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (dark_forest_pic, 0, 0, picMerge)
			Pic.DrawSpecial (westriver_northcorner_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		elsif x < 30 then
			go_to := "witch house"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (dark_forest_pic, 0, 0, picMerge)
			Pic.DrawSpecial (witch_house_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if y < 30 then
			go_to := "cemetery"
			y := 570
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (dark_forest_pic, 0, 0, picMerge)
			Pic.DrawSpecial (cemetery_pic, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		Pic.Draw (dead_trees, 0, 0, picMerge)
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end dark_forest

proc witch_house (var go_to : string)         %when at west river
    destination := false
    scene := "witch house"
    loop
		if x + 29 > 770 then
			go_to := "dark forest"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (witch_house_pic, 0, 0, picMerge)
			Pic.DrawSpecial (dark_forest_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		fork rat
		fork cat
		View.Update
    end loop
end witch_house

proc crypt (var go_to : string)         %when at west river
    destination := false
    scene := "crypt"
    loop
		if x > 140 and x < 180 and y > 275 and y < 340 then
			if rope then
				go_to := "cemetery"
				x := 300
				text := "You climb up the rope to the surface..."
				setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
				Pic.Draw (crypt_rope_pic, 0, 0, picMerge)
				Pic.DrawSpecial (cemetery_pic, 0, 0, picCopy, picFadeIn, 500)
				setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
				return
			else
				text := "You can't reach the surface! You should search for a rope."
			end if
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		fork move_enemy(zombie)
    fork talk_enemy(zombie)
		View.Update
    end loop
end crypt

proc west_river_northcorner (var go_to : string)         %when at west river
    destination := false
    scene := "west river-north corner"
    loop
		if y < 30 then
			go_to := "west river"
			y := 570
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (westriver_northcorner_pic, 0, 0, picMerge)
			Pic.DrawSpecial (west_river_pic, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if x + 29 > 770 then
			go_to := "mountains"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (westriver_northcorner_pic, 0, 0, picMerge)
			Pic.DrawSpecial (mountains_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x < 30 then
			go_to := "dark forest"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (westriver_northcorner_pic, 0, 0, picMerge)
			Pic.DrawSpecial (dark_forest_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		fork move_enemy(skeleton)
    fork talk_enemy(skeleton)
		View.Update
    end loop
end west_river_northcorner

proc mountains (var go_to : string)         %when east of 'west river'
    destination := false
    scene := "mountains"
    loop
		if y > 570 then
			go_to := "lair entrance"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (mountains_pic, 0, 0, picMerge)
			Pic.DrawSpecial (lair_entrance_pic, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		elsif y < 30 then
			go_to := "east of 'west river'"
			y := 570
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (mountains_pic, 0, 0, picMerge)
			Pic.DrawSpecial (east_of_westriver_pic, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if x < 30 then
			go_to := "west river-north corner"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (mountains_pic, 0, 0, picMerge)
			Pic.DrawSpecial (westriver_northcorner_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		elsif x + 29 > 770 then
			go_to := "cottage"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (mountains_pic, 0, 0, picMerge)
			Pic.DrawSpecial (cottage_pic, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end mountains

proc cottage (var go_to : string)         %when east of 'west river'
    destination := false
    scene := "cottage"
    loop
		if y < 30 then
			go_to := "outside entrance"
			y := 570
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (cottage_pic, 0, 0, picMerge)
			Pic.DrawSpecial (outside_entrancepic_all, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		if x < 30 then
			go_to := "mountains"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (cottage_pic, 0, 0, picMerge)
			Pic.DrawSpecial (mountains_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		fork peasant_proc
    fork talk_enemy(peasant)
		if ~ (x > 505 and y > 53 and y < 180) then         %if not in cottage
			Pic.Draw (thatchroof, 519, 149, picCopy)
		end if
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end cottage

proc east_of_westriver (var go_to : string)         %when east of 'west river'
    destination := false
    scene := "east of 'west river'"
    loop
		if x + 29 > 770 then       %if leaving through left side of screen
			go_to := "outside entrance"
			x := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (east_of_westriver_pic, 0, 0, picMerge)
			Pic.DrawSpecial (outside_entrancepic_all, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		elsif x < 30 then
			go_to := "west river"
			x := 770 - 29
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (east_of_westriver_pic, 0, 0, picMerge)
			Pic.DrawSpecial (west_river_pic, 0, 0, picCopy, picSlideLeftToRightNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if y > 570 then
			go_to := "mountains"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (east_of_westriver_pic, 0, 0, picMerge)
			Pic.DrawSpecial (mountains_pic, 0, 0, picCopy, picSlideTopToBottomNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return             %return to the main program
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		fork move_enemy(goblin)
    fork talk_enemy(goblin)
		View.Update
    end loop
end east_of_westriver

proc lair_entrance (var go_to : string)         %when in the castle
    destination := false
    scene := "lair entrance"
    loop
		if y > 410 then
			go_to := "dragon's lair"
			y := 30
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (lair_entrance_pic, 0, 0, picMerge)
			if ~ dragonhead1alive and ~ dragonhead2alive and ~ dragonhead3alive then
			Pic.DrawSpecial (dragondead, 0, 0, picCopy, picFadeIn, 500)
			else
			Pic.DrawSpecial (dragons_lair_pic, 0, 0, picCopy, picFadeIn, 500)
			end if
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		elsif y < 30 then
			go_to := "mountains"
			y := 570
			setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
			Pic.Draw (lair_entrance_pic, 0, 0, picMerge)
			Pic.DrawSpecial (mountains_pic, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
			setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end lair_entrance

proc dragons_lair (var go_to : string)         %when in the castle
    destination := false
    scene := "dragon's lair"
    loop
		if y < 30 then
			if x > 340 and x < 430 then
				go_to := "lair entrance"
				y := 410
				text := "You leave the dragon's lair..."
				setscreen ("position:middle,centre,graphics:800;665,nooffscreenonly,nobuttonbar,nocursor")
				Pic.DrawSpecial (lair_entrance_pic, 0, 0, picCopy, picFadeIn, 500)
				setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
				return
			else
				y := 30
			end if
		end if
		if go_to = "castle entrance" then
			return
		end if
		buttonchoose ("multibutton")
		mousewhere (xm, ym, button)         %check mouse location
		left := button mod 10               % left = 0 or 1
		middle := (button - left) mod 100         % middle = 0 or 10
		right := button - middle - left         % right = 0 or 100
		drawscreen (goto)         %run graphical output
		if movecharacter then
			return
		end if
		if exitgame then
			return
		end if
		View.Update
    end loop
end dragons_lair

proc openingscreen
    exitgame := false
    autosave := false
    if ~ introplayed then
		Pic.DrawSpecial (intro, 0, 0, picCopy, picFadeIn, 1000)
    end if
    introplayed := false
    setscreen ("position:middle,centre,graphics:500;400,offscreenonly,nobuttonbar,nocursor")
    fork menumusic
    loop
		if Window.GetActive = -1 then
			buttonchoose ("multibutton")
			mousewhere (xm, ym, button)
			left := button mod 10           % left = 0 or 1
			middle := (button - left) mod 100         % middle = 0 or 10
			right := button - middle - left         % right = 0 or 100
		if xm > 94 and xm < 161 and ym > 174 and ym < 226 then         %play
				if menubutton ~= "play" then
					Pic.Draw (playpic, 0, 0, picCopy)
					Font.Draw ("G r a i l   Q u e s t", 105, 140, font3, brightgreen)
					Font.Draw (version, 170, 50, font5, yellow)
					Font.Draw ("Download Latest Version of Grail Quest at:", 10, 25, font1, yellow)
					Font.Draw ("http://sites.google.com/site/seanscomputerscience/games/grail-quest/", 10, 10, font2, 11)
					drawline (10, 8, 419, 8, 11)
					View.Update
					menubutton := "play"
				end if
				if swordon then
					fork swords
					swordon := false
				end if
				if left = 1 then
				menubutton := ""
				loop
						if Window.GetActive = -1 then
							buttonchoose ("multibutton")
							mousewhere (xm, ym, button)
							left := button mod 10             % left = 0 or 1
							middle := (button - left) mod 100             % middle = 0 or 10
							right := button - middle - left             % right = 0 or 100
							cls
							colourback (black)
							Font.Draw ("Play new game,", 10, 300, font3, yellow)
							Font.Draw ("or load saved game?", 100, 260, font3, yellow)
							if xm > 100 and xm < 150 and ym > 100 and ym < 150 then             %new
								drawfillbox (100, 100, 150, 150, brightgreen)
								drawfillbox (200, 100, 250, 150, blue)
								drawfillbox (300, 100, 350, 150, red)
								Font.Draw ("New", 110, 115, font2, green)
								Font.Draw ("Load", 210, 115, font2, brightblue)
								Font.Draw ("Back", 310, 115, font2, brightred)
								if swordon then
									fork swords
									swordon := false
								end if
								if left = 1 then
									loadnew := true
									scene := "castle entrance"
									exit
								end if
						elsif xm > 200 and xm < 250 and ym > 100 and ym < 150 then             %load
								drawfillbox (100, 100, 150, 150, green)
								drawfillbox (200, 100, 250, 150, brightblue)
								drawfillbox (300, 100, 350, 150, red)
								Font.Draw ("New", 110, 115, font2, brightgreen)
								Font.Draw ("Load", 210, 115, font2, blue)
								Font.Draw ("Back", 310, 115, font2, brightred)
								if swordon then
									fork swords
									swordon := false
								end if
								if left = 1 then
									load
									loadsavedgame := true
									loadnew := false
									sfx_on := true
									music_on := false
									exit
								end if
						elsif xm > 300 and xm < 350 and ym > 100 and ym < 150 then             %back
								drawfillbox (100, 100, 150, 150, green)
								drawfillbox (200, 100, 250, 150, blue)
								drawfillbox (300, 100, 350, 150, brightred)
								Font.Draw ("New", 110, 115, font2, brightgreen)
								Font.Draw ("Load", 210, 115, font2, brightblue)
								Font.Draw ("Back", 310, 115, font2, red)
								if swordon then
									fork swords
									swordon := false
								end if
								if left = 1 then
									backtomenu := true
									exit
								end if
						else
								drawfillbox (100, 100, 150, 150, green)
								drawfillbox (200, 100, 250, 150, blue)
								drawfillbox (300, 100, 350, 150, red)
								Font.Draw ("New", 110, 115, font2, brightgreen)
								Font.Draw ("Load", 210, 115, font2, brightblue)
								Font.Draw ("Back", 310, 115, font2, brightred)
								swordon := true
						end if
						View.Update
						end if
				end loop
				if ~ backtomenu then
						Music.PlayFileStop
						exit
				end if
				backtomenu := false
				end if
		elsif xm > 339 and xm < 405 and ym > 174 and ym < 226 then         %credits
				if menubutton ~= "credits" then
					Pic.Draw (creditspic, 0, 0, picCopy)
					Font.Draw ("G r a i l   Q u e s t", 105, 140, font3, brightblue)
					Font.Draw (version, 170, 50, font5, yellow)
					Font.Draw ("Download Latest Version of Grail Quest at:", 10, 25, font1, yellow)
					Font.Draw ("http://sites.google.com/site/seanscomputerscience/games/grail-quest/", 10, 10, font2, 11)
					drawline (10, 8, 419, 8, 11)
					View.Update
					menubutton := "credits"
				end if
				if swordon then
					fork swords
					swordon := false
				end if
				if left = 1 then
					menubutton := ""
					Music.PlayFileStop
					fork creditsmusic
					credits
					Music.PlayFileStop
					setscreen ("position:middle,centre,graphics:500;400,nooffscreenonly,nobuttonbar,nocursor")
					Pic.DrawSpecial (intro, 0, 0, picCopy, picFadeIn, 500)
					setscreen ("position:middle,centre,graphics:500;400,offscreenonly,nobuttonbar,nocursor")
					fork menumusic
				end if
		elsif xm > 214 and xm < 286 and ym > 74 and ym < 126 then         %exit
				if menubutton ~= "exit" then
					Pic.Draw (exitpic, 0, 0, picCopy)
					Font.Draw ("G r a i l   Q u e s t", 105, 140, font3, brightred)
					Font.Draw (version, 170, 50, font5, yellow)
					Font.Draw ("Download Latest Version of Grail Quest at:", 10, 25, font1, yellow)
					Font.Draw ("http://sites.google.com/site/seanscomputerscience/games/grail-quest/", 10, 10, font2, 11)
					drawline (10, 8, 419, 8, 11)
					View.Update
					menubutton := "exit"
				end if
				if swordon then
					fork swords
					swordon := false
				end if
				if left = 1 then
					menubutton := ""
					closewindow := true
					exit
				end if
			elsif xm > 0 and xm < 500 and ym > 0 and ym < 50 then         %link
				if menubutton ~= "link" then
					Pic.Draw (intro, 0, 0, picCopy)
					Font.Draw ("G r a i l   Q u e s t", 105, 140, font3, grey)
					Font.Draw (version, 170, 50, font5, yellow)
					Font.Draw ("Download Latest Version of Grail Quest at:", 10, 25, font1, brightgreen)
					Font.Draw ("http://sites.google.com/site/seanscomputerscience/games/grail-quest/", 10, 10, font2, 11)
					drawline (10, 8, 419, 8, 11)
					View.Update
					menubutton := "link"
				end if
				if swordon then
					fork swords
					swordon := false
				end if
				if left = 1 and ~ linkfollowed then
					menubutton := ""
					if ~ Sys.Exec ("http://sites.google.com/site/seanscomputerscience/games/grail-quest") then
					end if
					linkfollowed := true
				elsif left = 0 then
					linkfollowed := false
				end if
		else
				if menubutton ~= "intro" then
					Pic.Draw (intro, 0, 0, picCopy)
					Font.Draw ("G r a i l   Q u e s t", 105, 140, font3, grey)
					Font.Draw (version, 170, 50, font5, yellow)
					Font.Draw ("Download Latest Version of Grail Quest at:", 10, 25, font1, yellow)
					Font.Draw ("http://sites.google.com/site/seanscomputerscience/games/grail-quest/", 10, 10, font2, 11)
					drawline (10, 8, 419, 8, 11)
					View.Update
					menubutton := "intro"
				end if
				swordon := true
		end if
		end if
    end loop
end openingscreen

%----------------------------------
%Main Program and Redirection Code
%----------------------------------
setscreen ("position:middle,centre,graphics:500;400,nooffscreenonly,nobuttonbar,nocursor")
gqintro
openingscreen
if ~ closewindow then
    setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
    if playmusic_on then
		if ~ music_on then             %if music has finished, turn back on
		fork music
		end if
    elsif ~ playmusic_on then
		Music.PlayFileStop
    end if
    if ~ loadsavedgame then
		if scene = "outside entrance" then         %if redirected to outside entrance
		outside_entrance (goto)         %proceed to outside entrance procedure
		elsif scene = "castle entrance" then         %if redirected to castle
			in_castle (goto)         %proceed to castle procedure
		elsif scene = "shop" then         %if redirected to shop
			shop (goto)         %proceed to shop procedure
		elsif scene = "in shop" then         %if redirected into shop
			in_shop (goto)         %proceed to in shop procedure
		elsif scene = "west hall" then         %if redirected to the second hall to the west
			west_hall (goto)         %proceed to west_hall procedure
		elsif scene = "west river" then         %if redirected to the river to the west
			west_river (goto)         %proceed to west_river procedure
		elsif scene = "cemetery" then
			cemetery (goto)
		elsif scene = "dark forest" then
			dark_forest (goto)
		elsif scene = "witch house" then
			witch_house (goto)
		elsif scene = "crypt" then         %if redirected to crypt
			crypt (goto)         %proceed to crypt procedure
		elsif scene = "east of 'west river'" then         %if redirected to east of the west river
			east_of_westriver (goto)         %proceed to east_of_westriver procedure
		elsif scene = "west river-north corner" then
			west_river_northcorner (goto)
		elsif scene = "mountains" then
			mountains (goto)
		elsif scene = "cottage" then
			cottage (goto)
		elsif scene = "lair entrance" then
			lair_entrance (goto)
		elsif scene = "dragon's lair" then
			dragons_lair (goto)
		end if
    end if
end if
loop
    if closewindow then
		Music.PlayFileStop
		exit
    end if
    if exitgame then
		setscreen ("position:middle,centre,graphics:500;400,nooffscreenonly,nobuttonbar,nocursor")
		autosave := false
		openingscreen
		if closewindow then
			Music.PlayFileStop
			exit
		end if
		setscreen ("position:middle,centre,graphics:800;665,offscreenonly,nobuttonbar,nocursor")
		if loadnew then
			open : record2, "Newgamevars.gqr", read
			read : record2, grail, up, battleaxe, twohanded, bowObtained, key_west_hall, cottagekey, dragonhead1alive, dragonhead2alive,
			dragonhead3alive,
			victory, music_on, stopmusic, destination, scalehotkey, attacking, rope, songhotkey, newdest,
			platebody, platelegs, fullhelm, buyhp, buyarrow, delayspeed, gold, picnum, x, y, xdest, ydest,
			xpic, ypic, xdiff, ydiff, archeryxp, combatxp, hitpoints,
			dragonhead1hp,
			dragonhead2hp, dragonhead3hp, hpcounter, dragonhead1returncounter, dragonhead2returncounter, dragonhead3returncounter,
			bonus, healthpacks, arrownum, barheight, shopscreen, defence, weapon, scene, goto,
			text, mapscale, follow, armour, sfx_on, chatentry (1), chatentry (2), chatentry (3), chatentry (4), chatentry (5)
			close : record2
			loadnew := false
			music_on := false
			sfx_on := true
			exitgame := false
			editmodeenabled := false
			autosave := false
			restoreInv()
			in_castle (goto)
		end if
    end if
    if loadsavedgame or movetopreviousscene then         %if loading a saved game after quitting a game
		if loadsavedgame then
			editmodeenabled := false
			loadsavedgame := false
		end if
		movetopreviousscene := false
		if scene = "outside entrance" then             %if redirected to outside entrance
			outside_entrance (goto)                 %proceed to outside entrance procedure
		elsif scene = "castle entrance" then             %if redirected to castle
			in_castle (goto)                 %proceed to castle procedure
		elsif goto = "south of entrance" then
			south_of_entrance (goto)
		elsif goto = "east hall" then
			east_hall (goto)
		elsif goto = "in-castle trapdoor" then
			incastle_trapdoor (goto)
		elsif goto = "subcastle tunnel" then
			subcastle_tunnel (goto)
		elsif goto = "subcastle tunnel2" then
			subcastle_tunnel2 (goto)
		elsif goto = "troll dungeon" then
			troll_dungeon (goto)
		elsif scene = "shop" then             %if redirected to shop
			shop (goto)                 %proceed to shop procedure
		elsif scene = "in shop" then             %if redirected into shop
			in_shop (goto)                 %proceed to in shop procedure
		elsif scene = "west hall" then             %if redirected to the second hall to the west
			west_hall (goto)                 %proceed to west_hall procedure
		elsif scene = "west river" then             %if redirected to the river to the west
			west_river (goto)                 %proceed to west_river procedure
		elsif scene = "cemetery" then
			cemetery (goto)
		elsif scene = "dark forest" then
			dark_forest (goto)
		elsif scene = "witch house" then
			witch_house (goto)
		elsif scene = "crypt" then             %if redirected to crypt
			crypt (goto)                 %proceed to crypt procedure
		elsif scene = "east of 'west river'" then             %if redirected to east of the west river
			east_of_westriver (goto)                 %proceed to east_of_westriver procedure
		elsif scene = "west river-north corner" then
			west_river_northcorner (goto)
		elsif scene = "mountains" then
			mountains (goto)
		elsif scene = "cottage" then
			cottage (goto)
		elsif scene = "lair entrance" then
			lair_entrance (goto)
		elsif scene = "dragon's lair" then
			dragons_lair (goto)
		end if
    end if
    movecharacter := false
    if goto = "outside entrance" or goto = "OUTSIDEENTRANCE" then         %if redirected to outside entrance
		if goto = "OUTSIDEENTRANCE" then
			text := "Moved to: " + goto
		end if
		outside_entrance (goto)             %proceed to outside entrance procedure
    elsif goto = "castle entrance" or goto = "CASTLEENTRANCE" then             %if redirected to castle
		if goto = "CASTLEENTRANCE" then
			text := "Moved to: " + goto
		end if
		in_castle (goto)                   %proceed to castle procedure
    elsif goto = "south of entrance" or goto = "SOUTHOFENTRANCE" then             %if redirected to south of entrance
		if goto = "SOUTHOFENTRANCE" then
			text := "Moved to: " + goto
		end if
		south_of_entrance (goto)
    elsif goto = "east hall" or goto = "EASTHALL" then             %if redirected to east hall
		if goto = "EASTHALL" then
			text := "Moved to: " + goto
		end if
		east_hall (goto)
    elsif goto = "in-castle trapdoor" or goto = "INCASTLETRAPDOOR" then                 %if redirected to trapdoor room
		if goto = "INCASTLETRAPDOOR" then
			text := "Moved to: " + goto
		end if
		incastle_trapdoor (goto)
    elsif goto = "subcastle tunnel" or goto = "SUBCASTLETUNNEL" then                     %if redirected to subcastle tunnel
		if goto = "SUBCASTLETUNNEL" then
			text := "Moved to: " + goto
		end if
		subcastle_tunnel (goto)
    elsif goto = "subcastle tunnel2" or goto = "SUBCASTLETUNNEL2" then                         %if redirected to subcastle tunnel2
		if goto = "SUBCASTLETUNNEL2" then
			text := "Moved to: " + goto
		end if
		subcastle_tunnel2 (goto)
    elsif goto = "troll dungeon" or goto = "TROLLDUNGEON" then                             %if redirected to troll dungeon
		if goto = "TROLLDUNGEON" then
			text := "Moved to: " + goto
		end if
		troll_dungeon (goto)
    elsif goto = "shop" or goto = "SHOP" then         %if redirected to shop
		if goto = "SHOP" then
			text := "Moved to: " + goto
		end if
		shop (goto)             %proceed to shop procedure
    elsif goto = "in shop" or goto = "INSHOP" then         %if redirected into shop
		if goto = "INSHOP" then
			text := "Moved to: " + goto
		end if
		in_shop (goto)             %proceed to in shop procedure
    elsif goto = "west hall" or goto = "WESTHALL" then         %if redirected to the second hall to the west
		if goto = "WESTHALL" then
			text := "Moved to: " + goto
		end if
		west_hall (goto)             %proceed to west_hall procedure
    elsif goto = "west river" or goto = "WESTRIVER" then         %if redirected to the river to the west
		if goto = "WESTRIVER" then
			text := "Moved to: " + goto
		end if
		west_river (goto)             %proceed to west_river procedure
    elsif goto = "cemetery" or goto = "CEMETERY" then
		if goto = "CEMETERY" then
			text := "Moved to: " + goto
		end if
		cemetery (goto)
    elsif goto = "dark forest" or goto = "DARKFOREST" then
		if goto = "DARKFOREST" then
			text := "Moved to: " + goto
		end if
		dark_forest (goto)
    elsif goto = "witch house" or goto = "WITCHHOUSE" then
		if goto = "WITCHHOUSE" then
			text := "Moved to: " + goto
		end if
		witch_house (goto)
    elsif goto = "crypt" or goto = "CRYPT" then         %if redirected to crypt
		if goto = "CRYPT" then
			text := "Moved to: " + goto
		end if
		crypt (goto)             %proceed to crypt procedure
    elsif goto = "east of 'west river'" or goto = "EASTOFWESTRIVER" then         %if redirected to east of the west river
		if goto = "EASTOFWESTRIVER" then
			text := "Moved to: " + goto
		end if
		east_of_westriver (goto)             %proceed to east_of_westriver procedure
    elsif goto = "west river-north corner" or goto = "WESTRIVERNORTHCORNER" then
		if goto = "WESTRIVERNORTHCORNER" then
			text := "Moved to: " + goto
		end if
		west_river_northcorner (goto)
    elsif goto = "mountains" or goto = "MOUNTAINS" then
		if goto = "MOUNTAINS" then
			text := "Moved to: " + goto
		end if
		mountains (goto)
    elsif goto = "cottage" or goto = "COTTAGE" then
		if goto = "COTTAGE" then
			text := "Moved to: " + goto
		end if
		cottage (goto)
    elsif goto = "lair entrance" or goto = "LAIRENTRANCE" then
		if goto = "LAIRENTRANCE" then
			text := "Moved to: " + goto
		end if
		lair_entrance (goto)
    elsif goto = "dragon's lair" or goto = "DRAGONSLAIR" then
		if goto = "DRAGONSLAIR" then
			text := "Moved to: " + goto
		end if
		dragons_lair (goto)
    else
		text := "The location '" + goto + "' does not exist."
		movetopreviousscene := true
    end if
end loop
%--------------------------------------------------------------------------------------
%>>>END OF PROGRAM<<<
%--------------------------------------------------------------------------------------
