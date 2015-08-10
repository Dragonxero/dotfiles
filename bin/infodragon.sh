#!/bin/sh
#
# Info Dragon
# Based on Infocat and Surabaya script
# @liara

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

distro=$(head -1 /etc/issue | cut -f1 -d '\')
bit=$(uname -m)
win_man=$DESKTOP_SESSION
space=$(df | grep 'mapper' | awk '{s+=$2} END {printf("%.0f\n", s/1048576)}')
used=$(du -hs /home/$USER | awk '{print $1}')
cpu=$(cat /proc/cpuinfo | grep 'model name' | head -1 | awk '{print $4,$5,$6,$7,$8,$9}')
gpu1=$(lspci | grep VGA | awk '{print $5,$6,$7,$8,$9,$10}')
gpu2=$(lspci | grep 3D | awk '{print $4,$5,$6,$7,$8,$9}')
memkb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
ram=$(expr $memkb / 1024)
time_now=$(date +" %a %d %b - %H:%M")
up=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
kernel=$(uname -r)
packages=$(pacman -Q | wc -l)
load=$(cat /proc/loadavg | awk '{print $1,$2,$3}')
wlan=$(ip link | grep wlp | awk '{print $2}' | cut -f1 -d ":")
lan=$(ip link | grep enp | awk '{print $2}' | cut -f1 -d ":")
tun=$(ip link | grep tun | awk '{print $2}' | cut -f1 -d ":")
gb=$(echo "G")
function vpenis
{
LC_ALL=C
echo `uptime|grep days|sed 's/.*up \([0-9]*\) day.*/\1\/10+/'; \
cat /proc/cpuinfo|grep MHz|awk '{print $4"/30 +";}'; free|grep '^Mem' \
|awk '{print $3"/1024/3+"}'; df -P -k -x nfs | grep -v 1k \
| awk '{if ($1 ~ "/dev/(scsi|sd)"){ s+= $2} s+= $2;} END \
{print s/1024/50"/15+70";}'`|bc|sed 's/\(.$\)/.\1cm/'
}
result=$(vpenis)
gtkrc="$HOME/.gtkrc-2.0"
gtktheme=$(grep "gtk-theme-name" "$gtkrc" | cut -d\" -f2)
gtkicon=$( grep "gtk-icon-theme-name" "$gtkrc" | cut -d\" -f2 )
gtkfont=$( grep "gtk-font-name" "$gtkrc" | cut -d\" -f2 )

cat << EOF

$bld                                        
$f2                                                       $f1 $USER $f6@ $f3$HOSTNAME
$f2                                                       $f2$time_now 
$f2                                                         
$f2                  ___====-_  _-====___                  OS     :: $f4$distro$bit
$f2             _--^^^#####V      V#####^^^--_             KERNEL :: $f4$kernel
$f2          _-^##########V (    ) V##########^-_          WM     :: $f4$win_man 
$f2         -############V  ()^^()  V############-
$f2       _ ############V   (@::@)   V############_       $f1 HW
$f2      l#############((    (())    ))#############l      HDD :: $f4$used$f2/$f4$space$gb
$f2     -###############V    (oo)    V###############-     CPU :: $f4$cpu
$f2    -#################V  l VV l  V#################-    GPU :: $f4$gpu1
$f2   -###################V        V###################-   GPU :: $f4$gpu2
$f2  _#l##########71######(   ()   )######71##########l#_  RAM :: $f4$ram MB
$f2    V #71#71#/V  1#/l##l  |  |  l##71#7  V1#71#71# V   
$f2 ' l V  V  V  '   V  l#l| |  | |l#l  V   '  V  V  V l '$f1 MISC
$f2                      l | |  | | l                      UPTIME :: $f4$up
$f2                     (  | |  | |  )                     GTHEME :: $f4$gtktheme
$f2                    __l | |  | | l__                    GFONT  :: $f4$gtkfont
$f2                                                        GICON  :: $f4$gtkicon
$f1                   (vvv(VVV)(VVV)vvv)                  $f2 WLAN   :: $f4$wlan
$f2                                                        ETHER  :: $f4$lan
$f2                                                        TUN    :: $f4$tun
$f7       I believe in dragons, good men and other        $f2 PACKET :: $f4$packages 
$f7              fanstasy creatures.                      $f2 LOAD   :: $f4$load
$f2                                                        VPENIS :: $f4$result
$f7        
$f7                

EOF
