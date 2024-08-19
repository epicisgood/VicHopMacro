#Requires AutoHotkey v2.0
#SingleInstance Force

SetWorkingDir A_ScriptDir

KeyDelay := 40

Setkeydelay KeyDelay

CoordMode "Pixel", "Screen"
SendMode "Event"


#include %A_ScriptDir%\scripts\


#Include paths.ahk
#Include functions.ahk
#include joinserver.ahk
#Include webhook.ahk
#Include timers.ahk

#include %A_ScriptDir%\lib\

#Include FormData.ahk
#Include Gdip_All.ahk
#include Gdip_ImageSearch.ahk
#Include roblox.ahk
#Include walk.ahk

GetRobloxClientPos()
pToken := Gdip_Startup()
bitmaps := Map()
bitmaps.CaseSense := 0


#Include %A_ScriptDir%\img\bitmaps.ahk


if (!FileExist("settings.ini")) {
    IniWrite("Insert Url", "settings.ini", "Settings", "url")
    IniWrite("Insert UserId", "settings.ini", "Settings", "discordID")
    IniWrite("Insert Movespeed", "settings.ini", "Settings", "movespeed")
    IniWrite(1, "settings.ini", "Settings", "Stockings")
    IniWrite(1, "settings.ini", "Settings", "Feast")
    IniWrite(1, "settings.ini", "Settings", "Candles")
    IniWrite(1, "settings.ini", "Settings", "Samovar")
    IniWrite(1, "settings.ini", "Settings", "LidArt")
}

TraySetIcon("img\stinger.ico")

url := IniRead("settings.ini", "Settings", "url")
discordID := IniRead("settings.ini", "Settings", "discordID")
PlayerSpeed := IniRead("settings.ini", "Settings", "movespeed")
IniStockings := IniRead("settings.ini", "Settings", "Stockings")
IniFeast := IniRead("settings.ini", "Settings", "Feast")
IniCandles := IniRead("settings.ini", "Settings", "Candles")
IniSamovar := IniRead("settings.ini", "Settings", "Samovar")
IniLidArt := IniRead("settings.ini", "Settings", "LidArt")

MainGui := Gui("+Border +OwnDialogs", "Stinger")
MainGui.BackColor := "444db6"

MainGui.SetFont("s12 Bold cWhite", "Tahoma")
MainGui.AddText("x0 y10 w450 h20 Center", "Vicious Hop Macro!")

MainGui.SetFont("s10 cWhite", "Tahoma")
MainGui.AddText("x0 y40 w450 h20 Center", "Discord Settings:")
MainGui.AddText("x10 y70 w120 h20", "Discord Webhook URL:")
URLEdit := MainGui.AddEdit("x140 y70 w300 h20", url)
URLEdit.BackColor := "000000"
URLEdit.SetFont("c000000", "Tahoma")

MainGui.AddText("x10 y100 w120 h20", "Discord User ID:")
DiscordIDEdit := MainGui.AddEdit("x140 y100 w300 h20", discordID)
DiscordIDEdit.BackColor := "000000"
DiscordIDEdit.SetFont("c000000", "Tahoma")

MainGui.AddText("x10 y130 w120 h20", "Movespeed:")
MovespeedEdit := MainGui.AddEdit("x140 y130 w300 h20", PlayerSpeed)
MovespeedEdit.BackColor := "000000"
MovespeedEdit.SetFont("c000000", "Tahoma")

MainGui.SetFont("s10 cWhite", "Tahoma")
MainGui.AddText("x10 y180 w60 h20", "Stockings:")
StockingsCheckbox := MainGui.AddCheckbox("x80 y180", IniStockings = 1)
StockingsCheckbox.Value := IniStockings

MainGui.AddText("x120 y180 w40 h20", "Feast:")
FeastCheckbox := MainGui.AddCheckbox("x170 y180", IniFeast = 1)
FeastCheckbox.Value := IniFeast

MainGui.AddText("x210 y180 w50 h20", "Candles:")
CandlesCheckbox := MainGui.AddCheckbox("x270 y180", IniCandles = 1)
CandlesCheckbox.Value := IniCandles

MainGui.AddText("x310 y180 w60 h20", "Samovar:")
SamovarCheckbox := MainGui.AddCheckbox("x380 y180", IniSamovar = 1)
SamovarCheckbox.Value := IniSamovar

MainGui.AddText("x175 y210 w60 h20 Center", "LidArt:")
LidArtCheckbox := MainGui.AddCheckbox("x235 y210", IniLidArt = 1)
LidArtCheckbox.Value := IniLidArt

StartButton := MainGui.AddButton("x10 y240 w80 h30", "Start (F1)")
StopButton := MainGui.AddButton("x100 y240 w80 h30", "Stop (F2)")
StartButton.OnEvent('click', Start)
StopButton.OnEvent('click', StopMacro)

SaveButton := MainGui.AddButton("x340 y240 w100 h30", "Save")
SaveButton.OnEvent('click', SaveSettings)

MainGui.SetFont("s8 cWhite", "Tahoma")
MainGui.AddText("x1 y280 w448 h20 Right", "- Made by epic - v1.0.7")

MainGui.Show("w450 h310")

