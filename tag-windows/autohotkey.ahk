#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#v::
	Run, C:\Program Files (x86)\Vim\vim80\gvim.exe
		WinWait, [No Name] - GVIM1
		WinMaximize
Return
#+w::
	Run, https://www.wrike.com/workspace.htm
Return
#e::
	Run, C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -
		WinWait, ***REMOVED***-pc
		WinMaximize
Return
#w::
	Run, "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
Return
#q::
	WinGetActiveTitle, Title
	WinClose, %Title%
Return

$CapsLock::LControl
$CapsLock Up::Send {Escape}
Return

!o::
	Send, {enter}
Return
