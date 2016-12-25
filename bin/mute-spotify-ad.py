#!/bin/env python2

# written on 12-23-2016 from 5AM to 7AM by Ben Heller

# http://askubuntu.com/a/451402

import glib
import dbus
from dbus.mainloop.glib import DBusGMainLoop
from subprocess import call, check_output
import os

def get_number(s):
    return [int(w) for w in s.split() if w.isdigit()][0]

lines = check_output(["pacmd", "list-sink-inputs"]).splitlines()
lines.reverse()
seen = False
index = None
was_muted = None
for line in lines:
    if "Spotify" in line and not seen:
        seen = True
    if seen and index is None and "index:" in line:
        index = get_number(line)
    if seen and was_muted is None and "muted:" in line:
        was_muted = "yes" in line

def set_muted(muted):
    call(["pacmd", "set-sink-input-mute", str(index), "1" if muted else "0"])

pid = os.getpid()

for line in check_output(["ps", "ax"]).splitlines():
    if "python2" in line and os.path.basename(__file__) in line:
        other_pid = get_number(line)
        if other_pid != pid:
            set_muted(False)
            call(["kill", str(other_pid)])
            exit()

if was_muted:
    exit()

set_muted(True)

def notifications(bus, message):
    # at the beginning this is called 2 times with length 1 and 0, respectively
    # not sure why that happens, but this ignores them
    if len(message.get_args_list()) > 1:
        set_muted(False)
        call(["kill", str(pid)])

DBusGMainLoop(set_as_default=True)

bus = dbus.SessionBus()
bus.add_match_string_non_blocking(
    "eavesdrop=true, interface='org.freedesktop.Notifications', member='Notify'"
)
bus.add_message_filter(notifications)

mainloop = glib.MainLoop()
mainloop.run()
