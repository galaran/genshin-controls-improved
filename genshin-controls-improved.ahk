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

; Only 16:9 resolutions supported for now
; Common values: 1.0 for 1920x1080; 1.333333 for 2560x1440; 2.0 for 3840x2160
global scaleFrom1080p := 1.333333

initExpeditions()

return
; =====================================================================
; Context-sensitive bindings (only in Genshin Impact)
#If WinActive("ahk_class UnityWndClass") and WinActive("Genshin Impact")

XButton2::w
WheelLeft::doAndReturnCursorPosition("clickLeftArrowInGUI")
WheelRight::doAndReturnCursorPosition("clickRightArrowInGUI")

F13::spamAttack()
F14::selectAndUseTeleportOnMap()

Numpad0::doAndReturnCursorPosition("toggleArtifactLock")
Numpad1::dailyKatheryne()
^Numpad1::collectAndResendExpeditions()
Numpad2::bpCollectExp()
Numpad3::bpCollectRewards()

Numpad4::switchGroup(-1)
Numpad5::switchGroup(1)
Numpad6::switchGroup(2)

F8::craftMaxCrystals()
F9::doAndReturnCursorPosition("buyMaxSeeds")

#If
; =====================================================================

!NumpadDot::ExitApp
^NumpadDot::Reload

; =====================================================================

clickLeftArrowInGUI() {
    MouseClick, left, 72 * scaleFrom1080p, 535 * scaleFrom1080p
}

clickRightArrowInGUI() {
    MouseClick, left, 1839 * scaleFrom1080p, 535 * scaleFrom1080p
}

doAndReturnCursorPosition(functionName) {
    MouseGetPos, currentX, currentY
    %functionName%()
    Sleep, 150
    MouseMove, %currentX%, %currentY%
}

; =====================================================================

spamAttack() {
    while (GetKeyState("F13", "P")) {
        MouseClick, left
        Sleep, 150
    }
}

selectAndUseTeleportOnMap() {
    MouseClick, left
    Sleep, 300
    MouseClick, left, 1680 * scaleFrom1080p, 1003 * scaleFrom1080p   ; Teleport button
}

; =====================================================================

toggleArtifactLock() {
    MouseClick, left, 1777 * scaleFrom1080p, 187 * scaleFrom1080p   ; Lock/Unlock artifact button [artifact name fits to 1 line]
    Sleep, 200
    MouseClick, left, 1777 * scaleFrom1080p, 227 * scaleFrom1080p   ; Lock/Unlock artifact button [artifact name fits to 2 lines]
    Sleep, 200
    MouseClick, left, 1777 * scaleFrom1080p, 267 * scaleFrom1080p   ; Lock/Unlock artifact button [artifact name fits to 3 lines]
}

switchGroup(shiftValue) {
    Send, {SC026}   ; L key
    Sleep, 3500
    
    while (shiftValue != 0) {
        if (shiftValue > 0) {
            clickRightArrowInGUI()
            shiftValue--
        } else {
            clickLeftArrowInGUI()
            shiftValue++
        }
        Sleep, 600
    }
    
    MouseClick, left, 1690 * scaleFrom1080p, 1019 * scaleFrom1080p
    Sleep, 1000
    Send, {Esc}
}



bpCollectExp() {
    Send, {F4}
    Sleep, 1000
    clickRightArrowInGUI()   ; To BP exp screen
    Sleep, 500
    clickCollectExpOrRewardsButton()
}

bpCollectRewards() {
    clickLeftArrowInGUI()   ; To BP rewards screen
    Sleep, 500
    clickCollectExpOrRewardsButton()
    Sleep, 2000
    Send, {Esc}
    Sleep, 500
    Send, {Esc}
}

clickCollectExpOrRewardsButton() {
    MouseClick, left, 1737 * scaleFrom1080p, 971 * scaleFrom1080p   ; Collect all exp
}

; =====================================================================

