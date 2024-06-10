ImagePath := "Hive.png"
WinGet, RobloxWindowID, ID, ahk_class WINDOWSCLIENT

if RobloxWindowID
{
    WinGetPos, RobloxX, RobloxY, RobloxWidth, RobloxHeight, ahk_id %RobloxWindowID%
    Sleep, 1000

    ImageSearch, FoundX, FoundY, RobloxX, RobloxY, RobloxWidth, RobloxHeight, *32 %ImagePath%

    if ErrorLevel = 0
    {
        send {e down}
        Sleep, 200
        Send, {e up}
    }
}