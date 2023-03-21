#Requires AutoHotkey v2.0
#SingleInstance

SCREEN_WIDTH := 1920
SCREEN_HEIGHT := 1080

EDITOR := "C:\Users\Naru41\AppData\Local\Programs\Microsoft VS Code\Code.exe "
BROWSER := "C:\Program Files\Google\Chrome\Application\chrome.exe --profile-directory=Default "

sc079:: LButton
sc070:: RButton

^i:: Up
^l:: Right
^k:: Down
^j:: Left
^h:: BackSpace
^m:: Enter

+^i:: ^i
+^l:: ^l
+^k:: ^k
+^j:: ^j
+^h:: ^h
+^m:: ^m

SC07B & F12:: {
    Sleep 1000
    SendMessage 0x112, 0xF170, 2, , "Program Manager"
}

SC07B & 1:: Run "C:\Users\Naru41\Downloads"
SC07B & 9:: Run EDITOR . "C:\Users\Naru41\Documents\memo.txt"

SC07B & g:: Run BROWSER
SC07B & t:: Run BROWSER . "https://www.deepl.com/ja/translator"
SC07B & o:: Run BROWSER . "https://www.weblio.jp"

SC07B & n:: Reload

SC07B & i:: WinShift(0, -200)
SC07B & j:: WinShift(-200, 0)
SC07B & k:: WinShift(0, 200)
SC07B & l:: WinShift(200, 0)

SC07B & e:: WinResize(0, -200)
SC07B & s:: WinResize(-200, 0)
SC07B & x:: WinResize(0, 200)
SC07B & d:: WinResize(200, 0)

SC07B & Up:: SoundSetVolume +1
SC07B & Down:: SoundSetVolume -1

SC07B & LButton:: {
    CoordMode "Mouse", "Window"
    MouseGetPos &_, &_, &window_id

    WinActivate "ahk_id" . window_id
    MouseGetPos &x, &y

    CoordMode "Mouse", "Screen"
    SetWinDelay 0
    loop {
        ; exit the loop if the left mouse button was released
        if !GetKeyState("LButton", "P") {
            break
        }

        ; move the window based on cursor position
        MouseGetPos &xx, &yy
        WinMove (xx - x), (yy - y), , , "A"
    }
}

#HotIf WinActive("ahk_exe Hearthstone.exe")
MButton:: {
    WinGetPos &_, &_, &width, &height, "A"

    board_width := (height / 3 * 4)
    x := (width - board_width) / 2 + board_width * 0.9
    y := height * 0.45

    Click x, y
}
#HotIf

WinShift(horizontal, vertical)
{
    WinGetPos &x, &y, &w, &h, "A"

    x += horizontal
    if x < 0 {
        x := 0
    } else if x + w > SCREEN_WIDTH {
        x := SCREEN_WIDTH - w
    }
    y += vertical
    if y < 0 {
        y := 0
    } else if y + h > SCREEN_HEIGHT {
        y := SCREEN_HEIGHT - h
    }

    WinMove x, y, w, h, "A"
}

WinResize(horizontal, vertical)
{
    WinGetPos &x, &y, &w, &h, "A"

    if x < 0 {
        x := 0
    }
    w += horizontal
    if x + w > SCREEN_WIDTH {
        if w > SCREEN_WIDTH {
            w := SCREEN_WIDTH
        }
        x := SCREEN_WIDTH - w
    }

    if y < 0 {
        y := 0
    }
    h += vertical
    if y + h > SCREEN_HEIGHT {
        if y := SCREEN_HEIGHT {
            h := SCREEN_HEIGHT
        }
        y := SCREEN_HEIGHT - h
    }

    WinMove x, y, w, h, "A"
}