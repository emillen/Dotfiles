#!/usr/bin/env bash
# Record speech with ostt in a popup, copy the transcription to the clipboard and
# paste it into the window that was focused when the recording started.
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

# Paste the clipboard into window $1, but only if it really got focus back
paste_into() {
    i3-msg -q "[id=$1] focus" >/dev/null 2>&1 || return

    for _ in {1..20}; do
        [[ "$(xdotool getactivewindow 2>/dev/null)" == "$1" ]] && break
        sleep 0.05
    done
    sleep 0.2
    [[ "$(xdotool getactivewindow 2>/dev/null)" == "$1" ]] || return

    case "$(xprop -id "$1" WM_CLASS 2>/dev/null)" in
        *Alacritty*) xdotool key --clearmodifiers ctrl+shift+v ;;
        *) xdotool key --clearmodifiers ctrl+v ;;
    esac
}

PREVIOUS=$(xdotool getactivewindow 2>/dev/null)

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
    [[ -n "$PREVIOUS" ]] && paste_into "$PREVIOUS"
fi
rm -f "$OUT"
