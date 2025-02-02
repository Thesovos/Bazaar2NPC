#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Establishes variables now so things don't complain latter
Global Selected := N/A
Global Editable := N/A

;Establishes Chronology
Global Rank := 1

; a blank value
global Blank :=

Snatch:
;In case of time travel
gui, Destroy

;calls the API and stores the response to a variable called RAW
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://api.hypixel.net/skyblock/bazaar", true)
whr.Send()
whr.WaitForResponse()
RAW := whr.ResponseText

;removes most clunky formating From RAW and Outputs to Fixed
Fix1 := StrReplace(RAW, Chr(58),Chr(32))
Fix2 := StrReplace(Fix1, Chr(44),Chr(13))
Fix3 := StrReplace(Fix2, Chr(44)Chr(34)buy_, Chr(13)Chr(34)buy_)
Fix4 := StrReplace(fix3, Chr(34), Chr(32))
Fix5 := StrReplace(Fix4, Chr(91), Chr(32))
Fix6 := StrReplace(Fix5, Chr(93), Chr(32))
Fix7 := StrReplace(Fix6, Chr(123), Chr(32))
Fix8 := StrReplace(Fix7, Chr(125), Chr(32))
Fix9 := StrReplace(Fix8, Chr(44),Chr(44)Chr(32))
Fix10 := StrReplace(Fix9, Quick, Chr(13)Quick)
Fix11 := StrReplace(Fix10, "products"Chr(58), Chr(13)"products"Chr(58)Chr(13)) 
Fix12 := StrReplace(Fix11, Chr(32), %Blank%)
Fix13 := StrReplace(Fix12, Chr(13), %Blank%)
Fixed := StrReplace(Fix13, Chr(95), %Blank%)

;fetches values from the data in Fixed and updates cronology with our place in the data
Ranked := RegExMatch(Fixed, "quickstatusproductId([a-zA-Z0-9]+)sellPrice([0-9.?0-9?]+)sellVolume([0-9]+)sellMovingWeek([0-9]+)sellOrders([0-9]+)buyPrice([0-9.?0-9?]+)buyVolume([0-9]+)buyMovingWeek([0-9]+)buyOrders([0-9]+)", Value, StartingPos := Rank)
Rank := (Ranked+=1)
IniRead, NPC, %A_ScriptDir%\Settings.ini, NPCPrices, %Value1%
IniRead, Product, %A_ScriptDir%\Settings.ini, Aliases, %Value1%
gosub, Maths
IfLessOrEqual, SP, 0
	goto, FetchNext
if SP =
	goto, FetchNext


