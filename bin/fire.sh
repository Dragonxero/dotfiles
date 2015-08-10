#!/bin/bash
X=`tput cols` Y=`tput lines` e=echo M=`eval $e {1..$[X*Y]}` P=`eval $e {1..$X}`;
B=(' ' '\e[0;31m.' '\e[0;31m:' '\e[1;31m+' '\e[0;33m+' '\e[1;33mU' '\e[1;33mW');
$e -e "\e[2J\e[?25l" ; while true; do p=''; for j in  $P; do p=$p$[$RANDOM%2*9];
done;O=${C:0:$[X*(Y-1)]}$p;C='' S='';for p in $M;do #  _-=[ BruXy.RegNet.CZ ]=-_
read a b c d <<< "${O:$[p+X-1]:1} ${O:$[p+X]:1} ${O:$[p+X+1]:1} ${O:$[p+X+X]:1}"
v=$[(a+b+c+d)/4] C=$C$v S=$S${B[$v]}; done; printf "\e[1;1f$S"; done  # (c) 2012

