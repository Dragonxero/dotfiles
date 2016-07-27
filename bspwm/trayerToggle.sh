#! /bin/sh

# launch or kill trayer

CMD="trayer --align left --width 20 --widthtype request --edge top --height 20 --alpha 0 --tint 0x222222 --transparent true --margin 345 --distance 10"

if [ $(pidof trayer) ] ; then
  killall trayer -u $USER;
else
  $CMD &
fi
