PepperPatch() {
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
    ;; correction to not bug out
    Send "{" WKey " down}"
    Send "{" AKey " down}"
    Walk(3)
    Send "{" AKey " up}"
    Walk(19)
    Send "{" WKey " up}"
    Send "{" DKey " down}"
    Walk(6)
    Send "{" DKey " up}"

    ;; Jump part
    Send "{" SpaceKey " down}{" WKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Hypersleep(600)
    Send "{" SpaceKey " down}{" WKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Hypersleep(600)

    Send "{" SpaceKey " down}{" WKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Hypersleep(600)
    Send "{" SpaceKey " down}{" WKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}{" WKey " up}"
    Hypersleep(600)

    ; PlayerStatus("Debugging pepper patch lmk if this breaks", 7419530, false)
    Send "{" WKey " down}"
    Walk(16)
    Send "{" SpaceKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"
    Walk(3)
    Send "{" WKey " up}"

    ; Move to pepper field from next to coconut
    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Walk(20)
    Send "{" WKey " up}"
    Send "{" DKey " up}"
    Send "{" SpaceKey " down}"
    Send "{" DKey " down}"
    Walk(2)
    Send "{" SpaceKey " up}"
    Walk(20)
    Send "{" DKey " up}"

    ;; jump to field

    Send "{" SpaceKey " down}"
    Send "{" DKey " down}"
    Walk(1)
    Send "{" SpaceKey " up}"
    Walk(8)
    Send "{" DKey " up}"
    Walk(2)
    Send "{" SKey " down}"
    Walk(7)
    Send "{" SKey " up}"
    ;; at feild
    Send "{" WKey " down}"
    Walk(16)
    Walk(5)
    Send "{" WKey " up}"

    Send "{" DKey " down}"
    Walk(5)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Walk(16)
    Walk(6)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Walk(5)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Walk(16)
    Walk(6)
    Send "{" WKey " up}"
}


MountainTop() {
    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"
    HyperSleep(3500)

    Send "{" WKey " down}"
    Walk(15)
    Send "{" WKey " up}"

    Send "{" AKey " down}"
    Walk(6)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Walk(20)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Walk(12)
    Send "{" DKey " up}"

    Send "{" WKey " down}"
    Walk(18)
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
    Walk(17)
    Walk(9)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Walk(5)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Walk(17)
    Walk(9)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Walk(5)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Walk(17)
    Walk(9)
    Send "{" AKey " up}"
    SetKeyDelay 50
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
    Walk(24)
    Send "{" DKey " up}"

    Send "{" SKey " down}"
    Walk(4)
    Send "{" SKey " up}"

    Send "{" AKey " down}"
    Walk(24)
    Send "{" AKey " up}"

    Send "{" SKey " down}"
    Walk(4)
    Send "{" SKey " up}"

    Send "{" DKey " down}"
    Walk(24)
    Send "{" DKey " up}"
    SetKeyDelay 50
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
    Walk(5)
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
    Walk(4)
    Send "{" SKey " up}"
    Send "{" DKey " up}"

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

    Send "{" WKey " down}"
    Send "{" DKey " down}"
    Walk(3)
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
    walk(11)
    Send "{" WKey " up}"

    Send "{" RotLeft " 2}"
    Send "{" WKey " down}"
    Walk(17)
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
    Walk(6.8)
    Send "{" SKey " up}"

    Send "{" EKey " down}"
    HyperSleep(100)
    Send "{" EKey " up}"

    HyperSleep(4000)

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

