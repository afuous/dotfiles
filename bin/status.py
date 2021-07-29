#!/usr/bin/env python3

import json
import os
import sys
import select
import subprocess

# https://i3wm.org/docs/i3bar-protocol.html

def run(command):
    return subprocess.run(command.split(' '), stdout=subprocess.PIPE).stdout.decode('utf-8').strip()

def getLight():
    light = run('light -G')
    return {
        'full_text': ' L: ' + str(round(float(light.strip()))) + '% ',
        'color': '#ffffff',
    }

def getMic():
    amixer = run('amixer get Capture')
    micOn = '[on]' in amixer
    return {
        'full_text': ' Mic: ' + ('ON' if micOn else 'OFF') + ' ',
        'color': '#00ff00' if micOn else '#ff0000',
    }

def getVolume():
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
    return {
        'full_text': ' Volume: ' + volumeString + ' ',
        'color': '#ffff00' if allSinksMuted else '#ffffff',
    }

def getMemory():
    with open('/proc/meminfo', 'r') as meminfo:
        lines = meminfo.readlines()
        memoryTaken = 0
        memoryTotal = 0
        swapTaken = 0
        swapTotal = 0
        # https://stackoverflow.com/questions/41224738/how-to-calculate-system-memory-usage-from-proc-meminfo-like-htop
        for line in lines:
            if line.startswith('MemTotal'):
                memoryTotal = int(line.split()[1])
                memoryTaken += int(line.split()[1])
            elif line.startswith('MemFree'):
                memoryTaken -= int(line.split()[1])
            elif line.startswith('Buffers'):
                memoryTaken -= int(line.split()[1])
            elif line.startswith('Cached'):
                memoryTaken -= int(line.split()[1])
            elif line.startswith('SReclaimable'):
                memoryTaken -= int(line.split()[1])
            elif line.startswith('Shmem'):
                memoryTaken += int(line.split()[1])
            elif line.startswith('SwapTotal'):
                swapTotal = int(line.split()[1])
                swapTaken += int(line.split()[1])
            elif line.startswith('SwapFree'):
                swapTaken -= int(line.split()[1])
        return {
            # 'full_text': ' Mem: {0:.2}/{1:.2} {2:.2}/{3:.2} '.format(
            #     memoryTaken / 1024 / 1024,
            #     memoryTotal / 1024 / 1024,
            #     swapTaken / 1024 / 1024,
            #     swapTotal / 1024 / 1024
            # ).replace('.', ''),
            'full_text': ' Mem: {0}% {1}% '.format(
                round(100 * memoryTaken / memoryTotal),
                round(100 * swapTaken / (swapTotal if swapTotal != 0 else 1))
            ),
            'color': '#ffffff' if memoryTaken / memoryTotal < 0.9 else '#ff0000',
        }


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

        arr.insert(1, getMemory())
        arr.insert(0, getLight())
        arr.insert(0, getMic())
        arr.insert(len(arr) - 1, getVolume())

        # TODO: make battery section urgent if low

        print(',%s' % json.dumps(arr))
