# Took from https://wiki.archlinux.org/title/Xinit#:~:text=separate%20X%20display.-,autostart,-X%20at%20login
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi
