PepperPatch() {
    nm_Walk(25, DKey)
    Send "{" DKey " down}{" SpaceKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"
    nm_Walk(4, WKey)
    Walk(5)
    Send "{" DKey " up}"

    nm_Walk(2, WKey, DKey)
    Walk(3)
    Send "{" WKey " up}"

    Send "{" WKey " down}{" SpaceKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"

    ;; Correction to not bug out
    Send "{" AKey " down}"
    Walk(3)
    Send "{" AKey " up}"
    Walk(19)
    Send "{" WKey " up}"
    nm_Walk(6, DKey)

    ;; Jump part
    nm_Walk(2, WKey, SpaceKey)
    Hypersleep(600)
    nm_Walk(2, WKey, SpaceKey)
    Hypersleep(600)

    nm_Walk(2, WKey, SpaceKey)
    Hypersleep(600)
    nm_Walk(2, WKey, SpaceKey)
    Hypersleep(600)

    Send "{" WKey " down}"
    Walk(10)
    nm_Walk(2, SpaceKey)
    Walk(3)
    Send "{" WKey " up}"

    ;; Move to pepper field from next to coconut
    nm_Walk(30, DKey)
    PressSpace()
    nm_Walk(6, WKey)

    PressSpace()
    nm_Walk(9, DKey)

    ;; At field
    nm_Walk(19, WKey)
    nm_Walk(5, DKey)
    nm_Walk(19, SKey)
    nm_Walk(5, DKey)
    nm_Walk(19, WKey)
}

PepperToCannon() {
    Send "{" RotLeft " 4}"
    nm_Walk(29, WKey)
    nm_Walk(10, AKey)
    nm_Walk(20, Dkey)
    nm_Walk(3, SKey)

    nm_Walk(3, Dkey)
    glider()

    Send "{" Dkey " down}{" WKey " down}"
    HyperSleep(2500)
    Send "{" WKey " up}"
    HyperSleep(500)
    Send "{" Dkey " up}"

    PressSpace()
    Send "{" RotRight " 4}"

}

; we should probably check if the player died during searching
MountainTop() {
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(3500)

    nm_Walk(15, WKey)
    nm_Walk(5, AKey)
    nm_Walk(20, SKey)
    nm_Walk(11, DKey)
    nm_Walk(18, WKey)
}

MountainToCactus() {
    nm_Walk(15, WKey)
    nm_Walk(15, Dkey)
    nm_Walk(3, WKey)
    glider()
    HyperSleep(200)
    Send "{" DKey " down}"
    HyperSleep(1900)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    HyperSleep(300)
    Send "{" SKey " up}"

    PressSpace()

    nm_Walk(10,AKey)
    nm_Walk(7,SKey)
    nm_Walk(3,WKey)
    nm_Walk(5,Dkey)

    nm_Walk(24, DKey)
    nm_Walk(4, SKey)
    nm_Walk(24, AKey)
    nm_Walk(4, SKey)
    nm_Walk(24, DKey)
}

CactusToRose() {
	nm_Walk(7, WKey)
	nm_Walk(8, Dkey)
	nm_Walk(10, WKey)
	nm_Walk(13, AKey)

	nm_Walk(17,Dkey)
    Send "{" WKey " down}"
	HyperSleep(1000)
    glider()
    HyperSleep(4000)
    Send "{" WKey " up}"

    nm_Walk(16, Dkey)
    nm_Walk(5, SKey)

    ; rose pathing
    nm_Walk(25, AKey)
    nm_Walk(4, SKey)
    nm_Walk(24, DKey)
    nm_Walk(4, SKey)
    nm_Walk(24, AKey)
}
Rose() {
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
    nm_Walk(26, AKey)
    nm_Walk(5, SKey)
    nm_Walk(26, DKey)
    nm_Walk(5, SKey)
    nm_Walk(26, AKey)
}

Cactus() {
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
    HyperSleep(550)
    Send "{" SpaceKey " down}"
    HyperSleep(300)
    Send "{" SpaceKey " up}"
    Send "{" SKey " up}"

    ;; Landed at cactus field
    HyperSleep(2000)

    nm_Walk(24, DKey)
    nm_Walk(4, SKey)
    nm_Walk(24, AKey)
    nm_Walk(4, SKey)
    nm_Walk(24, DKey)

}

Samovar() {
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" AKey " down}"
    HyperSleep(1600) ; glide timing
    glider()
    HyperSleep(4500)
    Send "{" AKey " up}"
    Send "{" SpaceKey " 1}"
    HyperSleep(2000)

    Send "{" SKey " down}"
    Walk(40)
    Send "{" SKey " up}"

    Send "{" SpaceKey " down}{" SKey " down}"
    HyperSleep(50)
    Send "{" SpaceKey " up}"
    Walk(20)
    Send "{" AKey " down}"
    Walk(10)
    Send "{" SKey " up}{" AKey " up}"

    Send "{" SpaceKey " down}{" SKey " down}"
    Walk(3)
    Send "{" SpaceKey " up}"
    Walk(6)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Walk(5)
    Send "{" AKey " up}"

    Send "{" EKey " down}"
    HyperSleep(50)
    Send "{" EKey " up}"

    HyperSleep(5000)
    Send "{" RotLeft " 1}"  ; <--- , key (turn left)

    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Walk(3)
    Send "{" WKey " up}"
    Send "{" DKey " up}"

    Send "{" DKey " down}"
    Send "{" SKey " down}"
    Walk(3)
    Send "{" DKey " up}"
    Send "{" SKey " up}"

    Send "{" SKey " down}"
    Send "{" AKey " down}"
    Walk(3)
    Send "{" SKey " up}"
    Send "{" AKey " up}"

    Send "{" AKey " down}"
    Send "{" WKey " down}"
    Walk(3)
    Send "{" AKey " up}"
    Send "{" WKey " up}"
}

