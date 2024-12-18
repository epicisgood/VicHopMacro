; This is all for beesmas 2024 will remain here incase this macro will be used again in "next" beesmas if it ever happens lol!
; it did happen wow 12/17/2024 
nowUnix() {
    return DateDiff(A_NowUTC, "19700101000000", "Seconds")
}

LastStockings := nowUnix()
LastFeast := nowUnix()
LastCandles := nowUnix()
LastSamovar := nowUnix()
LastLidArt := nowUnix()

BeesmasChecker() {
    global LastStockings, LastFeast, LastCandles, LastSamovar, LastLidArt

    Beesmaslist := []
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
        Beesmaslist.Push("Stockings")
    }
    if (currentTime - LastFeast >= FeastTimer && BeesmasChecked("Feast")) {
        ; MsgBox("1.5 hours have passed since LastFeast")
        LastFeast := currentTime
        Beesmaslist.Push("Feast")
    }
    if (currentTime - LastCandles >= CandlesTimer && BeesmasChecked("Candles")) {
        ; MsgBox("4 hours have passed since LastCandles")
        LastCandles := currentTime
        Beesmaslist.Push("Candles")
    }
    if (currentTime - LastSamovar >= SamovarTimer && BeesmasChecked("Samovar")) {
        ; MsgBox("6 hours have passed since LastSamovar")
        LastSamovar := currentTime
        Beesmaslist.Push("Samovar")
    }
    if (currentTime - LastLidArt >= LidArtTimer && BeesmasChecked("LidArt")) {
        ; MsgBox("8 hours have passed since LastLidArt")
        LastLidArt := currentTime
        Beesmaslist.Push("LidArt")
    }
    return Beesmaslist
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
            PlayerStatus("Going to collect stockings!", "0x1F8B4C", , false, , false)
            ResetCharacterLoop()
            stockings()
            PlayerStatus("Finished collecting stockings!", "0x57F287", , false)

        }
        if (v == "Feast") {
            PlayerStatus("Going to collect feast!", "0x1F8B4C", , false, , false)
            ResetCharacterLoop()
            feast()
            PlayerStatus("Finished collecting feast!", "0x57F287", , false)

        }
        if (v == "Candles") {
            PlayerStatus("Going to collect Candles!", "0x1F8B4C", , false, , false)
            ResetCharacterLoop()
            Candles()
            PlayerStatus("Finished collecting candles!", "0x57F287", , false)

        }
        if (v == "Samovar") {
            PlayerStatus("Going to collect Samovar!", "0x1F8B4C", , false, , false)
            ResetCharacterLoop()
            Samovar()
            PlayerStatus("Finished collecting samovar!", "0x57F287", , false)

        }
        if (v == "LidArt") {
            PlayerStatus("Going to collect lidart!", "0x1F8B4C", , false, , false)
            ResetCharacterLoop()
            LidArt()
            PlayerStatus("Finished collecting lidart!", "0x57F287", , false)

        }
    }
}
