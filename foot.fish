#!/bin/fish

set -l idx (contains -i -- -- $argv)
if test -n "$idx"
    set foot_args $argv[..(math $idx - 1)]
    set cmd $argv[(math $idx + 1)..]
else
    set cmd $argv
end
foot $foot_args -- (dirname (realpath (status filename)))/colour-switcher.sh -c "$cmd"