SaveSettings(*) {
    global MainGui, URLEdit, DiscordIDEdit, MovespeedEdit, StockingsCheckbox, FeastCheckbox, CandlesCheckbox, SamovarCheckbox, LidArtCheckbox
    MainGui.Submit("NoHide")
    IniWrite(URLEdit.Value, "settings.ini", "Settings", "url")
    IniWrite(DiscordIDEdit.Value, "settings.ini", "Settings", "discordID")
    IniWrite(MovespeedEdit.Value, "settings.ini", "Settings", "movespeed")
    IniWrite(StockingsCheckbox.Value, "settings.ini", "Settings", "Stockings")
    IniWrite(FeastCheckbox.Value, "settings.ini", "Settings", "Feast")
    IniWrite(CandlesCheckbox.Value, "settings.ini", "Settings", "Candles")
    IniWrite(SamovarCheckbox.Value, "settings.ini", "Settings", "Samovar")
    IniWrite(LidArtCheckbox.Value, "settings.ini", "Settings", "LidArt")
    MsgBox "Settings saved!"
    MainGui.Show("w450 h310")
    reload
}





Start(*) {
    KeyboardLayout()
    NoIMGPlayerStatus("Starting v1.0.7 VicHopMacro by epic", 16776960)
    GetServerIds()
    OnError (e, mode) => (mode = "return") * (-1)
    loop {
        MainLoop()
    }
}
StopMacro(*) {
    Send "{" WKey " up}{" AKey " up}{" SKey " up}{" Dkey " up}"
    try Gdip_Shutdown(pToken)
    ExitApp()
}

NoIMGPlayerStatus("Connected to discord!", 3426654)

F1:: {
    Start
}

F2:: StopMacro()


WKey := "sc011" ; w
AKey := "sc01e" ; a
SKey := "sc01f" ; s
Dkey := "sc020" ; d
RotLeft := "vkBC" ; ,
RotRight := "vkBE" ; .
RotUp := "sc149" ; PgUp
RotDown := "sc151" ; PgDn
ZoomIn := "sc017" ; i
ZoomOuter := "sc018" ; o
Ekey := "sc012" ; e
Rkey := "sc013" ; r
Lkey := "sc026" ; l
EscKey := "sc001" ; Esc
EnterKey := "sc01c" ; Enter
SpaceKey := "sc039" ; Space
Lkey := "sc002" ; 1
SlashKey := "sc035" ; /


KeyboardLayout() {
    hkl := DllCall("GetKeyboardLayout", "uint", DllCall("GetWindowThreadProcessId", "uint", WinActive("A"), "uint", 0), "uint")

    language := hkl & 0xFFFF

    if (!language = 0x0409)
    {
        MsgBox("Please switch to a US QWERTY keyboard in settings. You may continue if the '/' key is working.")
    }
}

MainLoop() {
    while (JoinServer() == 2) {
        HyperSleep(350)
    }

    if (NightDetection() == 1) {
        PlayerStatus("Night Detected!!", 0, false)
        global Attempts := 0
        ZoomOut()
        if (StartServerLoop() == 1) {
            return
        }
    } else {
        NoIMGPlayerStatus("Searching For Night Servers.", 1752220)
        return
    }

    KillViciousBees()
    return
}


KillViciousBees() {
    if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    } else if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }
    NoIMGPlayerStatus("Going to Pepper Patch.", 2067276)
    PepperPatch()
    PlayerStatus("Finished Checking Pepper Patch.", 5763719, false)

    loopresult := VIciousAttackLoop(3)
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {
            return
        }
        PepperPatch()
        VIciousAttackLoop(3)
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }


    if (ResetMainCharacter() == false) {
        return
    }
    if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    } else if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }
    NoIMGPlayerStatus("Going to Mountain Top Field.", 2067276)
    MountainTop()
    PlayerStatus("Finished Checking Mountain Top Field.", 5763719, false)
    loopresult := VIciousAttackLoop(2)
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {
            return
        }
        MountainTop()
        VIciousAttackLoop(2)
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }


    if (ResetMainCharacter() == false) {
        return
    }
    if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    } else if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }


    NoIMGPlayerStatus("Going to Rose Field.", 2067276)
    Rose()
    PlayerStatus("Finished Checking Rose Field.", 5763719, false)
    loopresult := VIciousAttackLoop()
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {
            return
        }
        Rose()
        VIciousAttackLoop()
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }


    if (ResetMainCharacter() == false) {
        return
    }

    NoIMGPlayerStatus("Going to Cactus Field.", 2067276)
    if (PictureImageSearch("img\stickbug.png", 26)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    } else if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }
    Cactus()
    PlayerStatus("Finished Checking Cactus Field.", 5763719, false)
    loopresult := VIciousAttackLoop()
    if (loopresult == 3) {
        if (ResetMainCharacter() == false) {
            return
        }
        Cactus()
        VIciousAttackLoop()
        return
    } else if (loopresult == 1) {
        Sleep 1
    } else {
        return
    }
    NoIMGPlayerStatus("No Vicious bees found...", 8359053)
    BeesmasInterupt()
}

F10:: {
    
    ; CheckSpawnPos()
    ; Send "{" RotDown " 1}"
    ; CheckCocoSpawn()
}
JoinServer() {
    ActivateRoblox()
    SetKeyDelay 100
    send "{esc}{l}{Enter}"
    SetKeyDelay KeyDelay
    joinrandomserver()
    if (DetectLoading(0x2257A8, 30000)) {
        Sleep 850
        return 1
    } else {
        return 2
    }
}