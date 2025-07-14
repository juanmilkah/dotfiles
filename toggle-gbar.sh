if pgrep -x "gBar" > /dev/null; then
  killall gBar
else
  gBar bar 0
fi
