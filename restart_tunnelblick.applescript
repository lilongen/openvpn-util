#!/usr/bin/osascript
#

do shell script "echo restart Tunnelblick..."
tell application "Tunnelblick"
  quit
  delay 5
  launch
end tell
do shell script "echo restart Tunnelblick... done!"