Home:
Gui, Add, Edit, x852 y409 w-610 h-460 , Edit
Gui, Font, S18, SF Fedora Shadow
Gui, Add, Picture, x-8 y-33 w1280 h730 , %A_ScriptDir%\Splashes\Backround.png
Gui, Add, Picture, x12 y259 w180 h180 , %A_ScriptDir%\Splashes\Tip 3D.png
Gui, Add, Button, x12 y159 w180 h50 gSnatch, Reload%A_Space%
Gui, Add, Button, x12 y209 w180 h40 gFetchNext, Offer2NPC%A_Space%
Gui, Add, Button, x192 y639 w170 h40 gSerious, Seriously?%A_Space%
Gui, Add, Button, x22 y509 w180 h40 gJams, Tasty Jams%A_Space%
Gui, Add, Button, x22 y639 w170 h40 gFree, Free?%A_Space%
Gui, Add, Button, x222 y509 w120 h40 GJams, Shuffle%A_Space%
Gui, Add, Button, x342 y509 w120 h40 GStop, Stop%A_Space%
Gui, Add, Button, x482 y509 w120 h40 GNextSong, Next%A_Space%
Gui, Add, Button, x602 y509 w120 h40 GLastSong, last%A_Space%
Gui, Add, Button, x32 y569 w150 h50 GCrisis, Crisis%A_Space%
Gui, Add, Button, x362 y639 w170 h40 gHow, How?%A_Space%
Gui, Add, Button, x532 y639 w170 h40 gTips, Tips?%A_Space%
Gui, Add, Button, x692 y209 w190 h40 gFetchQuick, Quick2NPC%A_Space%
Gui, Add, Button, x692 y164 w190 h40 gOpen, Ok%A_Space%
Gui, Add, Button, x692 y249 w190 h40 gShooter, It's Wrong%A_Space%
Gui, Add, ComboBox, x202 y160 w480 h40 vSelected , Ancient Claw|Blaze Rod|Blessed Bait|Blue Shark Tooth|Bone|Booster Cookie|Brown Mushroom|Cactus|Carrot Bait|Carrot|Catalyst|Clay|Coal|Cobblestone|Colossal Experience Bottle|Compactor|Daedalus Stick|Dark Bait|Diamond|Ectoplasm|Emerald|Enchanted Acacia Wood|Enchanted Ancient Claw|Enchanted Baked Potato|Enchanted Birch Wood|Enchanted Blaze Powder|Enchanted Blaze Rod|Enchanted Bone|Enchanted Bone Block|Enchanted Bread|Enchanted Brown Mushroom|Enchanted Cactus|Enchanted Cactus Green|Enchanted Cake|Enchanted Carrot|Enchanted Carrot on a Stick|Enchanted Carrot on a Stick|Enchanted Charcoal|Enchanted Clay|Enchanted Clownfish|Enchanted Coal|Enchanted Block of Coal|Enchanted Cobblestone|Enchanted Cocoa Bean|Enchanted Cooked Fish|Enchanted Cooked Mutton|Enchanted Cooked Salmon|Enchanted Cookie|Enchanted Dark Oak Wood|Enchanted Diamond|Enchanted Diamond Block|Enchanted Egg|Enchanted Emerald|Enchanted Emerald Block|Enchanted Ender Pearl|Enchanted End Stone|Enchanted Eye of Ender|Enchanted Feather|Enchanted Fermented Spider Eye|Enchanted Firework Rocket|Enchanted Flint|Enchanted Ghast Tear|Enchanted Glistering Melon|Enchanted Glowstone|Enchanted Glowstone Dust|Enchanted Gold|Enchanted Gold Block|Enchanted Golden Carrot|Enchanted Grilled Pork|Enchanted Gunpowder|Enchanted Hay Bale|Enchanted Brown Mushroom Block|Enchanted Red Mushroom Block|Enchanted Ice|Enchanted Ink Sack|Enchanted Iron|Enchanted Iron Block|Enchanted Jungle Wood|Enchanted Lapis Lazuli|Enchanted Lapis Block|Enchanted Lava Bucket|Enchanted Leather|Enchanted Magma Cream|Enchanted Melon|Enchanted Melon Block|Enchanted Mithril|Enchanted Mutton|Enchanted Nether Wart|Enchanted Oak Wood|Enchanted Obsidian|Enchanted Packed Ice|Enchanted Paper|Enchanted Pork|Enchanted Potato|Enchanted Prismarine Crystals|Enchanted Prismarine Shard|Enchanted Pufferfish|Enchanted Pumpkin|Enchanted Quartz|Enchanted Quartz Block|Enchanted Raw Rabbit|Enchanted Rabbit Foot|Enchanted Rabbit Hide|Enchanted Raw Beef|Enchanted Raw Chicken|Enchanted Raw Fish|Enchanted Raw Salmon|Enchanted Red Mushroom|Enchanted Redstone|Enchanted Redstone Block|Enchanted Redstone Lamp|Enchanted Rotten Flesh|Enchanted Sand|Enchanted Seeds|Enchanted Shark Fin|Enchanted Slimeball|Enchanted Slime Block|Enchanted Snow Block|Enchanted Spider Eye|Enchanted Sponge|Enchanted Spruce Wood|Enchanted String|Enchanted Sugar|Enchanted Sugar Cane|Enchanted Titanium|Enchanted Lily Pad|Enchanted Wet Sponge|Ender Pearl|End Stone|Experience Bottle|Feather|Fish Bait|Flint|Foul Flesh|Fuming Potato Book|Ghast Tear|Glowstone Dust|Golden Tooth|Gold Ingot|Grand Experience Bottle|Gravel|Great White Shark Tooth|Green Candy|Green Gift|Griffin Feather|Hamster Wheel|Hay Bale|Holy Dragon Fragment|Hot Potato Book|Brown Mushroom Block|Red Mushroom Block|Hyper Catalyst|Ice|Ice Bait|Cocoa Beans|Lapis Lazuli|Ink Sack|Iron Ingot|Jacob's Ticket|Blue Jerry Box|Golden Jerry Box|Green Jerry Box|Purple Jerry Box|Leather|Light Bait|Spruce Wood|Dark Oak Wood|Acacia Wood|Birch Wood|Jungle Wood|Oak Wood|Magma Cream|Melon|Minnow Bait|Mithril|Mutant Nether Wart|Mutton|Netherrack|Nether Wart|Nurse Shark Tooth|Obsidian|Old Dragon Fragment|Packed Ice|Polished Pumpkin|Raw Porkchop|Potato|Prismarine Crystals|Prismarine Shard|Protector Dragon Fragment|Pumpkin|Pumpkin Guts|Purple Candy|Nether Quartz|Raw Rabbit|Rabbit's Foot|Rabbit Hide|Raw Beef|Raw Chicken|Raw Salmon|Clownfish|Pufferfish|Raw Fish|Recombobulator |Red Gift|Red Mushroom|Redstone|Refined Diamond|Refined Mineral|Refined Mithril|Refined Titanium|Revenant Flesh|Revenant Viscera|Rotten Flesh|Sand|Seeds|Shark Bait|Shark Fin|Slimeball|Snowball|Snow Block|Soul Fragment|Spider Eye|Spiked Bait|Sponge|Spooky Bait|Spooky Shard|Starfall|Stock of Stonks|String|Strong Dragon Fragment|Sugar Cane|Gunpowder|Summoning Eye|Super Compactor |Super Enchanted Egg|Superior Dragon Fragment|Tarantula Silk|Tarantula Web|Tiger Shark Tooth|Tightly-Tied Hay Bale|Titanic Experience Bottle|Titanium|Unstable Dragon Fragment|Lily Pad|Werewolf Skin|Whale Bait|Wheat|White Gift|Wise Dragon Fragment|Wolf Tooth|Young Dragon Fragment 
Gui, Add, ListBox, x202 y209 w480 h50 , %Product%
Gui, Add, ListBox, x202 y249 w200 h60 , NPCs Offer
Gui, Add, ListBox, x202 y289 w200 h44 , Sellers Offer
Gui, Add, ListBox, x202 y329 w200 h44 , Quick Margin
Gui, Add, ListBox, x202 y369 w200 h44 , Rival Offer
Gui, Add, ListBox, x202 y409 w200 h44 , Order Margin
Gui, Add, ListBox, x222 y569 w580 h44 , %Jamnow%
Gui, Add, ListBox, x402 y249 w280 h44 , $%NPC%
Gui, Add, ListBox, x402 y289 w280 h44 , $%Value6%
Gui, Add, ListBox, x402 y329 w280 h44 , %QM%`%
Gui, Add, ListBox, x402 y369 w280 h44 , $%Value2%
Gui, Add, ListBox, x402 y409 w280 h44 , %SM%`%
Gui, Add, ListBox, x682 y289 w210 h44 , Average Offer
Gui, Add, ListBox, x682 y329 w210 h44 , Daily Volume
Gui, Add, ListBox, x682 y369 w210 h44 , Average Ask
Gui, Add, ListBox, x682 y409 w210 h44 , Daily Volume
Gui, Add, ListBox, x892 y289 w350 h44 , %SV%
Gui, Add, ListBox, x892 y329 w350 h44 , %DS%
Gui, Add, ListBox, x892 y369 w350 h44 , %BV%
Gui, Add, ListBox, x892 y409 w350 h44 , %DB%
Gui, Add, Text, x822 y529 w155 h44, Data from:
Gui, Add, Text, x822 y569 w430 h44, %A_MMMM%/%A_DD%/%A_YYYY%:%A_Hour%:%A_Min%:%A_Sec% 
Gui, Show, w1270 h690, Bazaar2NPC GUI
return

