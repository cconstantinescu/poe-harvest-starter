; made by /u/lutcikaur
#NoEnv
#SingleInstance force
#MaxHotkeysPerInterval 500

FileEncoding , UTF-8
SendMode Input
SetTitleMatchMode, 3
macroVersion := 168

If (A_AhkVersion <= "1.1.23")
{
	msgbox, You need AutoHotkey v1.1.23 or later to run this script. `n`nPlease go to http://ahkscript.org/download and download a recent version.
	ExitApp
}

IfNotExist %A_MyDocuments%\AutoHotKey
{
	FileCreateDir, %A_MyDocuments%\AutoHotKey
}

IfNotExist %A_MyDocuments%\AutoHotKey\LutTools
{
	FileCreateDir, %A_MyDocuments%\AutoHotKey\LutTools
}

SetWorkingDir %A_MyDocuments%\AutoHotKey

IfNotExist LutTools\settings.ini 
{
	IfExist cports.exe 
	{
		FileMove, settings.ini, LutTools
		FileMoveDir, Lib, LutTools\Lib
		FileMove, cports.chm, LutTools
		FileMove, error.txt, LutTools
		FileMove, ladder.json, LutTools
		FileMove, leagues.json, LutTools
		FileMove, price.html, LutTools
		FileMove, readme.txt, LutTools
		FileMove, TEMP, LutTools
		FileMove, version.html, LutTools
		FileMove, cports.exe, LutTools
	}
}

SetWorkingDir %A_MyDocuments%\AutoHotKey\LutTools

IfNotExist, heavy.ahk
{
	UrlDownloadToFile, http://lutbot.com/ahk/heavy.ahk, heavy.ahk
}
IfNotExist, lite.ahk
{
	UrlDownloadToFile, http://lutbot.com/ahk/lite.ahk, lite.ahk
}
IfNotExist, verify.ahk
{
	UrlDownloadToFile, http://lutbot.com/ahk/verify.ahk, verify.ahk
}

RunWait, verify.ahk

IniRead, runHeavy, settings.ini, variables, RunHeavy
IniWrite, %A_ScriptFullPath%, settings.ini, variables, LauncherPath

if runHeavy = ERROR
	runHeavy = 1

if runHeavy = 1
{
	Run heavy.ahk
	ExitApp
}
else
{
	Run lite.ahk 
	ExitApp
}

msgbox Something went wrong.