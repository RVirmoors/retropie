#!/bin/bash
game="$1"
pushd "/home/pi/RetroPie/roms/kidz" >/dev/null
if ! grep -qs extrapath "$HOME/.config/scummvm/scummvm.ini"; then
    params="--extrapath="/opt/retropie/emulators/scummvm/extra""
fi
/opt/retropie/emulators/scummvm/bin/scummvm --config="/opt/retropie/configs/kidz/scummvm.ini" --fullscreen $params --joystick=0 "$game"
while read id desc; do
    echo "$desc" > "/home/pi/RetroPie/roms/kidz/$id.svm"
done < <(/opt/retropie/emulators/scummvm/bin/scummvm --config="/opt/retropie/configs/kidz/scummvm.ini" --list-targets | tail -n +3)
popd >/dev/null