FetchNext:
Rank := (Ranked+=1)
Ranked := RegExMatch(Fixed, "quickstatusproductId([a-zA-Z0-9]+)sellPrice([0-9.?0-9?]+)sellVolume([0-9]+)sellMovingWeek([0-9]+)sellOrders([0-9]+)buyPrice([0-9.?0-9?]+)buyVolume([0-9]+)buyMovingWeek([0-9]+)buyOrders([0-9]+)", Value, StartingPos := Rank)
IniRead, NPC, %A_ScriptDir%\Settings.ini, NPCPrices, %Value1%
IniRead, Product, %A_ScriptDir%\Settings.ini, Aliases, %Value1%
gosub, Maths
IfLessOrEqual, SM, 0
	goto, FetchNext

if SP = 
	goto, FetchNext

if Value5 = 0
	goto, FetchNext

goto, Homeer
return

FetchQuick:
Rank := (Ranked+=1)
Ranked := RegExMatch(Fixed, "quickstatusproductId([a-zA-Z0-9]+)sellPrice([0-9.?0-9?]+)sellVolume([0-9]+)sellMovingWeek([0-9]+)sellOrders([0-9]+)buyPrice([0-9.?0-9?]+)buyVolume([0-9]+)buyMovingWeek([0-9]+)buyOrders([0-9]+)", Value, StartingPos := Rank)
IniRead, NPC, %A_ScriptDir%\Settings.ini, NPCPrices, %Value1%
IniRead, Product, %A_ScriptDir%\Settings.ini, Aliases, %Value1%
gosub, Maths
IfLessOrEqual, QM, 0
	goto, FetchQuick

if QP = 
	goto, FetchQuick

if Value5 = 0
	goto, FetchNext

