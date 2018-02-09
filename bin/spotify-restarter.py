#!/usr/bin/env python3

import subprocess
import time

def restart(startPlaying):
    subprocess.run(['killall', 'spotify'])
    time.sleep(1)
    subprocess.run(['killall', 'spotify'])
    subprocess.Popen(['spotify'])
    if startPlaying:
        for _ in range(60):
            try:
                if subprocess.check_output(['playerctl', 'status']) == b'Playing\n':
                    break
                time.sleep(1)
                subprocess.Popen(['playerctl', 'play'])
            except:
                pass
    time.sleep(10)

restart(False)
while True:
    time.sleep(1)
    try:
        if subprocess.check_output(['playerctl', 'metadata', 'artist']) == b'':
            print('Restarting')
            restart(True)
    except:
        subprocess.Popen(['spotify'])
