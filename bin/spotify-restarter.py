#!/usr/bin/env python3

import subprocess
import time

def thing(first):
    subprocess.run(['killall', 'blockify'])
    subprocess.run(['killall', 'blockify'])
    blockify = subprocess.Popen(['blockify', '-vvv'], stdout=subprocess.PIPE)

    if not first:
        time.sleep(10)
        subprocess.Popen(['playerctl', 'play'])

    for line in blockify.stdout:
        print(line)
        line = str(line)
        space = ' ' # to make it clear that there are two spaces
        if 'Muting' + space + space in line:
            print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
            time.sleep(2)
            subprocess.run(['killall', 'blockify'])
            subprocess.run(['killall', 'blockify'])
            subprocess.run(['killall', 'spotify'])
            time.sleep(1)
            subprocess.run(['killall', 'spotify'])
            subprocess.Popen(['spotify'])
            # time.sleep(5)
            # subprocess.Popen(['playerctl', 'play'])
            return

first = True
while True:
    thing(first)
    first = False
    time.sleep(10)
