#Requires AutoHotkey v2.0

version := "v1.1.6"



TraySetIcon("images\stinger.ico")



if (A_IsCompiled) {
	WebViewCtrl.CreateFileFromResource((A_PtrSize * 8) "bit\WebView2Loader.dll", WebViewCtrl.TempDir)
    WebViewSettings := {DllPath: WebViewCtrl.TempDir "\" (A_PtrSize * 8) "bit\WebView2Loader.dll"}
} else {
    WebViewSettings := {}
    TraySetIcon("images\\stinger.ico")
}




MyWindow := WebViewGui("-Resize -Caption ",,,WebViewSettings) ; ignore error it somehow works with it.....
MyWindow.OnEvent("Close", (*) => StopMacro())
MyWindow.Navigate("scripts/Gui/index.html")
; MyWindow.Debug()
MyWindow.AddHostObjectToScript("ButtonClick", { func: WebButtonClickEvent })
MyWindow.AddHostObjectToScript("Save", { func: SaveSettings })
MyWindow.AddHostObjectToScript("ReadSettings", { func: SendSettings })
MyWindow.AddHostObjectToScript("Dragger", { func: BeginDrag })
; MyWindow.Show("w" 650 "h" 465)
screenWidth := A_ScreenWidth
screenHeight := A_ScreenHeight


winHeight := screenHeight * 0.425
if (data.beesmas){
    winHeight := 450
} else {
    winHeight := 410
}

winWidth := 625
MyWindow.Show("w" winWidth " h" winHeight)

Sleep(250)
MyWindow.ExecuteScriptAsync("document.querySelector('#random-message').textContent = '" data.message "'")
MyWindow.ExecuteScriptAsync("document.querySelector('.donate-btn').src = '" data.image "'")

if (data.beesmas){
    MyWindow.ExecuteScriptAsync("document.querySelector('#beesmas').removeAttribute('disabled')")
    MyWindow.ExecuteScriptAsync("document.querySelector('#maintab').removeAttribute('disabled')")
}


GetUpdateData() {
    request := ComObject("WinHttp.WinHttpRequest.5.1")
    request.Open("GET", "https://raw.githubusercontent.com/epicisgood/Vichop-Updater/refs/heads/main/update.json", true)
    request.Send()
    request.WaitForResponse()
    if (request.Status = 200) {
        Response := JSON.Parse(request.ResponseText, true, false)
        return Response
    } else {
        return false
    }
}


BeginDrag(*) {
    DllCall("ReleaseCapture")
    DllCall("SendMessage", "Ptr", MyWindow.Hwnd, "UInt", 0xA1, "UPtr", 2, "UPtr", 0)
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


ResetMacro(*) { 
    SetTimer(ViciousSpawnLocation, 0)
    Send "{" WKey " up}{" AKey " up}{" SKey " up}{" Dkey " up}{F14 up}"
    try Gdip_Shutdown(pToken)
    nm_endWalk()
    try WinClose "ahk_class AutoHotkey ahk_pid " JoinSeverProcesId.pid
    try FileDelete A_ScriptDir "\serverlist.txt"
    try FileDelete A_ScriptDir "\pendingserverlist.txt"
    Reload 
}


StopMacro(*) {
    PlayerStatus("Closed VicHopMacro", "0xff5e00", , false, , false)
    SetTimer(ViciousSpawnLocation, 0)
    Send "{" WKey " up}{" AKey " up}{" SKey " up}{" Dkey " up}{F14 up}"
    try Gdip_Shutdown(pToken)
    nm_endWalk()
    try WinClose "ahk_class AutoHotkey ahk_pid " JoinSeverProcesId.pid
    try FileDelete A_ScriptDir "\serverlist.txt"
    try FileDelete A_ScriptDir "\pendingserverlist.txt"
    ExitApp()
    
}


F1:: {
    Start
}

F2:: {
    ResetMacro
}





WebButtonClickEvent(button) {
	switch button {
		case "Start":
			Send("{F1}")
        case "Stop":
			Send("{F2}")
	}
}



SaveSettings(settings) {
	settings := JSON.parse(settings)

    IniFile := A_ScriptDir . "\settings.ini"

    for key, val in settings {
        IniWrite(val, IniFile, "Settings", key)
    }
	Reload	
}

SendSettings(){
	settingsFile := A_ScriptDir . "\settings.ini"

    if (!FileExist(settingsFile)) {
        IniWrite("", settingsFile, "Settings", "url")
        IniWrite("", settingsFile, "Settings", "discordID")
        IniWrite("", settingsFile, "Settings", "movespeed")
        IniWrite(1, settingsFile, "Settings", "Stockings")
        IniWrite(1, settingsFile, "Settings", "Feast")
        IniWrite(1, settingsFile, "Settings", "Candles")
        IniWrite(1, settingsFile, "Settings", "Samovar")
        IniWrite(1, settingsFile, "Settings", "LidArt")

    }
	
    SettingsJson := { 
      url:                  IniRead(settingsFile, "Settings", "url")
    , discordID:            IniRead(settingsFile, "Settings", "discordID")
    , MoveSpeed:            IniRead(settingsFile, "Settings", "movespeed")
    , Stockings:            IniRead(settingsFile, "Settings", "Stockings")
    , Feast:                IniRead(settingsFile, "Settings", "Feast")
    , Candles:              IniRead(settingsFile, "Settings", "Candles")
    , Samovar:              IniRead(settingsFile, "Settings", "Samovar")
    , LidArt:               IniRead(settingsFile, "Settings", "LidArt")
    
    }
	Sleep(200)
	MyWindow.PostWebMessageAsJson(JSON.stringify(SettingsJson))
}

SendSettings()



url := IniRead(settingsFile, "Settings", "url")
discordID := IniRead(settingsFile, "Settings", "discordID")
MoveSpeed := IniRead(settingsFile, "Settings", "movespeed")
IniStockings := IniRead(settingsFile, "Settings", "Stockings")
IniFeast := IniRead(settingsFile, "Settings", "Feast")
IniCandles := IniRead(settingsFile, "Settings", "Candles")
IniSamovar := IniRead(settingsFile, "Settings", "Samovar")
IniLidArt := IniRead(settingsFile, "Settings", "LidArt")




PlayerStatus("Connected to discord!", "0x34495E", , false, , false)






















AsyncHttpRequest(method, url, func?, headers?) {
	req := ComObject("Msxml2.XMLHTTP")
	req.open(method, url, true)
	if IsSet(headers)
		for h, v in headers
			req.setRequestHeader(h, v)
	if IsSet(func)
		req.onreadystatechange := func.Bind(req)
	req.send()
}


CheckUpdate(req)
{

	if (req.readyState != 4)
		return

	if (req.status = 200)
	{
		LatestVer := Trim((latest_release := JSON.parse(req.responseText))["tag_name"], "v")
        
		if (VerCompare(version, LatestVer) < 0)
		{

            message := "
            (
            A new update is available!

            Would you like to open the GitHub release page
            to download the latest version?

            )"

            if (MsgBox(message, "Update Available", 0x40004 | 0x40 | 0x4 ) = "Yes")
            {
                Run "https://github.com/epicisgood/VicHopMacro/releases/latest"
            }

        }
	}
}


AsyncHttpRequest("GET", "https://api.github.com/repos/epicisgood/VicHopMacro/releases/latest", CheckUpdate, Map("accept", "application/vnd.github+json"))