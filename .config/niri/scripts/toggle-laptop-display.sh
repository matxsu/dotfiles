#!/bin/bash
# Toggle the built-in laptop panel (eDP-1) on/off.
# niri only exposes explicit on/off, not a toggle, so we check current state via JSON.
state=$(python3 -c "
import json, subprocess
d = json.loads(subprocess.check_output(['niri', 'msg', '-j', 'outputs']))
print('on' if d.get('eDP-1', {}).get('logical') else 'off')
")

if [ "$state" = "on" ]; then
    niri msg output eDP-1 off
else
    niri msg output eDP-1 on
fi
