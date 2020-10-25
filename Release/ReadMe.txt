-----------------------------------------------------------
LBA Font Editor

Copyright (C) Zink

     Version: 2.03+
Release date: 13.07.2005
      Status: Freeware (GNU GPL license).
   Home page: www.emeraldmoon.prv.pl
      E-mail: zink@poczta.onet.pl - any feedback is welcome

 This program allows you to edit font files (*.lfn) from LBA 1 and 2.

 This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

 This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details (License.txt).
-----------------------------------------------------------

Sections of this file:
 1. Future plans
 2. Thanks to
 3. Changes history


####################################
 1. Future plans
####################################

 Hmmm, I don't have ones ;). Any suggestions are welcome. 


####################################
 2. Thanks to
####################################

 - AlexFont - for entirety ;)


####################################
 3. Changes history
####################################

 ### Changes in version 2.03+:

 - Improved: Program now uses my unit that gives XP-style to menus and toolbars instead of Delphi's ActionToolbar, thus you will be able to open source code in Delphi 7 Personal, and the program looks overally nicer.
 - Improved: I am now using AnimateWindow() instead of my own animation code (for options panel). 


 ### Changes in version 2.03:

 - Fixed bug that caused "Undo" button to be enabled only for the first character being edited.
 - Options panel should now slide out and slide in faster on slow computers.


 ### Changes in version 2.02:

 - Added some shortcuts for all windows
 - New feature: preview current font with your own text
 - Fixed a bug that sometimes caused a single pixel to be able to select
 - Characters now can have width and height set to zero
 - Added option to associate the program with LBA font files (*.lfn)

 ### Changes in version 2.01:

 - Menu changed completely
 - Preview of edited character in editor window
 - Undo and Redo in editor window
 - Editor window now displays number of edited character
 - Fixed bug that sometimes caused editor window to display an access violation error
 - Font Editor now supports dropping files on the exe and on the main window
 - Selection doesn't flicker anymore during scrolling