initExpeditions() {
    global mondstadtOres1 := { mapIndex: 0, x: 1048, y: 332 }
    global mondstadtOres2 := { mapIndex: 0, x: 1168, y: 655 }
    global mondstadtMeat := { mapIndex: 0, x: 1113, y: 448 }
    
    global liyueOres := { mapIndex: 1, x: 958, y: 445 }
    global liyueMora1 := { mapIndex: 1, x: 809, y: 555 }
}

collectAndResendExpeditions() {
    global
    
    collectAndSendExpedition(mondstadtOres1, 0)
    collectAndSendExpedition(mondstadtOres2, 1)
    collectAndSendExpedition(mondstadtMeat, 2)
    
    collectAndSendExpedition(liyueOres, 0)
    collectAndSendExpedition(liyueMora1, 1)
    
    Send, {Esc}
}

collectAndSendExpedition(expedition, characterIndex) {
    mapY := (159 + 72 * expedition["mapIndex"]) * scaleFrom1080p
    MouseClick, left, 75 * scaleFrom1080p, mapY   ; Select map
    Sleep, 200
    
    MouseClick, left, expedition["x"] * scaleFrom1080p, expedition["y"] * scaleFrom1080p   ; Select expedition
    Sleep, 300
    
    clickExpeditionsActionButton()   ; Take reward
    Sleep, 500
    clickExpeditionsActionButton()   ; Close overlay with rewards
    Sleep, 300
    clickExpeditionsActionButton()   ; Select character button
    Sleep, 1200
    
    characterY := (167 + 125 * characterIndex) * scaleFrom1080p
    MouseClick, left, 250 * scaleFrom1080p, characterY
    Sleep, 500
}

clickExpeditionsActionButton() {
    MouseClick, left, 1733 * scaleFrom1080p, 1016 * scaleFrom1080p
}



; Assuming that "Auto-Play Story" setting set to "Off"
dailyKatheryne() {
    talkWithKatheryne()
    
    MouseClick, left, 1355 * scaleFrom1080p, 505 * scaleFrom1080p   ; Rewards after 4 commissions
    Sleep, 1500
    Send, {SC021}   ; F key - Skip "Thank you for completing today's commissions. Here is your reward" (1)
    Sleep, 500
    Send, {SC021}   ; F key - Skip "Thank you for completing today's commissions. Here is your reward" (2)
    Sleep, 3000   ; Waiting for rewards overlay
    MouseClick, left, 1478 * scaleFrom1080p, 505 * scaleFrom1080p   ; Close rewards overlay
    Sleep, 1000
    
    talkWithKatheryne()
    
    MouseClick, left, 1355 * scaleFrom1080p, 651 * scaleFrom1080p   ; Expeditions
    Sleep, 2000
    
    collectAndResendExpeditions()
}

talkWithKatheryne() {
    Send, {SC021}   ; F key
    Sleep, 1500
    Send, {SC021}   ; F key - Skip "Ad astra abyssosque! Welcome to the Adventurers Guild" (1)
    Sleep, 500
    Send, {SC021}   ; F key - Skip "Ad astra abyssosque! Welcome to the Adventurers Guild" (2)
    Sleep, 2000
}

; =====================================================================

craftMaxCrystals() {
    Loop, 4 {
        MouseClick, left, 1470 * scaleFrom1080p, 669 * scaleFrom1080p   ; Max items
        Sleep, 500
        MouseClick, left, 1739 * scaleFrom1080p, 1015 * scaleFrom1080p   ; Craft
        Sleep, 500
    }
}

buyMaxSeeds() {
    MouseClick, left, 1769 * scaleFrom1080p, 1018 * scaleFrom1080p   ; Buy
    Sleep, 500
    MouseClick, left, 1177 * scaleFrom1080p, 623 * scaleFrom1080p   ; Max items
    Sleep, 500
    MouseClick, left, 1161 * scaleFrom1080p, 755 * scaleFrom1080p   ; Do buy
    Sleep, 1000
    MouseClick, left, 1258 * scaleFrom1080p, 527 * scaleFrom1080p   ; Close overlay
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
