#!/bin/bash

scheme_path="${XDG_CACHE_HOME:-$HOME/.cache}/caelestia/scheme/current.txt"

inotifywait -q -e 'close_write,moved_to,create' -m "$(dirname "$scheme_path")" | while read -r dir events file; do
    if test "$dir$file" = "$scheme_path"; then
        config_path="$(dirname "$0")/schemes/$(cat "$scheme_path").ini"
        if test -f "$config_path"; then
            # ex: 'regular0=0b0b0b'
            sed -n -r 's/^\w*(regular|bright)([0-9])=([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}).*/\1 \2 \3 \4 \5/p' "$config_path" |
                while read color_type idx r g b; do
                    if [ "$color_type" = 'bright' ]; then
                        idx="$((idx + 8))"
                    fi
                    echo -ne "\e]4;$idx;rgb:$r/$g/$b\e\\"
                done
            # ex: 'foreground=ffffff'
            sed -n -r 's/^\w*foreground=([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}).*/\1 \2 \3/p' "$config_path" |
                while read r g b; do
                    echo -ne "\e]10;rgb:$r/$g/$b\e\\"
                done
            # ex: 'background=0b0b0b'
            sed -n -r 's/^\w*background=([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}).*/\1 \2 \3/p' "$config_path" |
                while read r g b; do
                    echo -ne "\e]11;rgb:$r/$g/$b\e\\"
                done
        fi
    fi
done &

fish
