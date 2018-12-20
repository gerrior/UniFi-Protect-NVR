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
    captureUtil := "C:\Program Files (x86)\MiniCap\minicap.exe"
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
    captureUtil := "C:\Program Files (x86)\MiniCap\minicap.exe"
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
    captureUtil := "C:\Program Files\MiniCap\minicap.exe"
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

run %captureUtil% -save "%picDir%%picFilename% %A_YYYY%-%A_MM%-%A_DD% at %A_Hour%.%A_Min%.%A_Sec% A.jpg" -capturescreen -exit -compress 2 -convert gray
sleep, 1000 ; DelayInMilliseconds (Next command is too fast and Chrome is already closed)

WinClose, ahk_exe chrome.exe

run %chrome%
sleep, 6000 ; DelayInMilliseconds
; Click on "Log on with Microsoft" on the Comcast Business screen
click %loginPosX%, %loginPosY%

; Micorsoft made a change on 12/20/2018 that necessitated this change. 
; Need to type in the email address and not actually sign in. 
sleep, 1000 ; DelayInMilliseconds
Send pathwaysocietycameras@outlook.com{enter}

sleep, 20000 ; DelayInMilliseconds
run %captureUtil% -save "%picDir%%picFilename% %A_YYYY%-%A_MM%-%A_DD% at %A_Hour%.%A_Min%.%A_Sec% B.jpg" -capturescreen -exit -compress 2 -convert gray

sleep, 1000 ; Weird, give time for nircmd to complete
return