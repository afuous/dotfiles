#!/usr/bin/env python3

import json
import os
import sys
import select
import subprocess

# https://i3wm.org/docs/i3bar-protocol.html

def run(command):
    return subprocess.run(command.split(' '), stdout=subprocess.PIPE).stdout.decode('utf-8').strip()

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

        light = run('light -G')
        arr.insert(0, {
            'full_text': ' Light: ' + str(round(float(light.strip()))) + '% ',
            'color': '#ffffff',
        })

        amixer = run('amixer get Capture')
        mic = '[on]' in amixer
        micStatus = 'ON' if mic else 'OFF'
        arr.insert(0, {
            'full_text': ' Mic: ' + micStatus + ' ',
            'color': '#00ff00' if mic else '#ff0000',
        })

        # TODO: make battery section urgent if low

        # this replaces the default i3status volume section
        allSinksMuted = True
        volumeString = run('pamixer --get-volume --sink 0') + '%'
        if run('pamixer --get-mute --sink 0') == 'true':
            volumeString = '(' + volumeString + ')'
        else:
            allSinksMuted = False
        # do not want to just loop through all sinks because of things like loopback sinks
        bluezLines = [line for line in run('pactl list short sinks').split('\n') if 'bluez' in line]
        if len(bluezLines) > 0:
            sinkIndex = bluezLines[0].split()[0]
            btVolumeString = run('pamixer --get-volume --sink ' + sinkIndex) + '%'
            if run('pamixer --get-mute --sink ' + sinkIndex) == 'true':
                btVolumeString = '(' + btVolumeString + ')'
            else:
                allSinksMuted = False
            volumeString += ' ' + btVolumeString
        arr.insert(len(arr) - 1, {
            'full_text': ' Volume: ' + volumeString + ' ',
            'color': '#ffff00' if allSinksMuted else '#ffffff',
        })

        print(',%s' % json.dumps(arr))
