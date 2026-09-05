#!/bin/bash

rename_direction() {
    local old_direction="$1"
    local new_direction="$2"

    for f in gato_negro_${old_direction}[1-4].png; do
        [ -e "$f" ] || continue

        frame="${f%.png}"
        frame="${frame##*[!0-9]}"

        printf -v frame_number "%02d" "$frame"

        mv "$f" "black_${new_direction}_${frame_number}.png"
    done
}

rename_direction "norte" "north"
rename_direction "noreste" "northeast"
rename_direction "este" "east"
rename_direction "sureste" "southeast"
rename_direction "sur" "south"
rename_direction "suroeste" "southwest"
rename_direction "oeste" "west"
rename_direction "noroeste" "northwest"
