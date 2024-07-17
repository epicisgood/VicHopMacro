#Requires AutoHotkey v2.0
#SingleInstance Force

SetWorkingDir A_ScriptDir

Setkeydelay 50

CoordMode "Pixel", "Screen"
SendMode "Event"


#include %A_ScriptDir%\scripts\

#Include paths.ahk
#Include functions.ahk
#include joinserver.ahk
#Include webhook.ahk


if (!FileExist("settings.ini")) {
    IniWrite("Insert Url", "settings.ini", "Settings", "url")
    IniWrite("Insert UserId", "settings.ini", "Settings", "discordID")
}

TraySetIcon("img\stinger.ico")

url := IniRead("settings.ini", "Settings", "url")
discordID := IniRead("settings.ini", "Settings", "discordID")

MainGui := Gui("+Border +OwnDialogs", "Stinger")


MainGui.BackColor := "444db6"

MainGui.SetFont("s12 Bold cWhite", "Tahoma")
MainGui.AddText("x0 y10 w450 h20 Center", "Vicious Hop Macro!")

MainGui.SetFont("s10 cWhite", "Tahoma")
MainGui.AddText("x0 y40 w450 h20 Center", "Discord Settings:")
MainGui.AddText("x10 y70 w120 h20", "Discord Webhook URL:")
URLEdit := MainGui.AddEdit("x140 y70 w300 h40", url)
URLEdit.BackColor := "000000"
URLEdit.SetFont("c000000", "Tahoma")
MainGui.AddText("x10 y120 w120 h20", "Discord User ID:")
DiscordIDEdit := MainGui.AddEdit("x140 y120 w300 h20", discordID)
DiscordIDEdit.BackColor := "000000"
DiscordIDEdit.SetFont("c000000", "Tahoma")

StartButton := MainGui.AddButton("x10 y160 w80 h30", "Start (F1)")
StopButton := MainGui.AddButton("x100 y160 w80 h30", "Stop (F2)")
StartButton.OnEvent('click', Start)
StopButton.OnEvent('click', StopMacro)


SaveButton := MainGui.AddButton("x270 y160 w100 h30", "Save")
SaveButton.OnEvent('click', SaveSettings)


MainGui.SetFont("s8 cWhite", "Tahoma")
MainGui.AddText("x1 y210 w448 h20 Right", "- Made by epic - v1.0.5")

MainGui.Show("w450 h240")

SaveSettings(*) {
    global MainGui, URLEdit, DiscordIDEdit
    MainGui.Submit("NoHide")
    IniWrite(URLEdit.Value, "settings.ini", "Settings", "url")
    IniWrite(DiscordIDEdit.Value, "settings.ini", "Settings", "discordID")
    MsgBox "Settings saved!"
    MainGui.Show("w450 h240")
}


Start(*) {
    NoIMGPlayerStatus("Starting v1.0.5 VicHopMacro by epic", 16776960)
    GetServerIds()
    OnError (e, mode) => (mode = "return") * (-1)
    loop {
        MainLoop()
    }
}

StopMacro(*) {
    Send "{" WKey " up}{" AKey " up}{" SKey " up}{" Dkey " up}"
    ExitApp()
}

NoIMGPlayerStatus("Connected to discord!", 3426654)

F1:: {
    NoIMGPlayerStatus("Starting v1.0.5 VicHopMacro by epic", 16776960)
    GetServerIds()
    OnError (e, mode) => (mode = "return") * (-1)
    loop {
        MainLoop()
    }
}
OnError (e, mode) => (mode = "return") * (-1)

F2:: ExitApp()


; assign scan codes to key variables
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


MainLoop() {
    
    while (JoinServer() == 2) {
        Sleep(350)
    }


    if (NightDetection() == 1) {
        PlayerStatus("Night Detected!!", 0, false)
        ZoomOut()
        StartServerLoop()
    } else {
        NoIMGPlayerStatus("Searching For Night Servers.", 1752220)
        return
    }

    KillViciousBees()
    return
}


KillViciousBees() {

    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 16)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
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


    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 16)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    }


    NoIMGPlayerStatus("Going to Mountain Top Feild.", 2067276)
    MountainTop()
    PlayerStatus("Finished Checking Mountain Top Feild.", 5763719, false)
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
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 16)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    }


    NoIMGPlayerStatus("Going to Rose Feild.", 2067276)
    Rose()
    PlayerStatus("Finished Checking Rose Feild.", 5763719, false)
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

    NoIMGPlayerStatus("Going to Cactus Feild.", 2067276)
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    } else if (PictureImageSearch("img\stickbug.png", 16)) {
        PlayerStatus("Leaving server because StickBug confuses VicHopMacro", 2123412, false)
    }
    Cactus()
    PlayerStatus("Finished Checking Cactus feild.", 5763719, false)
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
    GetServerIds()
    NoIMGPlayerStatus("No Vicious bees found...", 8359053)
}

JoinServer() {
    ActivateRoblox()
    SetKeyDelay 100
    send "{esc}{l}{Enter}"
    joinrandomserver()
    if (DetectLoading(0x2257A8, 25000)) {
        Sleep 750
        return 1
    } else {
        return 2
    }
}