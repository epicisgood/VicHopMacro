PepperPatch() {
    SetKeyDelay 0, 50
    HyperSleep(300)
    Send "{" DKey " down}"
    HyperSleep(250)
    Send "{" SpaceKey " up}"
    HyperSleep(2300)
    Send "{" DKey " up}"
    ;; 35 bee zone still at ground

    Send "{" WKey " down}"
    HyperSleep(400)
    Send "{" WKey " up}"
    HyperSleep(100)
    Send "{" SKey " down}"
    HyperSleep(350)
    Send "{" SKey " up}"
    HyperSleep(100)

    ;; jumping into it
    Send "{" DKey " down}{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}"
    Send "{" WKey " down}"
    HyperSleep(300)
    Send "{" WKey " up}"
    HyperSleep(200)
    Send "{" DKey " up}"

    ;; second platform
    Send "{" WKey " down}"
    HyperSleep(600)
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" WKey " up}{" SpaceKey " up}"
    ;; correction to not bug out
    Send "{" WKey " down}"
    Send "{" AKey " down}"
    HyperSleep(500)
    Send "{" AKey " up}"
    HyperSleep(1700)
    Send "{" WKey " up}"
    Send "{" DKey " down}"
    HyperSleep(500)
    Send "{" DKey " up}"

    ;; STUPID JUMP TO FIX BROOO
    Send "{" SpaceKey " down}{" WKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}{" WKey " up}"
    HyperSleep(300)
    Send "{" SpaceKey " down}{" AKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}{" AKey " up}"
    HyperSleep(300)

    Send "{" SpaceKey " down}{" WKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}{" WKey " up}"
    HyperSleep(500)
    Send "{" SpaceKey " down}{" WKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}{" WKey " up}"
    PlayerStatus("Debugging pepper patch lmk if this breaks", 7419530, false)

    Send "{" WKey " down}"
    HyperSleep(1300)
    Send "{" SpaceKey " down}"
    HyperSleep(200)
    Send "{" SpaceKey " up}"
    HyperSleep(300)
    Send "{" WKey " up}"
    ;; Move to pepper field from next to coconut
    Send "{" WKey " down}"
    Send "{" DKey " down}"
    HyperSleep(1600)
    Send "{" WKey " up}"
    Send "{" DKey " up}"
    Send "{" DKey " down}"
    HyperSleep(1200)
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
    HyperSleep 1300
    Send "{" DKey " up}"

    ;; jump to field
    Send "{" SpaceKey " down}"
    Send "{" DKey " down}{" Skey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
    HyperSleep(300)
    Send "{" Skey " up}"
    HyperSleep(500)
    Send "{" DKey " up}"
    ;; Search vicious bee at pepper field

    Send "{" WKey " down}"
    HyperSleep(1600)
    HyperSleep(650)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    HyperSleep(700)
    Send "{" DKey " up}"

    ;; pollen detection here or smth
    Send "{" SKey " down}"
    HyperSleep(1600)
    HyperSleep(650)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    HyperSleep(700)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    HyperSleep(1600)
    HyperSleep(650)
    Send "{" WKey " up}"
}

MountainTop() {
    SetKeyDelay 0, 50
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(3500)

    Send "{" WKey " down}"
    HyperSleep(1700)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    HyperSleep(750)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    HyperSleep(2300)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    HyperSleep(1500)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    HyperSleep(1500)
    HyperSleep(750)
    Send "{" WKey " up}"
}

Rose() {
    SetKeyDelay 50, 50
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(230)

    Send "{" DKey " down}"
    Send "{" SpaceKey " down}"
    HyperSleep(25)
    Send "{" SpaceKey " up}"
    Send "{" SpaceKey " down}"
    HyperSleep(25)
    Send "{" SpaceKey " up}"
    HyperSleep(500)
    Send "{" DKey " up}"

    HyperSleep(3000)

    Send "{" SpaceKey " down}"
    HyperSleep(50)
    Send "{" SpaceKey " up}"

    ;; Search for vicious bee

    HyperSleep(500)
    Send "{" AKey " down}"
    HyperSleep(1700)
    HyperSleep(1100)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    HyperSleep(600)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    HyperSleep(1700)
    HyperSleep(1100)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    HyperSleep(600)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    HyperSleep(1700)
    HyperSleep(1100)
    Send "{" AKey " up}"
}

Cactus() {
    SetKeyDelay 50, 50
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    ;; Glide to cactus
    HyperSleep(750)
    Send "{" DKey " down}"
    Send "{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}"
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
    HyperSleep(1500)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    HyperSleep(400)
    Send "{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}"
    Send "{" SKey " up}"

    ;; Landed at cactus field
    HyperSleep(2000)

    Send "{" DKey " down}"
    HyperSleep(2600)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    HyperSleep(500)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    HyperSleep(2600)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    HyperSleep(500)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    HyperSleep(2600)
    Send "{" DKey " up}"
}