feast() {
    HyperSleep(100)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    Send "{" DKey " down}"
    HyperSleep(750) ; 1175 to 975
    glider()
    HyperSleep(650)
    Send "{" DKey " up}"
    Send "{" SKey " down}"
    HyperSleep(750)
    Send "{" SKey " up}"
    Send "{" SpaceKey " 1}"
    HyperSleep(1000)
    Send "{" AKey " down}"
    Walk(10)
    Send "{" AKey " up}"

    Send "{" WKey " down}"
    Walk(15)
    Send "{" WKey " up}"

    Send "{" Dkey " down}"
    Walk(12)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    Walk(6)
    Send "{" SpaceKey " down}"
    HyperSleep(200)
    Send "{" SpaceKey " up}"
    Send "{" SKey " up}"
    HyperSleep(500)

    Send "{" SKey " down}"
    Walk(3)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Walk(2)
    Send "{" AKey " up}"
    ;; Claim Feist
    Send "{" EKey " 1}"
    HyperSleep(6000)
    ;; landed
    Send "{" RotLeft " 1}"
    Send "{" WKey " down}"
    Walk(1)
    Send "{" WKey " up}"

    Send "{" SKey " down}"
    Send "{" DKey " down}"
    Walk(2)
    Send "{" SKey " up}"
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Send "{" AKey " down}"
    Walk(2)
    Send "{" SKey " up}"
    Send "{" AKey " up}"

    Send "{" AKey " down}"
    Send "{" WKey " down}"
    Walk(2)
    Send "{" AKey " up}"
    Send "{" WKey " up}"

    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Walk(2)
    Send "{" WKey " up}"
    Send "{" DKey " up}"
    HyperSleep(1000)
}

stockings() {
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    Send "{" AKey " down}"
    HyperSleep(750) ; gliding timing 700 worked fine ig
    glider()
    HyperSleep(500)
    Send "{" WKey " down}"
    HyperSleep(7500)
    Send "{" AKey " up}{" WKey " up}"

    Send "{" Dkey " down}"
    Walk(26)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    Walk(5)
    Send "{" SKey " up}"

    Send "{" Dkey " down}"
    Walk(5.5)
    Send "{" Dkey " up}"
    HyperSleep(3000)
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    Send "{" WKey " down}"
    Walk(3)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Walk(3)
    Send "{" AKey " up}"
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"
    HyperSleep(500)

    Send "{" Dkey " down}"
    Walk(6)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    Walk(2)
    Send "{" SKey " up}"

    HyperSleep(500)
    Send "{" SpaceKey " down}"
    HyperSleep(100)
    Send "{" SpaceKey " up}"

    HyperSleep(1000)
}

Candles() {
    Send "{" DKey " down}"
    Walk(25)
    Send "{" DKey " up}"

    Send "{" DKey " down}{" SpaceKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"
    Send "{" WKey " down}"
    Walk(4)
    Send "{" WKey " up}"
    Walk(5)
    Send "{" DKey " up}"

    Send "{" WKey " down}{" DKey " down}"
    Walk(2)
    Send "{" DKey " up}"
    Walk(3)
    Send "{" WKey " up}"

    Send "{" WKey " down}{" SpaceKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"
    Walk(3)
    Send "{" WKey " up}"

    Send "{" RotLeft " 4}"

    Send "{" WKey " down}"
    Walk(1)
    glider()
    walk(9)
    Send "{" WKey " up}"

    Send "{" RotLeft " 2}"
    Send "{" WKey " down}"
    Walk(16)
    Send "{" WKey " up}"

    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(5000)

    Send "{" WKey " down}"
    Walk(2)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Walk(4)
    Send "{" AKey " up}"
    Send "{" Dkey " down}"
    Walk(8)
    Send "{" Dkey " up}"

    HyperSleep(2000)
}

LidArt() {
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(3500)

    Send "{" RotLeft " 4}"

    Send "{" WKey " down}"
    Walk(15)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Walk(16)
    Send "{" AKey " up}"

    Send "{" Dkey " down}"
    Walk(5)
    Send "{" Dkey " up}"

    Send "{" WKey " down}"
    loop 7 {
        Walk(2)
        glider()
        Walk(2)
    }
    Walk(10)
    Send "{" WKey " up}"

    Send "{" SKey " down}"
    Walk(7)
    Send "{" SKey " up}"

    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(4000)

    Send "{" SKey " down}"
    Send "{" DKey " down}"
    Walk(1.7)
    Send "{" SKey " up}"
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Send "{" AKey " down}"
    Walk(1.7)
    Send "{" SKey " up}"
    Send "{" AKey " up}"

    Send "{" AKey " down}"
    Send "{" WKey " down}"
    Walk(2)
    Send "{" AKey " up}"
    Send "{" WKey " up}"

    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Walk(2)
    Send "{" WKey " up}"
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    walk(1)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    walk(3)
    Send "{" AKey " up}"
    Send "{" SKey " down}"
    Walk(1)
    Send "{" SKey " up}"
    Send "{" Dkey " down}"
    walk(5)
    Send "{" Dkey " up}"

    Send "{" SKey " down}"
    Walk(1)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    walk(5)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Walk(1)
    Send "{" SKey " up}"

    Send "{" Dkey " down}"
    walk(5)
    Send "{" Dkey " up}"

}
