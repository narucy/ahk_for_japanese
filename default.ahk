#Requires AutoHotkey v2.0
#SingleInstance

SCREEN_WIDTH := 1920 * 2
SCREEN_HEIGHT := 1080

EDITOR := "C:\Users\Naru41\AppData\Local\Programs\Microsoft VS Code\Code.exe "
; BROWSER := "C:\Program Files\Google\Chrome\Application\chrome.exe --profile-directory=Default "
BROWSER := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe --disable-features=msUndersideButton "

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

SC07B & F10:: {
    Sleep 1000
    SendMessage 0x112, 0xF170, 2, , "Program Manager"
}

SC07B & 1:: Run "C:\Users\Naru41\Downloads"
SC07B & 9:: Run EDITOR . "C:\Users\Naru41\Documents\memo.txt"
SC07B & 0:: Edit

SC07B & g:: Run BROWSER
SC07B & a:: Run BROWSER . "https://www.deepl.com/ja/translator"
SC07B & o:: Run BROWSER . "https://www.weblio.jp"
SC07B & w:: Run BROWSER . "https://ejje.weblio.jp/turbo"

SC07B & n:: Reload

SC07B & i:: WinShift(0, -240)
SC07B & j:: WinShift(-240, 0)
SC07B & k:: WinShift(0, 240)
SC07B & l:: WinShift(240, 0)

SC07B & e:: WinResize(0, -240)
SC07B & s:: WinResize(-240, 0)
SC07B & x:: WinResize(0, 240)
SC07B & d:: WinResize(240, 0)

SC07B & Up:: SoundSetVolume +1
SC07B & Down:: SoundSetVolume -1

SC07B & LButton:: {
    CoordMode "Mouse", "Window"
    MouseGetPos &_, &_, &window_id

    WinActivate "ahk_id " . window_id
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

#HotIf WinActive("ahk_exe SNAP.exe")
MButton:: {
    WinGetPos &_, &_, &width, &height, "A"

    board_width := height * 3 / 4
    x := (width - board_width) / 2 + board_width * 0.85
    y := height * 0.9

    Click x, y
}
#HotIf

WinShift(horizontal, vertical)
{
    WinGetPos &x, &y, &w, &h, "A"
    bw := GetActiveWindowBorderWidth()

    x += horizontal
    if x < 0 {
        x := -bw
    } else if x + w > SCREEN_WIDTH {
        x := SCREEN_WIDTH - w + bw
    } else if x < 1920 && x + w > 1920 {
        if horizontal < 0 {
            x := 1920 - w + bw
        } else {
            x := 1920 - bw
        }
    }

    y += vertical
    if y < 0 {
        y := 0
    } else if y + h + bw > SCREEN_HEIGHT {
        y := SCREEN_HEIGHT - h + bw
    }

    WinMove x, y, w, h, "A"
}

GetActiveWindowBorderWidth()
{
    n := WinGetProcessName("A")
    return n == "msedge.exe" ? 6 : 0
}

WinResize(horizontal, vertical)
{
    WinGetPos &x, &y, &w, &h, "A"
    bw := GetActiveWindowBorderWidth()

    if x < -bw {
        x := -bw
    }
    w += horizontal
    if x + w > SCREEN_WIDTH {
        if w > 1920 {
            w := 1920
        }
        x := SCREEN_WIDTH - w + bw
    }
    if x < 1920 && x + w > 1920 {
        if 1920 - x < x + w - 1920 {
            x := 1920 - bw
        } else {
            x := 1920 - w + bw
        }
    }

    if y < 0 {
        y := 0
    }
    h += vertical
    if y + h + bw > SCREEN_HEIGHT {
        if h + bw > SCREEN_HEIGHT {
            h := SCREEN_HEIGHT + bw
        }
        y := SCREEN_HEIGHT - h + bw
        if y < 0 {
            y := 0
        }
    }

    WinMove x, y, w, h, "A"
}