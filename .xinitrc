#idk if this is necessary, sources .sh files from /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


#read Xresources file, first part makes sure file exists first
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#set wallpaper
#nitrogen --restore &

#Japanese input
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
fcitx5 -d &
export XMODIFIERS='@im=fcitx'

#Time in seconds until monitor standby (just screen, not much energy save), suspend (screen+psu), poweroff (entirely off)
#xset dpms 0 1800 0

#Disable dpms
xset -dpms

#Disable Xscreensaver
xset s off

#typematic (keyboard repeat/delay) settings, ms delay, Hz speed
xset r rate 250 25

#caps lock key mirrors escape
setxkbmap -option caps:swapescape

#ctrl (and now caps lock) is escape key when pressed on its own
#xcape -e 'Control_L=Escape'

#this is required to fix cursor for bspwm, not sure why it isn't needed with dwm
xsetroot -cursor_name left_ptr &

#compositing for vsync, glx-no-stencil improves performance, xrender-sync-fence fixes issues
picom --config /dev/null --backend glx --vsync --glx-no-stencil --xrender-sync-fence --daemon

#start clipboard manager
clipster -d &

#set monitor positions
xrandr --output DVI-D-0 --mode 2560x1440 --pos 2560x0 --output HDMI-0 --primary --mode 2560x1440 --pos 0x0

#start bspwm
sxhkd &
exec bspwm
