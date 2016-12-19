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
