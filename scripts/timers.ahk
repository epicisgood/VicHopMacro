#Requires AutoHotkey v2.0

nowUnix() {
    return DateDiff(A_NowUTC, "19700101000000", "Seconds")
}

global LastStockings := nowUnix()
global LastFeast := nowUnix()
global LastCandles := nowUnix()
global LastSamovar := nowUnix()
global LastLidArt := nowUnix()

BeesmasChecker() {
    global LastStockings, LastFeast, LastCandles, LastSamovar, LastLidArt

    arraytable := []
    ; 1 = 1s
    StockingsTimer := 3600   ; 1 hour 3600
    FeastTimer := 5400        ; 1.5 hours 5400
    CandlesTimer := 14400     ; 4 hours 14400
    SamovarTimer := 21600     ; 6 hours 21600
    LidArtTimer := 28800      ; 8 hours 28800

    currentTime := nowUnix()

    if (currentTime - LastStockings >= StockingsTimer && BeesmasChecked("Stockings")) {
        ; MsgBox("1 hour has passed since LastStockings")
        LastStockings := currentTime
        arraytable.Push("Stockings")
    }
    if (currentTime - LastFeast >= FeastTimer && BeesmasChecked("Feast")) {
        ; MsgBox("1.5 hours have passed since LastFeast")
        LastFeast := currentTime
        arraytable.Push("Feast")
    }
    if (currentTime - LastCandles >= CandlesTimer && BeesmasChecked("Candles")) {
        ; MsgBox("4 hours have passed since LastCandles")
        LastCandles := currentTime
        arraytable.Push("Candles")
    }
    if (currentTime - LastSamovar >= SamovarTimer && BeesmasChecked("Samovar")) {
        ; MsgBox("6 hours have passed since LastSamovar")
        LastSamovar := currentTime
        arraytable.Push("Samovar")
    }
    if (currentTime - LastLidArt >= LidArtTimer && BeesmasChecked("LidArt")) {
        ; MsgBox("8 hours have passed since LastLidArt")
        LastLidArt := currentTime
        arraytable.Push("LidArt")
    }
    return arraytable
}

BeesmasChecked(value) {
    if (IniRead("settings.ini", "Settings", value) == 1) {
        return true
    }
    return false
}

; Calls BeesmasChecker -> BeesmasChecked functions to see if we are able to run those things
BeesmasInterupt() {
    variable := BeesmasChecker()

    for (k, v in variable) {
        if (v == "Stockings") {
            NoIMGPlayerStatus("Going to collect stockings!", 2067276)
            ResetMainCharacter()
            stockings()
            PlayerStatus("Finished checking stockings!", 5763719, false)
        }
        if (v == "Feast") {
            NoIMGPlayerStatus("Going to collect feast!", 2067276)
            ResetMainCharacter()
            feast()
            PlayerStatus("Finished checking feast!", 5763719, false)
        }
        if (v == "Candles") {
            NoIMGPlayerStatus("Going to collect Candles!", 2067276)
            ResetMainCharacter()
            Candles()
            PlayerStatus("Finished checking candles!", 5763719, false)
        }
        if (v == "Samovar") {
            NoIMGPlayerStatus("Going to collect Samovar!", 2067276)
            ResetMainCharacter()
            Samovar()
            PlayerStatus("Finished checking samovar!", 5763719, false)
        }
        if (v == "LidArt") {
            NoIMGPlayerStatus("Going to collect lidart!", 2067276)
            ResetMainCharacter()
            LidArt()
            PlayerStatus("Finished checking lidart!", 5763719, false)
        }
    }
}
