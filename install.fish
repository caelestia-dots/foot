#!/bin/fish

set -q XDG_CONFIG_HOME && set config $XDG_CONFIG_HOME/foot || set config $HOME/.config/foot

# Prompt if already exists
if test -d $config
    read -l -p "echo -n '$config already exists. Overwrite? [y/N] '" confirm
    if test "$confirm" = 'y' -o "$confirm" = 'Y'
        echo 'Continuing.'
        rm -rf $config
    else
        echo 'Exiting.'
        exit
    end
end

git clone 'https://github.com/caelestia-dots/foot.git' $config
sed -i 's|$SRC|'$config'|g' $config/foot.ini

echo 'Done.'
