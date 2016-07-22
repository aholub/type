APPLICATION:

type.app
type.scpt

AUTHOR:

Allen Holub (allen@holub.com --- feel free to get in touch if you have
questions).

SYNOPSIS:

From command line (type.scpt):

	osascript type.scpt -[help]
	osascript type.scpt input-file [input-file ...]

From desktop (type.app)

	Double click the icon to inject text from the clipboard into
	the target app.

	Drag/Drop a file onto the icon to inject text from the file.

DESCRIPTION

	This script is a "robot typist." It injects characters into a target
	application (XCode, Eclipse, etc.) at a pace that looks as if a (very
	very good) typist is typing it. You can control the typing speed with
	an option (see below). It's intended for live presentations and video
	recording, where a cut/paste operation is jarring to the viewer.

	This script takes two forms, a .scpt file that you can execute from
	the command line using osascript, as shown in the SYNOPSIS section,
	or as an application (type.app) that you typically put onto the desktop
	or the Dock. To put it on the Dock, install it into /Applications (or
	anywhere else that's convenient) and then drag an alias to the Dock.

	Files that you drop onto the desktop app are injected at the current
	cursor position in the target application (XCode, by default). You can
	drop multiple files, but not folders. Don't click on another app once
	the playback has started---characters will go to that app if you do.

	Double click on the applet to inject text currently on the clipboard
	into the target application.

	If the script finds a # at the very end of a line, it pauses for
	2 seconds. The # is not passed to the output. However, # characters at 
	any other position on the line are treated like normal characters and are
	passed to the target application. If you want to auto-type a # on a line
	by itself, put a space to its right.

	When you run from the command line using osascript, files are injected
	in the order specified. Specifying --help displays a dialog box holding
	a very abbreviated version of this README file.

XCODE ISSUES
	Annoyingly, XCode feels compelled to screw around with your
	formatting as you type, and there's no way to completely disable
	this "feature."  For this script to work, go to

	Preferences->"Text Editing"->Editing

    * Uncheck all Code-completion options
	* Check "Automatically trim trailing whitespace"

	Preferences->"Text Editing"->Indentation
		
	*  set "Prefer indent using" to Spaces (making sure the Tab
	   width matches the Tabwidth default discussed below)
	*  uncheck Line wrapping
	*  uncheck Syntax-aware indenting

	XCode (and other editors) often support autoindenting. Unfortunately,
	in XCode, there's no way to turn that feature off! 

	type.scpt currently shells out to a script (~/bin/type/xcodeDeMoronize.sh)
	that compensates for this problem. Find details in the
	xcodeDeMoronize.sh file. If you want to change (or remove) that
	processing, modify the shell script, but don't remove it.  There's no
	way, at present, to change the name or location of the script. The
	current script just executes a java program that's included in the
	install.

INTELLIJ IDEA ISSUES

	Turn off everything in Preferences->Editor->Smart keys
	Turn off everything in Preferences->General->Code Completion
	Turn off everything in Preferences->General->Postfix Completion

	Note that if you turn off Preferences->Editor->Smart keys->Smart indent,
	you should xcodeDeMoronize.sh to not do anything. There's no harm
	in leaving xcodeDeMoronize in place and leaving autoindent enabled if you
	want to type manually as well as inject text.

	You may want to turn off inspections if you're deliberately doing
	something off the wall.


BUGS
	Once typing starts, there's no way to stop it. This is really annoying
	when you see a bug in the first line of a 50-line insertion.

	Last time I looked, the # pause feature was being flaky. I'll try to
	track that down when I get a moment.

OPTIONS

	The script supports various configuration options, which it stores in
	Apple's "defaults" database. Modify these from the command line as follows:

	defaults write com.holub.type XVim YES
			If YES, prefixes all text with an i (to enter vi "insert" mode),
			and adds an Esc to the end of the text (to exit "insert" mode).
			Default is YES.

	defaults write com.holub.type Tabwidth -int 4
			Detab tab width. If 0, then detabbing is disabled.
			Default is 4.

	defaults write com.holub.type Pause -float 2.0
			Length of pause (seconds) initiated by a # at end of the line.
			Default is 2.0.

	defaults write com.holub.type Delay -float 0.06
			Delay between characters (seconds).
			Default is 0.06.

	defaults write com.holub.type Target XCode
			Application that receives the characters.
			Default is XCode

	To see the current values, type

		defaults read com.holub.type

	If a value isn't listed, then the above default values are used.
	The current values are also shown in the "osascript type.scpt -help"
	dialog.

INSTALLATION
	You need install Java on your system if you haven't.

    Then clone the git repo to ~/bin/type

	If you don't want to do that, the script file that type uses must
	be at ~/bin/type/xcodeDeMoronize.sh and that script runs:

		java -jar ~/bin/type/xcodeDeMoronize.jar

	You'll need to arrange for all that to work if you move stuff around.
	You can easily replace that java program with something else if you
	need to massage your input in some other way (what it does is described
	inside the .sh file). You can't get rid of the .sh file, however. Just
	empty it out if you don't want any preprocessing.

EDITING

	You can modify type.scpt file in Apple's script editor simply by opening it
	from a shell (terminal) window:

		 open type.scpt

	To recreate the app, save it in the script editor using
	File->Export->"File Format"->Application


COPYRIGHT and DISTRIBUTION

	(c) 2015 Allen I. Holub. All rights reserved.

	You may distribute this script freely, provided that you distribute
	this file along with it and do not modify this copyright section.

	You may modify this script to reflect any changes you make to the script,
	but you may not remove the original copyright in that case, and
	please send me a copy of your modifications (allen@holub.com)

	You may not distribute this script or any derived work as part of a
	commercial application.
