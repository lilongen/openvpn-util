#!/usr/bin/osascript
#

do shell script "echo restart Tunnelblick..."
tell application "Tunnelblick"
  quit
  delay 5
  launch

  delay 2

  connect "new.ucloud"
  connect "mbp_aws-aws-ov-bw-all"
end tell
do shell script "echo restart Tunnelblick... done!"
