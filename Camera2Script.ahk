#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; Boiler plate above ^^^
CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.

#Persistent

; 0 = Dev
; 1 = Camera 1 PC
; 2 = Camera 2 PC
environment := 2
runClickRefresh := true

; timeout := 60000 ; 1 minute
timeout := 15000 ; 15 seconds

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
    emailAddress := "pathwaysocietycameras@outlook.com"
    loginMethod := 1
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
    emailAddress := "pathwaysocietycameras@outlook.com"
    loginMethod := 1
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
    emailAddress := "pathwaysocietycameras@outlook.com"
    loginMethod := 0
}


; 1 minute = 60000
; 15 minutes = 900000
SetTimer, RestartChrome, %interval%
SetTimer, ClickRefresh, 60000

^k::
ClickRefresh()
;FindPic("usethisaccount.png")
return 

^j::
RestartChrome()
return 

; --------------------------------------------------------
;											  ClickRefresh
; If a given image doesn't load, a "Refresh?" link appears.
; For now, blindly click where each button could be.
; A HUD will appear but goes away after a moment.	
; --------------------------------------------------------
ClickRefresh()
{
	global runClickRefresh

	if (runClickRefresh) 
	{
	click 400, 400
	click 1000, 400
	click 1600, 400
	click 400, 760
	click 1000, 760
	click 1600, 760
	}
}

; --------------------------------------------------------
;										LoginWithMicrosoft
; --------------------------------------------------------
LoginWithMicrosoft(method, email)
{
	if (method = 1)
	{
		; Micorsoft switched back to 2018 behavior on 4/22/2020 @ 6pm PT. 
		; Micorsoft made a change on 4/23/2019 @ 9am PT that obviated the need for this code. 
		;; Micorsoft made a change on 12/20/2018 that necessitated this change. 
		;; Need to type in the email address and not actually sign in. 

		; Wait for the signin screen
		; Enter email address and press enter
		; Password is not needed.
		FindPic("signinwithmicrosoft.png")
		Send %email%{enter}
	}
}

RestartChrome()
{
global manual
global captureUtil
global chrome
global picDir
global picFilename
global interval
global loginPosX
global loginPosY
global emailAddress
global runClickRefresh
global loginMethod

runClickRefresh := false

run %captureUtil% -save "%picDir%%picFilename% %A_YYYY%-%A_MM%-%A_DD% at %A_Hour%.%A_Min%.%A_Sec% A.jpg" -capturescreen -exit -compress 2 -convert gray
sleep, 1000 ; DelayInMilliseconds (Next command is too fast and Chrome is already closed)

WinClose, ahk_exe chrome.exe

run %chrome%
FindPic("logonwithmicrosoft.png")
; Click on "Log on with Microsoft" on the Comcast Business screen
click %loginPosX%, %loginPosY%

LoginWithMicrosoft(loginMethod, emailAddress)

sleep, 20000 ; DelayInMilliseconds
run %captureUtil% -save "%picDir%%picFilename% %A_YYYY%-%A_MM%-%A_DD% at %A_Hour%.%A_Min%.%A_Sec% B.jpg" -capturescreen -exit -compress 2 -convert gray

sleep, 1000 ; Weird, give time for nircmd to complete

runClickRefresh := true
}

; --------------------------------------------------------
; Find a image on the screen or exit after timeout value
; --------------------------------------------------------
FindPic(file)
{
global timeout
global picDir
global captureUtil
global picFilename

before := A_TickCount
done := false

loop {
	ImageSearch, FoundX, FoundY, 450, 240, 1200, 800, %file%

	if ErrorLevel = 2
		MsgBox FindPic: Could not conduct the search for %file%.
	else if ErrorLevel = 1 
	{
    		; MsgBox FindPic: Image %file% could not be found on the screen.
	}
	else
	{
		; MsgBox FindPic: The image was found at %FoundX%x%FoundY%.
		done := true
	}

	after := A_TickCount
	diff := after - before 

	if (done) or (diff >= timeout)
	{
		if (diff >= timeout)
		{
			; What was on the screen at the time of the timeout?
			; Use this screenshot to generate new slug to look for
			; %file% must end in png. jpg has too much compression and images won't work.
			run %captureUtil% -save "%picDir%%picFilename% %A_YYYY%-%A_MM%-%A_DD% at %A_Hour%.%A_Min%.%A_Sec% %file%" -capturescreen -exit
		}
		break
	}
}

FormatTime, dt, A_Now, ShortDate
FormatTime, tm, A_Now, Time
logMsg = %dt% %tm%	%diff%`n

FileAppend %logMsg%, %picDir%%file%.txt

; MsgBox Time lapse %diff%, %FoundX%, %FoundY% 
}

