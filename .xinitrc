export GTK_IM_MODULE=ibus
export QT_IM_MODULE=xim
export XMODIFIERS="@im=ibus"
export LANG=ja_JP.utf8
export LC_ALL=ja_JP.utf8

xmondmap /home/ukstudio/.Xmodmap
xsetroot -cursor_name left_ptf


nitrogen --restore &

xcompmgr &
ibus-daemon -d -x

xmonad | xmobar
#startxfce4
