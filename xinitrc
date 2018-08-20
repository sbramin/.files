dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
~/.files/andrea/setup
alacritty -e tmux -2 &
alacritty -e tmux -2 &
exec cwm
