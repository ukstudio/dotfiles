export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
export XMODIFIERS="@im=uim"
export LANG=ja_JP.utf8
export LC_ALL=ja_JP.utf8

nitrogen --restore &

xcompmgr &

xrdb -merge ~/.Xdefaults
xmonad
