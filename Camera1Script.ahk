#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; Boiler plate above ^^^

#Persistent

; 0 = Dev
; 1 = Camera 1 PC
; 2 = Camera 2 PC
environment := 1

if environment = 1
{
    manual := false
    nircmd := "C:\Program Files (x86)\nircmd\nircmd.exe"
    chrome := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    picDir := "C:\Users\NUCUSER\Dropbox\Camera\PC1\"
    picFilename := "CameraPC1"
    interval := 900000
    ; 1920 x 1080
    loginPosX := 900
    loginPosY := 690
}
else if environment = 2
{
    manual := false
    nircmd := "C:\Program Files (x86)\nircmd\nircmd.exe"
    chrome := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    picDir := "C:\Users\NUC USER\Dropbox\Camera\PC2\"
    picFilename := "CameraPC2"
    interval := 900000
    ; 1920 x 1080
    loginPosX := 900
    loginPosY := 690
}
else ; Dev
{
    manual := true
    nircmd := "C:\Program Files\nircmd\nircmd.exe"
    chrome := "C:\Program Files\Google\Chrome\Application\chrome.exe"
    picDir := "C:\Users\Quicken\Pictures\"
    picFilename := "Dev"
    interval := 120000
    loginPosX := 600
    loginPosY := 580
}


; 1 minute = 60000
; 15 minutes = 900000
SetTimer, RestartChrome, %interval%

^j::
RestartChrome.call()

RestartChrome:

run %nircmd% savescreenshot "%picDir%%picFilename% %A_YYYY%-%A_MM%-%A_DD% at %A_Hour%.%A_Min%.%A_Sec%.png"
sleep, 1000 ; DelayInMilliseconds (Next command is too fast and Chrome is already closed)

WinClose, ahk_exe chrome.exe

run %chrome%
sleep, 5000 ; DelayInMilliseconds
click %loginPosX%, %loginPosY%

sleep, 20000 ; DelayInMilliseconds
run %nircmd% savescreenshot "%picDir%%picFilename% %A_YYYY%-%A_MM%-%A_DD% at %A_Hour%.%A_Min%.%A_Sec%.png"

sleep, 1000 ; Weird, give time for nircmd to complete
return