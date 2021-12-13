#NoEnv
#SingleInstance Force
#InstallKeybdHook
#InstallMouseHook
SendMode Input
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
SetTitleMatchMode, 3   ; A window's title must exactly match WinTitle to be a match

; =====================================================================
; Auto-execute section

initExpeditions()

return
; =====================================================================
; Context-sensitive bindings (only in Genshin Impact)
#If WinActive("ahk_class UnityWndClass") and WinActive("Genshin Impact")

XButton2::w
WheelLeft::clickAtAndReturnCursorPosition(145, 1071)   ; Left arrow in menus
WheelRight::clickAtAndReturnCursorPosition(3679, 1071)   ; Right arrow in menus

NumpadMult::spamAttack()
NumpadDiv::selectAndUseTeleportOnMap()

Numpad3::toggleArtifactLock()
Numpad4::switchGroup(-1)
Numpad5::switchGroup(1)
Numpad6::switchGroup(2)
Numpad8::bpCollectExp()
Numpad9::bpCollectRewards()

Numpad7::collectAndResendExpeditions()

!NumpadDot::exitGameAndScript()

#If
; =====================================================================

^NumpadDot::Reload

; =====================================================================

clickAtAndReturnCursorPosition(clickX, clickY) {
    MouseGetPos, currentX, currentY
    MouseClick, left, clickX, clickY
    Sleep, 150
    MouseMove, %currentX%, %currentY%
}

; =====================================================================

spamAttack() {
    while (GetKeyState("NumpadMult", "P")) {
        MouseClick, left
        Sleep, 150
    }
}

selectAndUseTeleportOnMap() {
    MouseClick, left
    Sleep, 300
    MouseClick, left, 3361, 2007   ; Teleport button
}

; =====================================================================

toggleArtifactLock() {
    MouseGetPos, x, y
    
    MouseClick, left, 3555, 375   ; Lock/Unlock artifact button [artifact name fits to 1 line]
    Sleep, 200
    MouseClick, left, 3555, 455   ; Lock/Unlock artifact button [artifact name fits to 2 lines]
    Sleep, 200
    MouseClick, left, 3555, 535   ; Lock/Unlock artifact button [artifact name fits to 3 lines]
    Sleep, 200
    
    MouseMove, %x%, %y%
}

switchGroup(shiftValue) {
    Send, {SC026}   ; L key
    Sleep, 3500
    
    while (shiftValue != 0) {
        if (shiftValue > 0) {
            MouseClick, left, 3679, 1071   ; Right arrow - next group
            shiftValue--
        } else {
            MouseClick, left, 145, 1071   ; Left arrow - previous group
            shiftValue++
        }
        Sleep, 600
    }
    
    MouseClick, left, 3381, 2039
    Sleep, 1000
    Send, {Esc}
}



bpCollectExp() {
    Send, {F4}
    Sleep, 1000
    MouseClick, left, 3679, 1071   ; Right arrow - to BP exp screen
    Sleep, 500
    MouseClick, left, 3475, 1942   ; Collect all exp
}

bpCollectRewards() {
    MouseClick, left, 145, 1071   ; Left arrow - to BP rewards screen
    Sleep, 500
    MouseClick, left, 3475, 1942   ; Collect all rewards
    Sleep, 2000
    Send, {Esc}
    Sleep, 500
    Send, {Esc}
}

; =====================================================================

exitGameAndScript() {
    Send, {Esc}
    Sleep, 2000
    MouseClick, left, 83, 2047   ; Exit game in menu
    Sleep, 1000
    MouseClick, left, 2326, 1509   ; Confirm
    Sleep, 8000   ; Waiting for login menu
    MouseClick, left, 186, 1963   ; Exit button
    Sleep, 1000
    MouseClick, left, 2132, 1131   ; OK button
    Sleep, 1000
    ExitApp
}

; =====================================================================

initExpeditions() {
    global mondstadtOres1 := { mapIndex: 0, x: 2096, y: 664 }
    global mondstadtOres2 := { mapIndex: 0, x: 2336, y: 1310 }
    global mondstadtMeat := { mapIndex: 0, x: 2226, y: 896 }
    
    global liyueOres := { mapIndex: 1, x: 1916, y: 890 }
    global liyueFoods1 := { mapIndex: 1, x: 1618, y: 1110 }
}

collectAndResendExpeditions() {
    global
    
    collectAndSendExpedition(mondstadtOres1, 0)
    collectAndSendExpedition(mondstadtOres2, 1)
    collectAndSendExpedition(mondstadtMeat, 2)
    
    collectAndSendExpedition(liyueOres, 0)
    collectAndSendExpedition(liyueFoods1, 1)
    
    Send, {Esc}
}

collectAndSendExpedition(expedition, characterIndex) {
    mapY := 318 + 145 * expedition["mapIndex"]
    MouseClick, left, 150, mapY   ; Select map
    Sleep, 200
    
    MouseClick, left, expedition["x"], expedition["y"]   ; Select expedition
    Sleep, 300
    
    clickExpeditionsActionButton()   ; Take reward
    Sleep, 500
    clickExpeditionsActionButton()   ; Close overlay with rewards
    Sleep, 300
    clickExpeditionsActionButton()   ; Select character button
    Sleep, 1200
    
    characterY := 335 + 250 * characterIndex
    MouseClick, left, 500, characterY
    Sleep, 500
}

clickExpeditionsActionButton() {
    MouseClick, left, 3466, 2032
}

; =====================================================================






























































beep() {
    SoundPlay *-1
}

; =====================================================================

; 30 full attack cycles, 2 attempts
;     Spam delay: 150ms
;         Barbara:    |  61900  61910
;         Aether Geo: |  88740  88790
;         Noelle:     | 109610 109600
;     Spam delay: 100ms
;         Barbara:    |  61700  61440
;         Aether Geo: |  88240  88230
;         Noelle:     | 109540 109700
