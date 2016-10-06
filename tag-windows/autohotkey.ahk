#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
^j::
	Send, My First Script
Return
::ftw::Free the whales
#a::
	Run, http://appulate.local
Return
#+w::
	Run, https://www.wrike.com/workspace.htm
Return
#e::
	Run, C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -
Return
#w::
	Run, "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
Return
#q::
	WinGetActiveTitle, Title
	WinClose, %Title%
Return
#1::
	IfWinExist, ahk_exe chrome.exe
	{
		WinActivate
	}
Return
#2::
  IfWinExist, ahk_exe gvim.exe
	{
		WinActivate
	}
Return
#3::
	IfWinExist, ahk_exe mintty.exe
	{
		WinActivate
	}
Return
#4::
  IfWinExist, Skype
  {
    WinActivate
  }
Return
#5::
  IfWinExist, ahk_exe devenv.exe
    WinActivate
  else
    Run, "C:\Projects\Appulate\Sources\Appulate.sln"
Return
#6::
  IfWinExist, TortoiseHg Workbench
    WinActivate
  else
    Run, "C:\Program Files\TortoiseHg\thgw.exe"
Return
#F12::
	Send +{F8}
Return
#7::
	InputBox, taskCommand, todo.txt, Enter task command.
		if ErrorLevel
			return
		else
			run, C:\cygwin64\bin\bash.exe -l -c "exec /cygdrive/c/cygwin64/bin/pass %taskCommand% -c"
Return

$CapsLock::LControl
	$CapsLock Up::Send {Escape}
Return

RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}

!o::
	Send, {enter}
Return