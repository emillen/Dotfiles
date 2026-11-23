#!/usr/bin/env bash
# Record speech with ostt in a popup and copy the transcription to the clipboard.
# Running it again while recording finishes the recording.
# Arguments: the eww command, used to color the button while the popup is up.
#
# Not using `ostt launch -c`: the xclip it starts dies with the popup terminal,
# which empties the clipboard. So write to a file and copy once the popup is gone.

OSTT="${OSTT:-$HOME/.local/bin/ostt}"
OUT="${XDG_RUNTIME_DIR:-/tmp}/ostt-button.txt"
EWW=("${@:-eww}")

# Already recording: tell ostt to stop and transcribe
pkill -USR1 -fx "$OSTT -o $OUT" && exit

trap '"${EWW[@]}" update record-color=magenta' EXIT
"${EWW[@]}" update record-color=green

# Move the pointer to the center of the popup, once i3 has placed it, so it has focus
(
    win=$(timeout 3 xdotool search --sync --onlyvisible --class '^ostt-popup$' | tail -n 1)
    sleep 0.2
    [[ -n "$win" ]] && xdotool mousemove --window "$win" --polar 0 0
) >/dev/null 2>&1 &

rm -f "$OUT"
alacritty --class ostt-popup -e "$OSTT" -o "$OUT"
"${EWW[@]}" update record-color=magenta

# Empty or missing means cancelled / nothing heard: keep the current clipboard
if [[ -s "$OUT" ]]; then
    printf '%s' "$(cat "$OUT")" | xclip -selection clipboard -in >/dev/null 2>&1
    notify-send "Copied to clipboard" "$(cat "$OUT")"
fi
rm -f "$OUT"
