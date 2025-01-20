#!/usr/bin/env bash


# @return name width height xoff yoff
x_get_monitors() {
	xrandr |
	sed -E '
		/^([^ ]*) connected /!d
		s/^([^ ]*).*[^-0-9]([-0-9]+)x([-0-9]+)\+([-0-9]+)\+([-0-9]+)[^-0-9].*$/\1 \2 \3 \4 \5/
	'
}

# @param X position X
# @param Y position Y
# @return window name and parameters for that position
x_find_monitor_for_position() {
	x_get_monitors |
	awk -v x="$1" -v y="$2" '
	function eprint(x) {
		print x > "/dev/stderr"
	}
	{ name=$1; width=$2; height=$3; xoff=$4; yoff=$5; }
	{ windows[NR]=$0 }
	x >= xoff && y >= yoff && x < xoff + width && y < yoff + height { found=1; print; exit }
	END {
		if (!found) {
			eprint("Could not find any monitor for given position: " x " " y)
			for (i in windows) {
				eprint("Window "i": "windows[i])
			}
			exit 1
		}
	}
	'
}
#
# @return windowid positionX positionY geometryX geometryY
x_get_window_geometry() {
	if (($#)); then
		xdotool getwindowgeometry "$1"
	else
		xdotool getactivewindow getwindowgeometry
	fi |
	sed -nE '
	/Window ([0-9]+).*/{
		s//\1/
		H
	}
	/.*Position: ([^,]*),([^ ]+).*/{
		s//\1 \2/
		H
	}
	/.*Geometry: ([^x]+)x([^ ]+).*/{
		s//\1 \2/
		H
		g
		s/\n/ /g
		s/^ //
		p
	}
	'
}

x_get_GTK_FRAME_EXTENTS() {
	local tmp IFS
	tmp=$(xprop -id "$1" _GTK_FRAME_EXTENTS)
	if grep -q 'not found' <<<"$tmp"; then
		echo "0 0 0 0"
	else
		echo "$(sed 's/.*=//; s/,/ /g' <<<"$tmp")"
	fi
}

x_offset_GTK_FRAME_EXTENTS() {
	local tmp
	tmp=$(x_get_GTK_FRAME_EXTENTS "$1")
	IFS=' ' read -r a c b d <<<"$tmp"
	echo $(($2 + a)) $(($3 + b)) $(($4 - a - c)) $(($5 - b - d))
}

main(){
    #current_window_geometry=$(x_get_window_geometry $WINDOWID)
    #current_window_x=$(echo $current_window_geometry  | cut -d " " -f2)
    #current_window_y=$(echo $current_window_geometry  | cut -d " " -f3)
    #
    #display=$(x_find_monitor_for_position "$current_window_x" "$current_window_y" | cut -d " " -f1)

    #echo $display >> /home/emilen/eww.log
    
    i3-msg -t get_workspaces #| jq "[.[] | select(.output==\"$display\")]" -c 
    

    i3-msg -m '["workspace"]' -t 'subscribe' | while read -r line; do
        i3-msg -t get_workspaces #| jq "[.[] | select(.output==\"$display\")]" -c
    done
}

if [[ $BASH_SOURCE == $0 ]];
then
    main "$@"
fi
