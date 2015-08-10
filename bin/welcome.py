#!/usr/bin/env python2.7

import getpass
import random
from datetime import datetime
from subprocess import call, Popen, PIPE
from os import listdir
from os.path import isfile, join
     
blacklist = ["head-in", "sodomized", "telebears"]
     
cowpath = "/usr/share/cows"
cows = [ f[:-4] for f in listdir(cowpath) if isfile(join(cowpath,f)) and f.endswith(".cow") and f[:-4] not in 
blacklist ]
user = getpass.getuser()
hour = datetime.time(datetime.now()).hour
random_cow = random.choice(cows)
say_or_think = random.choice(["say", "think"])
     
if hour >= 22:
    str = "Sleep Well, " + user + "!"
elif hour >= 18:
    str = "Good Evening, " + user + "!"
elif hour >= 14:
    str = "Good Afternoon, " + user + "!"
elif hour >= 12:
    str = "Enjoy Your Meal, " + user + "!"
else:
    str = "Good Morning, " + user + "!"
     
fortune = Popen(["fortune"], stdout=PIPE).communicate()[0]
     
call(["cow" + say_or_think, "-f", random_cow, str + "\n\n" + fortune])

#  vim: set ft=python ts=8 sw=4 tw=0 fenc=utf-8:
