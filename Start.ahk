#Requires AutoHotkey v2.0
#SingleInstance Force

SetWorkingDir A_ScriptDir

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
MainGui.AddText("x1 y210 w448 h20 Right", "- Made by epic - ")

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
    NoIMGPlayerStatus("Starting Public VicHop Macro by _epic. :)", 16776960)
    loop {
        MainLoop()
    }
}

StopMacro(*) {
    ExitApp()
}

NoIMGPlayerStatus("Connected to discord!", 3426654)

F1:: {
    NoIMGPlayerStatus("Starting Public VicHop Macro by epic 🙂", 16776960)
    OnError (e, mode) => (mode = "return") * (-1)
    loop {
        MainLoop()
    }
}

F2:: ExitApp()




MainLoop() {
    while (JoinServer() == 2){
        Sleep 350
    }


    if (NightDetection() == 1) {
        PlayerStatus("Night Detected!!", 0, false)
        ZoomOut()

        StartServerAttempts := 0
        ServerVar := StartServer()
        while (ServerVar == 3 || ServerVar == 4) {
            StartServerAttempts++
            if StartServerAttempts == 3 {
                PlayerStatus("leaving server could not claim hive current_hive = 0", 8359053, true)
                return
            }

            if ServerVar == 4 {
                PlayerStatus("leaving server reset count went over 4...", 8359053, true)
                return
            }
            ServerVar := StartServer() 
        }
    } else {
        NoIMGPlayerStatus("Searching For Night Servers.", 1752220)
        return
    }

    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }
    KillViciousBees()
    return
}

KillViciousBees() {

    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }
    NoIMGPlayerStatus("Going to Pepper Patch.", 2067276)
    PepperPatch()
    PlayerStatus("Finished Checking Pepper Patch.", 5763719, false)
    if (VicActivated() == 1) {
        PepperAttackVic()
        return
    }
    resetcharattempts := 0
    ResetVar := ResetCharacter()
    while (ResetVar == 2) {
        resetcharattempts++
        if resetcharattempts > 3 {
            return 4
        }
        ResetVar := ResetCharacter()
    }
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }



    NoIMGPlayerStatus("Going to Mountain Top Feild.", 2067276)
    MountainTop()
    PlayerStatus("Finished Checking Mountain Top Feild.", 5763719, false)
    if (VicActivated() == 1) {
        MtnAttackVic()
        return
    }
    resetcharattempts := 0
    ResetVar := ResetCharacter()
    while (ResetVar == 2) {
        resetcharattempts++
        if resetcharattempts > 3 {
            PlayerStatus("leaving server recoonecting count went over 3...", 8359053, true)
            return 4
        }
        ResetVar := ResetCharacter()
    }
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }



    NoIMGPlayerStatus("Going to Rose Feild.", 2067276)
    Rose()
    PlayerStatus("Finished Checking Rose Feild.", 5763719, false)
    if (VicActivated() == 1) {
        AttackVic()
        return
    }
    
    resetcharattempts := 0
    ResetVar := ResetCharacter()
    while (ResetVar == 2) {
        resetcharattempts++
        if resetcharattempts > 3 {
            PlayerStatus("leaving server recoonecting count went over 3...", 8359053, true)
            return 4
        }
        ResetVar := ResetCharacter()
    }



    NoIMGPlayerStatus("Going to Cactus Feild.", 2067276)
    if (CheckIfDefeated() == 1 || VicActivated() == 1) {
        PlayerStatus("Vicious bee has already been defeated...", 2123412, false)
        return
    }
    Cactus()
    PlayerStatus("Finished Checking Cactus feild.", 5763719, false)
    if (VicActivated() == 1) {
        AttackVic()
        return
    }
    NoIMGPlayerStatus("No Vicious bees found...", 8359053)
}

JoinServer() {
    ActivateRoblox()
    RobloxStuff()
    joinrandomserver()
    if (DetectLoading(0x2257A8, 25000)) {
        Sleep 750
        return 1
    } else {
        return 2
    }
}



RobloxStuff(){
    SetKeyDelay 100
    send "{esc}{l}{Enter}"
    Sleep 250

    
}