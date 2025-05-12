#Requires AutoHotkey v2.0

version := "v1.1.5"
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

TraySetIcon("images\stinger.ico")

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
MainGui.OnEvent("Close", StopMacro)
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

; when no beesmas comment this out 

; MainGui.SetFont("s10 cWhite", "Tahoma")
; MainGui.AddText("x10 y180 w60 h20", "Stockings:")
; StockingsCheckbox := MainGui.AddCheckbox("x80 y180", IniStockings = 1)
; StockingsCheckbox.Value := IniStockings

; MainGui.AddText("x120 y180 w40 h20", "Feast:")
; FeastCheckbox := MainGui.AddCheckbox("x170 y180", IniFeast = 1)
; FeastCheckbox.Value := IniFeast

; MainGui.AddText("x210 y180 w50 h20", "Candles:")
; CandlesCheckbox := MainGui.AddCheckbox("x270 y180", IniCandles = 1)
; CandlesCheckbox.Value := IniCandles

; MainGui.AddText("x310 y180 w60 h20", "Samovar:")
; SamovarCheckbox := MainGui.AddCheckbox("x380 y180", IniSamovar = 1)
; SamovarCheckbox.Value := IniSamovar

; MainGui.AddText("x175 y210 w60 h20 Center", "LidArt:")
; LidArtCheckbox := MainGui.AddCheckbox("x235 y210", IniLidArt = 1)
; LidArtCheckbox.Value := IniLidArt

; StartButton := MainGui.AddButton("x10 y240 w80 h30", "Start (F1)")
; StopButton := MainGui.AddButton("x100 y240 w80 h30", "Stop (F2)")
; StartButton.OnEvent('click', Start)
; StopButton.OnEvent('click', StopMacro)


StartButton := MainGui.AddButton("x10 y220 w80 h30", "Start (F1)")
StopButton := MainGui.AddButton("x100 y220 w80 h30", "Stop (F2)")
StartButton.OnEvent('click', Start)
StopButton.OnEvent('click', StopMacro)

SaveButton := MainGui.AddButton("x340 y220 w100 h30", "Save")
SaveButton.OnEvent('click', SaveSettings)

MainGui.SetFont("s8 cWhite", "Tahoma")
MainGui.AddText("x1 y270 w448 h20 Right", "- Made by epic - " version)

; MainGui.Show("w450 h320")
MainGui.Show("w450 h300")

SaveSettings(*) {
    global MainGui, URLEdit, DiscordIDEdit, MovespeedEdit 
    ; StockingsCheckbox, FeastCheckbox, CandlesCheckbox, SamovarCheckbox, LidArtCheckbox
    MainGui.Submit("NoHide")
    IniWrite(URLEdit.Value, "settings.ini", "Settings", "url")
    IniWrite(DiscordIDEdit.Value, "settings.ini", "Settings", "discordID")
    IniWrite(MovespeedEdit.Value, "settings.ini", "Settings", "movespeed")
    ; IniWrite(StockingsCheckbox.Value, "settings.ini", "Settings", "Stockings")
    ; IniWrite(FeastCheckbox.Value, "settings.ini", "Settings", "Feast")
    ; IniWrite(CandlesCheckbox.Value, "settings.ini", "Settings", "Candles")
    ; IniWrite(SamovarCheckbox.Value, "settings.ini", "Settings", "Samovar")
    ; IniWrite(LidArtCheckbox.Value, "settings.ini", "Settings", "LidArt")
    MsgBox "Settings saved!"
    reload
}

Start(*) {
    PlayerStatus("Starting " version " VicHopMacro by epic", "0xFFFF00", , false, , false)
    CloseRoblox()
    GetServerIds(2)
    OnError (e, mode) => (mode = "return") * (-1)
    loop {
        MainLoop()
    }
}
StopMacro(*) {
    SetTimer(ViciousSpawnLocation, 0)
    Send "{" WKey " up}{" AKey " up}{" SKey " up}{" Dkey " up}{F14 up}"
    try Gdip_Shutdown(pToken)
    nm_endWalk()
    try WinClose "ahk_class AutoHotkey ahk_pid " JoinSeverProcesId.pid
    try FileDelete A_ScriptDir "\serverlist.txt"
    try FileDelete A_ScriptDir "\pendingserverlist.txt"
    ExitApp()
    
}

PlayerStatus("Connected to discord!", "0x34495E", , false, , false)

F1:: {
    Start
}

F2:: {
    StopMacro
}