goto, Homeer
return

Free:
MsgBox, 0, FREE!, made, done, or given voluntarily or spontaneously
return

How:
MsgBox, 0, Tutorial, The tool finds items in the bazaar for less then the NPCs next door pay.
return

Serious:
SoundPlay, %A_ScriptDir%\Splashes\Free.asf
return

Tips:
Gui, Destroy
Gui, Add, Picture, x-0 y-0 w310 h710 ,  %A_ScriptDir%\Splashes\Tip.png
Gui, Add, Button, x125 y680 gHomeer, Home
Gui, Show, w310 h710, I take XRP...
return

Open:
gui, submit
IniRead, Product, %A_ScriptDir%\Settings.ini, Aliases, %Selected%
Ranked := RegExMatch(Fixed, Product, Quary, StartingPos := Rank)
Rank := (Ranked+=1)
Ranked := RegExMatch(Fixed, "quickstatusproductId([a-zA-Z0-9]+)sellPrice([0-9.?0-9?]+)sellVolume([0-9]+)sellMovingWeek([0-9]+)sellOrders([0-9]+)buyPrice([0-9.?0-9?]+)buyVolume([0-9]+)buyMovingWeek([0-9]+)buyOrders([0-9]+)", Value, StartingPos := Rank)
IniRead, NPC, %A_ScriptDir%\Settings.ini, NPCPrices, %Value1%
IniRead, Product, %A_ScriptDir%\Settings.ini, Aliases, %Value1%
gosub, Maths
goto, Homeer
return

Maths:
BV := Floor(Value3/Value5)
SV := Floor(Value7/Value9)
DB := Floor(Value4/7)
DS := Floor(Value8/7)
QP := NPC-Value6
SP := NPC-Value2
QM := QP/NPC
SM := SP/NPC
QM := (QM*100)
SM := (SM*100)
SP := Round(SP, 3)
QP := Round(QP, 3)
QM := Round(QM, 3)
SM := Round(SM, 3)
Value6 := Round(Value6, 3)
Value2 := Round(value2, 3)
return

Shooter:
MsgBox, 51, Troubleshooter, Have you done this before?
IfMsgBox, Yes, {
	run, https://api.hypixel.net/skyblock/bazaar
	run, %A_ScriptDir%\Settings.ini
}
IfMsgBox, No, {
	MsgBox, 0, Tutorial, I'm going to try and open a raw API call and the settings.ini`n`nThe INI is formated as follows:`n`n[NPCPrices]`nRAWNAME=#`n`n[Aliases]`nRAWNAME="Chosen Name"`nChosen Name=RAWNAME`n`n[EXITS]`n#=URL`n`n[Jams]`n#=Artist - Song`n`nRAWNAME is what the API calls a given item`n`nChosen Name is how you want the items name to apear`n`n# can only be a string of numbers `nif after = it may have zero or one period`nbut not at the end or begining`n`nDo not change the #s under [EXIT] or [Jams]`nDo not add lines under [EXIT] or [Jams] without editting the base code`nReplace the URLs as desired`n`nDon't forget to add new entries under [Aliases] both ways`nDo remember to add new entries under [NPCPrices]`n`nRAWNAMEs are often the oldest known name for an item`nNETHERSTALK & WATERLILY for example.`n`nJust save the settings.ini and restart the app to test it out`nTheres a backup Settings.ini in ~\Bazaar2NPC\Backup
}
return

Submit:
Gui Submit , NoHide
return

Jams:
Random, Jams, 1, 4
SoundPlay, %A_ScriptDir%\Splashes\Audio\%Jams%.mp3
IniRead, Jamnow, %A_ScriptDir%\Settings.ini, Jams, %Jams%
goto, homeer
return

Stop:
soundplay, %A_ScriptDir%\Splashes\Audio\0.wav
Jamnow =
goto, Homeer
return

NextSong:
Jams += 1
If (jams>4)
	jams = 1
SoundPlay, %A_ScriptDir%\Splashes\Audio\%Jams%.mp3
IniRead, Jamnow, %A_ScriptDir%\Settings.ini, Jams, %Jams%
goto, Homeer
return

LastSong:
Jams -= 1
if (jams<1)
	Jams = 4
SoundPlay, %A_ScriptDir%\Splashes\Audio\%Jams%.mp3
IniRead, Jamnow, %A_ScriptDir%\Settings.ini, Jams, %Jams%
goto, Homeer
return

Crisis:
Random, Crisis, 1, 286
IniRead, Escape, %A_ScriptDir%\Settings.ini, EXITS, %Crisis%
run, %Escape%
return

Homeer:
Gui, Destroy
Goto, Home 
return


GuiClose:
ExitApp





