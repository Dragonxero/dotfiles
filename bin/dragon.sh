#!/bin/sh
#
# A pic for my sista
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

cat << EOF

$bld                                        
$f5   ヽ( ˃ ヮ ˂)ノ ヽ(´▽｀*)ゞ ヽ(*´▽｀)ツ♪
$f2  
$f2                                        ,   ,  
$f2                                        S,  S,     ,            
$f2                                        ¨ss.Sss. .s¨     
$f2                                ,     .ssSSSSSSSSSSs,              
$f2                                S. sSSSSSSSSSSSSSS'SSSs       
$f2                                ¨SSSSSSSSSSSSSSSSSSoSSS       ,       
$f2                               sSSSSSSSSSSSSSSSSSSSSSSSSs,  ,s  
$f2                              sSSSSSSSSS¨SSSSSS¨¨¨¨SSSSSS¨SSSSS,     
$f2                              sSSSSSSSSSSs¨¨SSSSssssss¨SSSSSSSS¨   
$f2                             sSSSSSSSSSS¨         ¨¨¨¨ss¨S¨Ss¨¨      
$f2                             sSSSSSSSSSS,              '¨¨¨¨¨S  .sSSs
$f2                             sSSSSSSSSSSSSs,...               'sSS¨  ¨
$f2                         ¨ssssSSSSSSSSSSSSSSSSSSSS####s.     .SS¨S.   , s-
$f2                           ¨¨¨¨¨SSSSSSSSSSSSSSSSSSSS#####SSSSSS¨     S.S¨
$f2                                 ¨SSSSSSSSSSSSSSSSSSSSS####s¨¨     .SSS|
$f2                                  ¨SSSSSSSSSSSSSSSSSSSSSSSS##s    .SS¨ S 
$f2                                   SS¨¨SSSSSSSSSSSSSSSSSSSSSSSSSSSSS¨   ¨
$f2                                  SS¨  ¨S¨SSSSSSSSSSSSSSSSSSSSS¨¨¨¨¨ 
$f2                             ,   ,¨     ¨  SSSSSSSSSSSSSSSS####s  
$f2                             S.          .sSSSSSSSSSSSSSSSSS####¨
$f2                 ,           ¨Ss.   ..ssSSSSSSSSSSSSSSSSSSSS####¨
$f2                 S           .SSSSSSSSSSSSSSSSSSSSSSSSSSSS#####¨
$f2                 Ss     ..sSSSSSSSSSSSSSSSSSSSSSSSSSSSS######¨¨
$f2                  ¨SSsSSSSSSSSSSSSSSSSSSSSSSSSSSSS########¨
$f2           ,      sSSSSSSSSSSSSSSSSSSSSSSSS#########¨¨¨
$f2           S    sSSSSSSSSSSSSSSSSSSSSS#######¨¨¨      s¨         ,
$f2           SS..SSSSSSSSSSSSSSSSSS######¨¨       ....,SS....    ,SS
$f2            ¨SSSSSSSSSSSSSSS######¨¨ ,     .sSSSSSSSSSSSSSSSSSsSSS
$f2              SSSSSSSSSSSS#####¨     S, .sSSSSSSSSSSSSSSSSSSSSSSSSs.
$f2   )          SSSSSSSSSSS#####¨      'SSSSSSSSS###########SSSSSSSSSSS.
$f2  ((          SSSSSSSSSSS#####       SSSSSSSS###¨       ¨####SSSSSSSSSS 
$f2  ) \         SSSSSSSSSSSS####.     SSSSSS###¨             ¨###SSSSSSSSS   s¨
$f2 (   )        SSSSSSSSSSSSS####.   SSSSS###¨                ####SSSSSSSSsSS¨
$f2 )  ( (       SS¨SSSSSSSSSSS#####.SSSSS###¨ -Tua Xiong     .###SSSSSSSSSS¨
$f2 (  )  )   _,S¨   SSSSSSSSSSSS######.SS##¨                .###SSSSSSSSSSS
$f2 ) (  ( \.         ¨SSSSSSSSSSSSS#######,,,.          ..####SSSSSSSSSSS¨
$f2(   )S )  )        ,SSSSSSSSSSSSSSSSSS####################SSSSSSSSSSS¨        
$f2(   (SS  ( \     _sS¨  ¨¨SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS,       
$f2 )  )SSSs ) )  .      .   'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS¨¨  ¨SS   
$f2  (   SSSSs/  .S,    .S,,sSSSSSS##SSSSSSSSSSSSSSSSSSSSSSSSSS¨¨        ¨ 
$f2    l)_SSSSSSSSSSSSSSSSSSSSSSS##¨  SS        'SS.        'SS.
$f2        ¨¨SSSSSSSSSSSSSSSSSS#¨      S          'S          'SS
$f2            '¨¨¨¨¨¨¨¨¨¨¨¨¨¨         ¨           ¨           ¨

EOF
