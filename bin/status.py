#!/usr/bin/env python3

import json
import os
import sys
import select
import subprocess

# https://i3wm.org/docs/i3bar-protocol.html

with os.popen('/usr/bin/i3status', mode='r') as status:
    obj = json.loads(status.readline())
    # obj['click_events'] = True
    print(json.dumps(obj))
    print(status.readline())
    while True:

        # if select.select([sys.stdin], [], [], 0)[0]:
        #     clickline = sys.stdin.readline()
        #     if not clickline.startswith('['):
        #         if clickline.startswith(','):
        #             clickline = clickline[1:]
        #         click = json.loads(clickline)

        sys.stdout.flush()
        line = status.readline()
        if line == '':
            break
        if not line.startswith(','):
            print(line)
            continue
        arr = json.loads(line[1:])

        # arr.insert(0, {
        #     'full_text': ' hello ',
        #     'color': '#ff00ff',
        #     # 'urgent': True,
        # })
        # for elem in arr:
        #     elem['border'] = '#ff00ff'
        #     elem['background'] = '#ffff00'

        light = subprocess.run(['light', '-G'], stdout=subprocess.PIPE).stdout.decode('utf-8')
        arr.insert(0, {
            'full_text': ' Light: ' + light.strip() + ' ',
            'color': '#ffffff',
        })

        # mocp = str(subprocess.run(['mocp', '-i'], stdout=subprocess.PIPE).stdout)
        # spotify = subprocess.run(['spotify-now', '-p', 'a'], stdout=subprocess.PIPE).stdout
        # music = 'State: PLAY' in mocp or len(spotify) == 0
        # musicStatus = 'ON' if music else 'OFF'
        # arr.insert(0, {
        #     'full_text': ' Music: ' + musicStatus + ' ',
        #     'color': '#00ff00' if music else '#ff0000',
        # })

        amixer = str(subprocess.run(['amixer', 'get', 'Capture'], stdout=subprocess.PIPE).stdout)
        mic = '[on]' in amixer
        micStatus = 'ON' if mic else 'OFF'
        arr.insert(0, {
            'full_text': ' Mic: ' + micStatus + ' ',
            'color': '#00ff00' if mic else '#ff0000',
        })

        print(',%s' % json.dumps(arr))
