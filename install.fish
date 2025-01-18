#!/bin/fish

set -q XDG_CONFIG_HOME && set conf $XDG_CONFIG_HOME || set conf $HOME/.config
set config $conf/caelestia/foot
set link $conf/foot

# Prompt if already exists
if test -e $config
    read -l -p "echo -n '$config already exists. Overwrite? [y/N] '" confirm
    if test "$confirm" = 'y' -o "$confirm" = 'Y'
        echo 'Continuing.'
        rm -rf $config
    else
        echo 'Exiting.'
        exit
    end
end

mkdir -p $config
mkdir -p ~/.local/bin
git clone 'https://github.com/caelestia-dots/foot.git' $config

if test -e $link
    read -l -p "echo -n '$link already exists. Overwrite? [y/N] '" confirm
    if test "$confirm" = 'y' -o "$confirm" = 'Y'
        echo 'Continuing.'
        rm -rf $link
    else
        echo 'Exiting.'
        exit
    end
end

cp -r $config $link
sed -i 's|$SRC|'$link'|g' $link/foot.ini
